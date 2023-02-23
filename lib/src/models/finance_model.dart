import 'index.dart';

class FinanceModel {
  MetaModel? meta;
  List<int>? timestamp;
  QuoteModel? indicators;

  FinanceModel({
    this.meta,
    this.timestamp,
    this.indicators,
  });

  FinanceModel.fromJson(Map<String, dynamic> json) {
    meta = json['meta'] != null ? MetaModel.fromJson(json['meta']) : null;
    if (json['timestamp'] != null) {
      timestamp = (json['timestamp'] as List).map<int>((e) => e as int).toList();
    }
    indicators = json['indicators'] != null ? QuoteModel.fromJson(json['indicators']) : null;
  }
}
