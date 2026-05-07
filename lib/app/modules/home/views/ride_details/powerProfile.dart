import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

// class PowerProfile extends StatelessWidget {
//   final List<PowerData> data = [
//     PowerData(0, 100),
//     PowerData(5.9, 100),
//     PowerData(6, 180),
//     PowerData(35.9, 180),
//     PowerData(36, 80),
//     PowerData(39.9, 80),
//   ];

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.black,
//       body: Center(
//         child: SizedBox(
//           child: Padding(
//             padding: EdgeInsets.all(10),
//             child: SfCartesianChart(
//               borderWidth: 0,
//               borderColor: Colors.transparent,
//               backgroundColor: Colors.transparent,
//               plotAreaBorderColor: Colors.transparent,
//               plotAreaBackgroundColor: Colors.transparent,
//               primaryXAxis: NumericAxis(
//                 labelAlignment: LabelAlignment.start,
//                 // title: AxisTitle(text: "Time (m)"),
//                 majorTickLines: MajorTickLines(size: 0),
//                 minorTickLines: MinorTickLines(size: 10),
//                 labelStyle: TextStyle(color: Colors.white),
//                 majorGridLines: MajorGridLines(color: Colors.transparent),
//                 minorGridLines: MinorGridLines(color: Colors.transparent),
//                 axisLine: AxisLine(color: Colors.transparent),

//                 axisLabelFormatter: (AxisLabelRenderDetails args) {
//                   return ChartAxisLabel('${args.value}m', args.textStyle);
//                 },
//               ),

//               primaryYAxis: NumericAxis(
//                 minimum: 0,
//                 maximum: 400,
//                 interval: 85,
//                 labelIntersectAction: AxisLabelIntersectAction.hide,
//                 labelStyle: TextStyle(color: Colors.white),
//                 majorTickLines: MajorTickLines(size: 0),
//                 minorTickLines: MinorTickLines(size: 10),
//                 axisLine: AxisLine(color: Colors.transparent),
//                 axisLabelFormatter: (AxisLabelRenderDetails args) {
//                   return ChartAxisLabel(
//                     '${args.value.toInt()}W',
//                     args.textStyle,
//                   );
//                 },

//                 labelAlignment: LabelAlignment.end,

//                 majorGridLines: MajorGridLines(color: Colors.transparent),
//                 minorGridLines: MinorGridLines(color: Colors.transparent),
//               ),

//               annotations: <CartesianChartAnnotation>[
//                 CartesianChartAnnotation(
//                   widget: Text(
//                     "FTP",
//                     style: TextStyle(color: Colors.orange, fontSize: 18),
//                   ),
//                   coordinateUnit: CoordinateUnit.point,
//                   x: 20,
//                   y: 300,
//                 ),
//               ],

//               series: <CartesianSeries>[
//                 /// Step Area Chart
//                 StepAreaSeries<PowerData, double>(
//                   dataSource: data,

//                   xValueMapper: (PowerData d, _) => d.time,
//                   yValueMapper: (PowerData d, _) => d.power,

//                   borderColor: Colors.lightBlue,
//                   borderWidth: 3,

//                   gradient: LinearGradient(
//                     colors: [
//                       const Color.fromARGB(255, 73, 145, 204),
//                       Colors.black,
//                     ],
//                     begin: Alignment.topCenter,
//                     end: Alignment.bottomCenter,
//                   ),
//                 ),

//                 LineSeries<PowerData, double>(
//                   dataSource: [PowerData(0, 250), PowerData(40, 250)],

//                   xValueMapper: (PowerData d, _) => d.time,
//                   yValueMapper: (PowerData d, _) => d.power,

//                   dashArray: [5, 5],

//                   color: Colors.orange,
//                   width: 2,
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

class PowerProfile extends StatelessWidget {
  final List<PowerData> data = [
    PowerData(0, 100),
    PowerData(5.9, 100),
    PowerData(6, 180),
    PowerData(20, 255),
    PowerData(25, 180),
    PowerData(35.9, 170),
    PowerData(36, 100),
    PowerData(39.9, 80),
  ];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200, // set height you want
      child: Padding(
        padding: EdgeInsets.all(10),
        child: SfCartesianChart(
          backgroundColor: Colors.transparent,
          plotAreaBackgroundColor: Colors.transparent,
          borderColor: Colors.transparent,
          borderWidth: 0,
          plotAreaBorderColor: Colors.transparent,
          primaryXAxis: NumericAxis(
            labelAlignment: LabelAlignment.start,
            majorTickLines: MajorTickLines(size: 0),
            minorTickLines: MinorTickLines(size: 0),
            axisLine: AxisLine(color: Colors.transparent),
            majorGridLines: MajorGridLines(color: Colors.transparent),
            minorGridLines: MinorGridLines(color: Colors.transparent),
            labelStyle: TextStyle(color: Colors.white),
            axisLabelFormatter: (AxisLabelRenderDetails args) {
              return ChartAxisLabel('${args.value}m', args.textStyle);
            },
          ),
          primaryYAxis: NumericAxis(
            minimum: 0,
            maximum: 400,
            interval: 85,
            majorTickLines: MajorTickLines(size: 0),
            minorTickLines: MinorTickLines(size: 0),
            axisLine: AxisLine(color: Colors.transparent),
            majorGridLines: MajorGridLines(color: Colors.transparent),
            minorGridLines: MinorGridLines(color: Colors.transparent),
            labelStyle: TextStyle(color: Colors.white),
            axisLabelFormatter: (AxisLabelRenderDetails args) {
              return ChartAxisLabel('${args.value.toInt()}W', args.textStyle);
            },
          ),
          annotations: <CartesianChartAnnotation>[
            CartesianChartAnnotation(
              widget: Text(
                "FTP",
                style: TextStyle(color: Colors.orange, fontSize: 18),
              ),
              coordinateUnit: CoordinateUnit.point,
              x: 20,
              y: 300,
            ),
          ],
          series: <CartesianSeries>[
            StepAreaSeries<PowerData, double>(
              dataSource: data,
              xValueMapper: (PowerData d, _) => d.time,
              yValueMapper: (PowerData d, _) => d.power,
              borderColor: Colors.lightBlue,
              borderWidth: 3,
              gradient: LinearGradient(
                colors: [Color.fromARGB(255, 73, 145, 204), Colors.black],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
            LineSeries<PowerData, double>(
              dataSource: [PowerData(0, 250), PowerData(40, 250)],
              xValueMapper: (PowerData d, _) => d.time,
              yValueMapper: (PowerData d, _) => d.power,
              dashArray: [5, 5],
              color: Colors.orange,
              width: 2,
            ),
          ],
        ),
      ),
    );
  }
}

class PowerData {
  final double time;
  final double power;

  PowerData(this.time, this.power);
}
