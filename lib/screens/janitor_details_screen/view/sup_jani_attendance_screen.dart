import 'package:Woloo_Smart_hygiene/screens/janitor_details_screen/view/janitor_attendance.dart';
import 'package:Woloo_Smart_hygiene/utils/app_constants.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class SupJaniAttendanceScreen extends StatelessWidget {
  final int janiId;
  const SupJaniAttendanceScreen({super.key, required this.janiId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0,
        elevation: 0,
        title: Text(
          MyJanitorProfileScreenConstants.ATTENDANCE_HISTORY.tr(),
        ),
      ),
      body: JanitorAttendance(janiId: janiId),
    );
  }
}
