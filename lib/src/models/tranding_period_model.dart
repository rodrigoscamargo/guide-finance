import 'index.dart';

class TradingPeriodModel {
  TradingPeriodPreModel? pre;
  TradingPeriodPreModel? regular;
  TradingPeriodPreModel? post;

  TradingPeriodModel({
    this.pre,
    this.regular,
    this.post,
  });

  TradingPeriodModel.fromJson(Map<String, dynamic> json) {
    pre = json['pre'] != null ? TradingPeriodPreModel.fromJson(json['pre']) : null;
    regular = json['regular'] != null ? TradingPeriodPreModel.fromJson(json['regular']) : null;
    post = json['post'] != null ? TradingPeriodPreModel.fromJson(json['post']) : null;
  }

  Map<String, dynamic> toJson() {
    return {
      'pre': pre?.toJson(),
      'regular': regular?.toJson(),
      'post': post?.toJson(),
    };
  }
}
