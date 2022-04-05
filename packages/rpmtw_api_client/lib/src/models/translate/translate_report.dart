import 'package:rpmtw_api_client/rpmtw_api_client.dart';

class TranslateReport {
  final List<TranslatorInfo> translators;
  final DateTime start;
  final DateTime end;
  final int limit;
  final int skip;
  final int total;

  const TranslateReport(this.translators, this.start, this.end, this.limit, this.skip,
      this.total);
}
