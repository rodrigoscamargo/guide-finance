import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'package:guide/src/controllers/index.dart';
import 'package:guide/src/views/widgets/chart_variance.dart';
import 'package:intl/intl.dart';

import 'widgets/chart_d1.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final controller = Get.put(HomeController());

  ChartType chartType = ChartType.variance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.white,
        backgroundColor: Colors.white,
        title: const Text(
          'Guide Finance',
          style: TextStyle(color: Colors.black87, fontWeight: FontWeight.w600),
        ),
        elevation: 0,
        actions: [
          IconButton(
              onPressed: () {
                setState(() {
                  if (ChartType.variance == chartType) {
                    chartType = ChartType.d1;
                  } else {
                    chartType = ChartType.variance;
                  }
                });
              },
              icon: Icon(
                ChartType.variance == chartType ? Icons.show_chart_rounded : Icons.stacked_line_chart_outlined,
                color: Colors.black87,
              ))
        ],
      ),
      body: GetBuilder<HomeController>(builder: (_) {
        final finance = controller.finance;

        if (finance == null) {
          return Container();
        }
        return SingleChildScrollView(
          physics: const ClampingScrollPhysics(),
          scrollDirection: Axis.vertical,
          child: Container(
            color: Colors.white,
            padding: const EdgeInsets.only(top: 30),
            child: Column(
              children: [
                Text(finance.meta?.symbol ?? ''),
                Text(DateFormat('dd/MM/yyyy')
                    .format(DateTime.fromMillisecondsSinceEpoch(finance.meta!.regularMarketTime! * 1000))),
                if (ChartType.d1 == chartType) ChartD1(finance: finance),
                if (ChartType.variance == chartType) ChartVariance(finance: finance),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: DataTable(
                    columnSpacing: 40,
                    columns: <DataColumn>[
                      const DataColumn(
                        label: Text(
                          'N',
                          style: TextStyle(fontStyle: FontStyle.italic),
                        ),
                      ),
                      const DataColumn(
                        label: Text(
                          'Data',
                          style: TextStyle(fontStyle: FontStyle.italic),
                        ),
                      ),
                      const DataColumn(
                        label: Text(
                          'Preço',
                          style: TextStyle(fontStyle: FontStyle.italic),
                        ),
                      ),
                      if (ChartType.d1 == chartType)
                        const DataColumn(
                          label: Text(
                            'D-1',
                            style: TextStyle(fontStyle: FontStyle.italic),
                          ),
                        ),
                      if (ChartType.variance == chartType)
                        const DataColumn(
                          label: Text(
                            'Variação',
                            style: TextStyle(fontStyle: FontStyle.italic),
                          ),
                        ),
                    ],
                    rows: dataRows(),
                  ),
                )
              ],
            ),
          ),
        );
      }),
    );
  }

  List<DataRow> dataRows() {
    List<DataRow> rows = [];

    double? lastPrice;

    for (int index = 0; index < controller.finance!.indicators!.open!.length; index++) {
      final price = controller.finance!.indicators!.open![index];

      final dataRow = DataRow(
        cells: <DataCell>[
          DataCell(Text('${index + 1}')),
          DataCell(Text(DateFormat('dd/MM/yyyy')
              .format(DateTime.fromMillisecondsSinceEpoch(controller.finance!.timestamp![index] * 1000)))),
          DataCell(Text('R\$${price.toStringAsFixed(2)}')),
          if (ChartType.d1 == chartType)
            DataCell(Text(controller.variance(price, lastPrice)?.toStringAsFixed(2) != null
                ? '${controller.variance(price, lastPrice)?.toStringAsFixed(2)}%'
                : ' - ')),
          if (ChartType.variance == chartType)
            DataCell(
                Text('${controller.variance(price, controller.finance!.indicators!.open![0])!.toStringAsFixed(2)}%')),
        ],
      );

      rows.add(dataRow);

      lastPrice = price;
    }

    return rows;
  }
}

enum ChartType { variance, d1 }
