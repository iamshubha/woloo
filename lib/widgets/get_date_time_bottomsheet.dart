import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:woloo_smart_hygiene/b2b_store/cart.dart';
import 'package:woloo_smart_hygiene/utils/app_color.dart';
import 'package:woloo_smart_hygiene/utils/app_images.dart';
import 'package:woloo_smart_hygiene/utils/app_textstyle.dart';
import 'package:woloo_smart_hygiene/utils/list.dart';
import 'package:woloo_smart_hygiene/widgets/address_change_bottomsheet.dart';

class GetTimeScheduleBottomSheet extends StatefulWidget {
  const GetTimeScheduleBottomSheet({
    super.key,
  });

  @override
  State<GetTimeScheduleBottomSheet> createState() =>
      _GetTimeScheduleBottomSheetState();
}

class _GetTimeScheduleBottomSheetState
    extends State<GetTimeScheduleBottomSheet> {
  String selectedBHKValue = "";
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.6,
      // width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(40.r))),
      child: SingleChildScrollView(
        child: Column(
          spacing: 16.h,
          mainAxisSize: MainAxisSize.min,
          children: [
            const XBottmSheetTopDecor(),
            CartHeader(
              imgPath: AppImages.timeCalender,
              title: "Booking Schedule",
              subtitle: 'Select or edit your Schedule',
            ),
            const Divider(),
            LabeledFeaturePresentation(
              onTap: () {
                showDatePicker(
                    context: context,
                    firstDate: DateTime.now(),
                    lastDate: DateTime(2027));
              },
              label: "Booking Date",
              buttonHeader: "Date",
              icon: Icons.calendar_month,
            ),
            LabeledFeaturePresentation(
              onTap: () {
                showTimePicker(context: context, initialTime: TimeOfDay.now());
              },
              label: "Booking Time",
              buttonHeader: "Time",
              icon: Icons.watch_later_outlined,
            ),
            const Divider(),
            XDecoratedBox(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                spacing: 10,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Home Area",
                    style:
                        TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 40,
                    child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (c, i) => BHKSelecter(
                              onTap: () {
                                setState(() {
                                  selectedBHKValue = bhkValues[i];
                                });
                              },
                              isSelected: selectedBHKValue == bhkValues[i],
                              label: bhkValues[i],
                            ),
                        separatorBuilder: (c, i) => const SizedBox(
                              width: 10,
                            ),
                        itemCount: bhkValues.length),
                  )
                ],
              ),
            ),
            const Divider(),
            LongLabeledButton(onTap: () {}, label: "Next")
          ],
        ),
      ),
    );
  }
}

class BHKSelecter extends StatelessWidget {
  const BHKSelecter({
    super.key,
    this.onTap,
    required this.label,
    this.isSelected = false,
  });
  final VoidCallback? onTap;
  final String label;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(10.r),
      child: Container(
        height: 40,
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
        decoration: BoxDecoration(
            color: isSelected ? AppColors.lightCyanColor : Colors.grey.shade300,
            borderRadius: BorderRadius.circular(10.r)),
        child: Center(child: Text(label)),
      ),
    );
  }
}

class LabeledFeaturePresentation extends StatelessWidget {
  const LabeledFeaturePresentation({
    super.key,
    required this.label,
    required this.buttonHeader,
    this.onTap,
    required this.icon,
  });
  final String label;
  final String buttonHeader;
  final VoidCallback? onTap;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        InkWell(
          onTap: onTap,
          child: Card(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                  color: AppColors.themeBackground,
                  borderRadius: BorderRadius.circular(10.r)),
              child: Row(
                spacing: 8,
                children: [
                  Text(
                    buttonHeader,
                    style: AppTextStyle.font14bold,
                  ),
                  Icon(icon)
                ],
              ),
            ),
          ),
        )
      ],
    );
  }
}
