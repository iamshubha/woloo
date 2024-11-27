



import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../utils/app_color.dart';

 class Chart extends StatefulWidget {
    final String? complatedTask;
   final String? pendingTask;
   final String? totalTask;
  const Chart({super.key,
   this.complatedTask,
   this.pendingTask,
   this.totalTask
  });

  @override
  State<Chart> createState() => _ChartState();
}

class _ChartState extends State<Chart> {
  int touchedIndex = -1;
    double? compaltedPer;
    double? pendingPer;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();


    
    // widget.complatedTask;
     var temp =    double.parse(widget.complatedTask!)/ double.parse(widget.totalTask!)*100;
     
         compaltedPer =  double.parse( temp.toStringAsFixed(2)) ;
     
    
    
    var other =
        double.parse(widget.pendingTask!)/ double.parse(widget.totalTask!)*100;

        pendingPer =   double.parse( other.toStringAsFixed(2)) ;

  }

  @override
  Widget build(BuildContext context) {
    return  
      AspectRatio(
      aspectRatio: 1.3,
      child: Row(
        children: <Widget>[
          const SizedBox(
            height: 18,
          ),
      //       AspectRatio(
      // aspectRatio: 1.3,
      // child: Row(
      //   children: <Widget>[
      //     const SizedBox(
      //       height: 18,
      //     ),

          Expanded(
            child:
             Stack(
               children: [
                 AspectRatio(
                  aspectRatio: 1,
                  child: PieChart(
                    PieChartData(
                 
                      pieTouchData: PieTouchData(
                 
                        touchCallback: (FlTouchEvent event, pieTouchResponse) {
                          setState(() {
                            if (!event.isInterestedForInteractions ||
                                pieTouchResponse == null ||
                                pieTouchResponse.touchedSection == null) {
                              touchedIndex = -1;
                              return;
                            }
                            touchedIndex = pieTouchResponse
                                .touchedSection!.touchedSectionIndex;
                          });
                        },
                      ),
                      borderData: FlBorderData(
                        show: false,
                      ),
                 
                      sectionsSpace: 0,
                      centerSpaceRadius: 45,
                      sections:
                           
                      showingSections(widget.pendingTask,widget.complatedTask ),
                    ),
                  ),
                             ),

                             Positioned(
                              top: 50.h,
                              left: 45.w,
                              child: Center(child: Text( 
                                 textAlign: TextAlign.center,
                                 " Total \n${widget.totalTask}: Task")))
               ],
             ),
          ),
          SizedBox(
            width: 20,
          ),

           Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Indicator(
                color:  Color(0xff00C3DE),
                text: '${widget.pendingTask} Pending \n Task',
                isSquare: true,
                size: 40,
              ),
              SizedBox(
                height: 20,
              ),
              Indicator(
                color:  Color(0xff006C7B),
                text: '${widget.complatedTask} Completed \n Task',
                isSquare: true,
                size: 40,
              ),
              SizedBox(
                height: 4,
              )
            ],
          ),
          const SizedBox(
            width: 28,
          ),
        ],
      ),
    );
    
  }

   List<PieChartSectionData> showingSections(  pending , complated ) {
    return List.generate(2, (i) {
      final isTouched = i == touchedIndex;
      final fontSize = isTouched ? 25.0 : 16.0;
      final radius = isTouched ? 60.0 : 50.0;
      const shadows = [Shadow(color: Colors.black, blurRadius: 2)];
      switch (i) {
        case 0:
          return PieChartSectionData(
            color:  Color(0xff006C7B),
            value: compaltedPer,
            title: '${compaltedPer}%',
            radius: radius,
            titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color:

              AppColors.containerColor,
              shadows: shadows,
            ),
          );
        case 1:
          return PieChartSectionData(
            color: Color(0xff00C3DE),
            value: pendingPer,
            title: '${pendingPer}%',
            radius: radius,
            titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: AppColors.containerColor,
              shadows: shadows,
            ),
          );
        // case 2:
        //   return PieChartSectionData(
        //     color: AppColors.red,
        //     value: 15,
        //     title: '15%',
        //     radius: radius,
        //     titleStyle: TextStyle(
        //       fontSize: fontSize,
        //       fontWeight: FontWeight.bold,
        //       color: AppColors.containerColor,
        //       shadows: shadows,
        //     ),
        //   );
        // case 3:
        //   return PieChartSectionData(
        //     color:  AppColors.greenText,
        //     value: 15,
        //     title: '15%',
        //     radius: radius,
        //     titleStyle: TextStyle(
        //       fontSize: fontSize,
        //       fontWeight: FontWeight.bold,
        //       color: AppColors.containerColor,
        //       shadows: shadows,
        //     ),
        //   );
        default:
          throw Error();
      }
    });}
}

// class PieChartSample2 extends StatefulWidget {
//    final String complatedTask;
//    final String pendingTask;
//    final String totalTask;
//   const PieChartSample2({
//     super.key, 
//    required this.complatedTask, 
//    required this.pendingTask, 
//    required this.totalTask});

