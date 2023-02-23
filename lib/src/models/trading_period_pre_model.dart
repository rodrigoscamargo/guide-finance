class TradingPeriodPreModel {
  String? timezone;
  int? start;
  int? end;
  int? gmtoffset;

  TradingPeriodPreModel({
    this.timezone,
    this.start,
    this.end,
    this.gmtoffset,
  });

  TradingPeriodPreModel.fromJson(Map<String, dynamic> json) {
    timezone = json['timezone']?.toString();
    start = json['start'];
    end = json['end'];
    gmtoffset = json['gmtoffset'];
  }

  Map<String, dynamic> toJson() {
    return {
      'timezone': timezone,
      'start': start,
      'end': end,
      'gmtoffset': gmtoffset,
    };
  }
}
