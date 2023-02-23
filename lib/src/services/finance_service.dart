import 'package:dio/dio.dart';
import 'package:guide/src/models/index.dart';

class FinanceService {
  final Dio client;

  FinanceService(this.client);

  Future<FinanceModel> getStock(String stock, DateTime start, DateTime end) async {
    final dateStart = start.millisecondsSinceEpoch ~/ 1000;
    final dateEnd = end.millisecondsSinceEpoch ~/ 1000;

    try {
      final response = await client.get(
          'https://query2.finance.yahoo.com/v8/finance/chart/PETR4.SA?symbol=PETR4.SA&period1=$dateStart&period2=$dateEnd&useYfid=true&interval=1d&includePrePost=true&events=div|split|earn&lang=en-US&region=US&crumb=uORu0Th1bcc&corsDomain=finance.yahoo.com');

      return FinanceModel.fromJson(response.data['chart']['result'][0]);
    } on DioError catch (_) {
      rethrow;
    }
  }
}
