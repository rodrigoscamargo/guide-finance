import 'index.dart';

class MetaModel {
  String? currency;
  String? symbol;
  String? exchangeName;
  String? instrumentType;
  int? firstTradeDate;
  int? regularMarketTime;
  int? gmtoffset;
  String? timezone;
  String? exchangeTimezoneName;
  double? regularMarketPrice;
  double? chartPreviousClose;
  double? previousClose;
  int? scale;
  int? priceHint;
  TradingPeriodModel? currentTradingPeriod;
  List<List<TradingPeriodPreModel>?>? tradingPeriods;
  String? dataGranularity;
  String? range;
  List<String>? validRanges;

  MetaModel({
    this.currency,
    this.symbol,
    this.exchangeName,
    this.instrumentType,
    this.firstTradeDate,
    this.regularMarketTime,
    this.gmtoffset,
    this.timezone,
    this.exchangeTimezoneName,
    this.regularMarketPrice,
    this.chartPreviousClose,
    this.previousClose,
    this.scale,
    this.priceHint,
    this.currentTradingPeriod,
    this.tradingPeriods,
    this.dataGranularity,
    this.range,
    this.validRanges,
  });

  MetaModel.fromJson(Map<String, dynamic> json) {
    currency = json['currency']?.toString();
    symbol = json['symbol']?.toString();
    exchangeName = json['exchangeName']?.toString();
    instrumentType = json['instrumentType']?.toString();
    firstTradeDate = json['firstTradeDate'];
    regularMarketTime = json['regularMarketTime'];
    gmtoffset = json['gmtoffset'];
    timezone = json['timezone']?.toString();
    exchangeTimezoneName = json['exchangeTimezoneName']?.toString();
    regularMarketPrice = json['regularMarketPrice']?.toDouble();
    chartPreviousClose = json['chartPreviousClose']?.toDouble();
    previousClose = json['previousClose']?.toDouble();
    scale = json['scale'];
    priceHint = json['priceHint'];
    currentTradingPeriod =
        json['currentTradingPeriod'] != null ? TradingPeriodModel.fromJson(json['currentTradingPeriod']) : null;
    if (json['tradingPeriods'] != null) {
      tradingPeriods = (json['tradingPeriods'] as List)
          .map((e) => (e as List).map((e) => TradingPeriodPreModel.fromJson(e)).toList())
          .toList();
    }
    dataGranularity = json['dataGranularity']?.toString();
    range = json['range']?.toString();
    if (json['validRanges'] != null) {
      validRanges = (json['validRanges'] as List).map<String>((e) => e.toString()).toList();
    }
  }
}