//   @override
//   State<StatefulWidget> createState() => _PieChart2State();
// }

// class _PieChart2State extends State {
//   int touchedIndex = -1;

//   double? compaltedPer;
//   double? pendingPer;

//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//   widget.;
    
//     // compaltedPer =  widget.complatedTask;
//          //double.parse(widget.complatedTask);
    
//   }



//   @override
//   Widget build(BuildContext context) {
//  //  widget.

//     return
//      AspectRatio(
//       aspectRatio: 1.3,
//       child: Row(
//         children: <Widget>[
//           const SizedBox(
//             height: 18,
//           ),

//           // Expanded(
//           //   child: AspectRatio(
//           //     aspectRatio: 1,
//           //     child: PieChart(
//           //       PieChartData(
//           //         pieTouchData: PieTouchData(
//           //           touchCallback: (FlTouchEvent event, pieTouchResponse) {
//           //             setState(() {
//           //               if (!event.isInterestedForInteractions ||
//           //                   pieTouchResponse == null ||
//           //                   pieTouchResponse.touchedSection == null) {
//           //                 touchedIndex = -1;
//           //                 return;
//           //               }
//           //               touchedIndex = pieTouchResponse
//           //                   .touchedSection!.touchedSectionIndex;
//           //             });
//           //           },
//           //         ),
//           //         borderData: FlBorderData(
//           //           show: false,
//           //         ),
//           //         sectionsSpace: 0,
//           //         centerSpaceRadius: 40,
//           //         sections:
//           //
//           //         showingSections(),
//           //       ),
//           //     ),
//           //   ),
//           // ),
//           const Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: <Widget>[
//               Indicator(
//                 color:  Color(0xff00C3DE),
//                 text: '4 Tasks Done',
//                 isSquare: true,
//                 size: 40,
//               ),
//               SizedBox(
//                 height: 20,
//               ),
//               Indicator(
//                 color:  Color(0xff006C7B),
//                 text: '2 Tasks Done',
//                 isSquare: true,
//                 size: 40,
//               ),
//               SizedBox(
//                 height: 4,
//               )
//             ],
//           ),
//           const SizedBox(
//             width: 28,
//           ),
//         ],
//       ),
//     );
//   }

//   List<PieChartSectionData> showingSections(  pending , complated ) {
//     return List.generate(2, (i) {
//       final isTouched = i == touchedIndex;
//       final fontSize = isTouched ? 25.0 : 16.0;
//       final radius = isTouched ? 60.0 : 50.0;
//       const shadows = [Shadow(color: Colors.black, blurRadius: 2)];
//       switch (i) {
//         case 0:
//           return PieChartSectionData(
//             color:  AppColors.containerColor,
//             value: 40,
//             title: '40%',
//             radius: radius,
//             titleStyle: TextStyle(
//               fontSize: fontSize,
//               fontWeight: FontWeight.bold,
//               color:

//               AppColors.containerColor,
//               shadows: shadows,
//             ),
//           );
//         case 1:
//           return PieChartSectionData(
//             color: AppColors.blue,
//             value: 30,
//             title: '30%',
//             radius: radius,
//             titleStyle: TextStyle(
//               fontSize: fontSize,
//               fontWeight: FontWeight.bold,
//               color: AppColors.containerColor,
//               shadows: shadows,
//             ),
//           );
//         // case 2:
//         //   return PieChartSectionData(
//         //     color: AppColors.red,
//         //     value: 15,
//         //     title: '15%',
//         //     radius: radius,
//         //     titleStyle: TextStyle(
//         //       fontSize: fontSize,
//         //       fontWeight: FontWeight.bold,
//         //       color: AppColors.containerColor,
//         //       shadows: shadows,
//         //     ),
//         //   );
//         // case 3:
//         //   return PieChartSectionData(
//         //     color:  AppColors.greenText,
//         //     value: 15,
//         //     title: '15%',
//         //     radius: radius,
//         //     titleStyle: TextStyle(
//         //       fontSize: fontSize,
//         //       fontWeight: FontWeight.bold,
//         //       color: AppColors.containerColor,
//         //       shadows: shadows,
//         //     ),
//         //   );
//         default:
//           throw Error();
//       }
//     });
//   }
// }


// import 'package:flutter/material.dart'; 

class Indicator extends StatelessWidget {
  const Indicator({
    super.key,
    required this.color,
    required this.text,
    required this.isSquare,
    this.size = 16,
    this.textColor,
  });
  final Color color;
  final String text;
  final bool isSquare;
  final double size;
  final Color? textColor;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            
            shape: isSquare ? BoxShape.rectangle : BoxShape.circle,
            color: color,
            borderRadius: BorderRadius.circular(11.r)
          ),
        ),
        const SizedBox(
          width: 4,
        ),
        Text(
          text,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: textColor,
          ),
        )
      ],
    );
  }
}


 

