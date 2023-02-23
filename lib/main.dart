import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:guide/src/controllers/index.dart';
import 'src/views/index.dart';

void main() {
  runApp(GetMaterialApp(
    initialRoute: '/home',
    debugShowCheckedModeBanner: false,
    getPages: [
      GetPage(name: '/home', page: () => const HomePage(), binding: HomeBind()),
      //GetPage(name: '/finance', page: () => FinanceGuidePage()),
    ],
  ));
}

class HomeBind extends Binding {
  @override
  List<Bind> dependencies() {
    return [
      Bind.lazyPut<HomeController>(() => HomeController()),
    ];
  }
}
