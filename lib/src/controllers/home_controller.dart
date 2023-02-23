import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:guide/src/services/finance_service.dart';

import '../models/index.dart';

class HomeController extends GetxController {
  final financeService = FinanceService(Dio());

  HomeController() {
    getPETR4Stock();
  }

  FinanceModel? finance;

  Future<void> getPETR4Stock() async {
    final startDate = DateTime.now();
    final endDate = tradingDate(30);
    try {
      finance = await financeService.getStock('PETR4.SA', endDate, startDate);
      update();
    } on DioError catch (e) {
      debugPrint(e.message);
    }
  }

  DateTime tradingDate(int sessionsAgo) {
    var sessions = 0;

    DateTime tradingDate = DateTime.now();

    while (sessions <= sessionsAgo) {
      if ((tradingDate.weekday != 6) && (tradingDate.weekday != 7)) {
        tradingDate = tradingDate.subtract(const Duration(days: 1));
        sessions++;
      } else {
        tradingDate = tradingDate.subtract(const Duration(days: 1));
      }
    }

    return tradingDate;
  }

  double? variance(double price, double? lastPrice) {
    return lastPrice != null ? ((price / lastPrice) - 1) * 100 : null;
  }
}
