import 'dart:io';
import 'dart:typed_data';

import 'package:byte_size/byte_size.dart';
import 'package:dio/dio.dart';
import 'package:rpmtw_api_client/src/models/storage/storage.dart';
import 'package:rpmtw_api_client/src/resources/base_resource.dart';
import 'package:rpmtw_api_client/src/utilities/extension.dart';

class StorageResource extends BaseResource {
  StorageResource({required Dio httpClient}) : super(httpClient: httpClient);

  /// 透過 UUID 取得檔案儲存資訊
  Future<Storage> getStorage(String uuid) async {
    Response response = await httpClient.get('/storage/$uuid');
    int statusCode = response.statusCode ?? HttpStatus.internalServerError;
    if (statusCode == HttpStatus.ok) {
      return Storage.fromJson(response.json);
    } else if (statusCode == HttpStatus.notFound) {
      throw Exception('Storage not found');
    } else {
      throw Exception('Get storage failed');
    }
  }

  /// 透過位元建立檔案儲存，如果建立成功將返回檔案儲存資訊
  Future<Storage> createStorageByBytes(Uint8List bytes) async {
    Response response = await httpClient.post('/storage/create',
        data: bytes, options: Options(contentType: 'application/octet-stream'));

    ByteSize byteSize = ByteSize.FromBytes(bytes.lengthInBytes);

    if (byteSize.MegaBytes > 8) {
      // 檔案最大只能上傳 8 MB
      throw Exception('File size is too large');
    }

    int statusCode = response.statusCode ?? HttpStatus.internalServerError;
    if (statusCode == HttpStatus.ok) {
      return Storage.fromJson(response.json);
    } else if (statusCode == HttpStatus.notFound) {
      throw Exception('Storage not found');
    } else {
      if (statusCode == HttpStatus.badRequest &&
          response.map['message'] == "File size is too large") {
        throw Exception('File size is too large');
      } else {
        throw Exception('Create storage failed');
      }
    }
  }

  /// 透過檔案建立檔案儲存，如果建立成功將返回檔案儲存資訊
  Future<Storage> createStorageByFile(File file) =>
      createStorageByBytes(file.readAsBytesSync());

  /// 透過 UUID 取得檔案儲存的位元
  Future<Uint8List> getStorageBytes(String uuid) async {
    Response response = await httpClient.get('/storage/$uuid/download',
        options: Options(responseType: ResponseType.bytes));
    int statusCode = response.statusCode ?? HttpStatus.internalServerError;
    if (statusCode == HttpStatus.ok) {
      return Uint8List.fromList(response.data);
    } else if (statusCode == HttpStatus.notFound) {
      throw Exception('Storage not found');
    } else {
      throw Exception('Download storage failed');
    }
  }

  /// 下載檔案儲存至指定路徑
  Future<void> downloadStorage(
      {required String uuid, required File file}) async {
    if (!await file.exists()) {
      // 如果檔案不存在則建立
      await file.create(recursive: true);
    }
    Uint8List bytes = await getStorageBytes(uuid);
    await file.writeAsBytes(bytes);
  }
}
