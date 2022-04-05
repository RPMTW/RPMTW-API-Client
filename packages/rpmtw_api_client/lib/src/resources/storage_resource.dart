import 'dart:typed_data';

import 'package:rpmtw_api_client/src/http/api_http_client.dart';
import 'package:rpmtw_api_client/src/http/api_http_response.dart';
import 'package:rpmtw_api_client/src/models/storage/storage.dart';
import 'package:rpmtw_api_client/src/resources/api_resource.dart';
import 'package:rpmtw_api_client/src/utilities/utility.dart';
import 'package:universal_io/io.dart';

class StorageResource extends APIResource {
  const StorageResource(APIHttpClient httpClient) : super(httpClient);

  /// Get storage info by uuid.
  ///
  /// *Parameters*
  /// - [uuid] uuid of the storage
  Future<Storage> getStorage(String uuid) async {
    APIHttpResponse response = await httpClient.get('/storage/$uuid');
    return Storage.fromMap(response.data);
  }

  /// 透過位元建立檔案儲存，如果建立成功將返回檔案儲存資訊
  Future<Storage> createStorageByBytes(Uint8List bytes) async {
    APIHttpResponse response =
        await httpClient.post('/storage/create', body: bytes, headers: {
      'Content-Type': 'application/octet-stream',
    });

    if (bytes.lengthInBytes > (8 * 1024 * 1024)) {
      // 檔案最大只能上傳 8 MB
      throw Exception('File size is too large');
    }

    return Storage.fromMap(response.data);
  }

  /// 透過檔案建立檔案儲存，如果建立成功將返回檔案儲存資訊
  Future<Storage> createStorageByFile(File file) {
    if (Utility.isWeb) {
      throw Exception('Not support StorageResource#createStorageByFile on web');
    } else {
      return createStorageByBytes(file.readAsBytesSync());
    }
  }

  /// 透過 UUID 取得檔案儲存的位元
  Future<Uint8List> getStorageBytes(String uuid) async {
    APIHttpResponse response = await httpClient.get(
      'storage/$uuid/download',
    );

    return response.bytes;
  }

  /// 下載檔案儲存至指定路徑
  Future<void> downloadStorage(
      {required String uuid, required File file}) async {
    if (Utility.isWeb) {
      throw Exception('Not support StorageResource#downloadStorage on web');
    } else {
      if (!await file.exists()) {
        // 如果檔案不存在則建立
        await file.create(recursive: true);
      }
      Uint8List bytes = await getStorageBytes(uuid);
      await file.writeAsBytes(bytes);
    }
  }
}
