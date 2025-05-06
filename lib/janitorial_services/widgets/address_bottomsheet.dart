import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:woloo_smart_hygiene/b2b_store/cart.dart';
import 'package:woloo_smart_hygiene/janitorial_services/screens/host_dashboard_screen.dart';
import 'package:woloo_smart_hygiene/utils/app_color.dart';
import 'package:woloo_smart_hygiene/utils/app_textstyle.dart';

class AddressBottomSheet extends StatelessWidget {
  const AddressBottomSheet({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BottomSheet(
        onClosing: () {},
        builder: (context) {
          return Container(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius:
                    BorderRadius.vertical(top: Radius.circular(40.r))),
            child: Column(
              spacing: 10,
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  height: 20.h,
                ),
                Row(
                  spacing: 10,
                  children: [
                    const Icon(Icons.arrow_back_sharp),
                    SizedBox(width: 10.w),
                    Text(
                      "Add Address",
                      style: AppTextStyle.font14bold,
                    ),
                  ],
                ),
                const Row(
                  spacing: 10,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: XDecoratedBox(
                        padding: 4,
                        child: XDesignedTextField(
                          hintText: "First Name",
                        ),
                      ),
                    ),
                    Expanded(
                        child: XDecoratedBox(
                      padding: 4,
                      child: XDesignedTextField(
                        hintText: "Last Name",
                      ),
                    )),
                  ],
                ),
                const Row(
                  spacing: 10,
                  children: [
                    Expanded(
                        child: XDecoratedBox(
                      padding: 4,
                      child: XDesignedTextField(
                        hintText: "Flat No.",
                      ),
                    )),
                    Expanded(
                        child: XDecoratedBox(
                      padding: 4,
                      child: XDesignedTextField(
                        hintText: "Locality",
                      ),
                    ))
                  ],
                ),
                const XDecoratedBox(
                  padding: 4,
                  child: XDesignedTextField(
                    hintText: "Appartment Name/Road/area",
                  ),
                ),
                const XDecoratedBox(
                  padding: 4,
                  child: XDesignedTextField(
                    hintText: "City",
                  ),
                ),
                const XDecoratedBox(
                  padding: 4,
                  child: XDesignedTextField(
                    hintText: "Pincode",
                  ),
                ),
                const XDecoratedBox(
                  padding: 4,
                  child: XDesignedTextField(
                    hintText: "Phone",
                  ),
                ),
                const XDecoratedBox(
                  padding: 4,
                  child: XDesignedTextField(
                    hintText: "Save as (Home/Office/Others)",
                  ),
                ),
                const LongLabeledButton(
                  label: "Submit",
                  color: AppColors.buttonYellowColor,
                )
              ],
            ),
          );
        });
  }
}
