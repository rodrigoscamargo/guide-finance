import 'index.dart';

class IndicatorsModel {
  List<QuoteModel>? quote;

  IndicatorsModel({
    this.quote,
  });

  IndicatorsModel.fromJson(Map<String, dynamic> json) {
    if (json['quote'] != null) {
      quote = (json['quote'] as List).map((e) => QuoteModel.fromJson(e)).toList();
    }
  }
}
