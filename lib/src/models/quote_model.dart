class QuoteModel {
  List<double>? high;
  List<double>? close;
  List<double>? open;
  List<int>? volume;
  List<double>? low;

  QuoteModel({
    this.high,
    this.close,
    this.open,
    this.volume,
    this.low,
  });

  QuoteModel.fromJson(Map<String, dynamic> json) {
    if (json['quote'] != null) {
      high = ((json['quote'][0] as Map<String, dynamic>)['high'] as List).map<double>((e) => e.toDouble()).toList();
    }
    if (json['quote'] != null) {
      close = ((json['quote'][0] as Map)['close'] as List).map<double>((e) => e.toDouble()).toList();
    }
    if (json['quote'] != null) {
      open = ((json['quote'][0] as Map)['open'] as List).map<double>((e) => e.toDouble()).toList();
    }
    if (json['quote'] != null) {
      volume = ((json['quote'][0] as Map)['volume'] as List).map<int>((e) => e as int).toList();
    }
    if (json['quote'] != null) {
      low = ((json['quote'][0] as Map)['low'] as List).map<double>((e) => e.toDouble()).toList();
    }
  }
}
