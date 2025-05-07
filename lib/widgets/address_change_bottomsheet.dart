import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:woloo_smart_hygiene/b2b_store/cart.dart';
import 'package:woloo_smart_hygiene/utils/app_images.dart';

class AddressChangeBottomSheet extends StatelessWidget {
  const AddressChangeBottomSheet({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
      decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.75),
          borderRadius: BorderRadius.vertical(top: Radius.circular(40.r))),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        spacing: 10.h,
        children: [
          Row(
            spacing: 10.w,
            children: [
              SizedBox(
                height: 30,
                width: 30,
                child: Image.asset(AppImages.edit),
              ),
              Column(
                spacing: 10.h,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "Addresses",
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 16.sp),
                  ),
                  Text(
                    "Select or edit your addresses",
                    style: TextStyle(fontSize: 12.sp),
                  ),
                ],
              )
            ],
          ),
          SizedBox(
            height: 250,
            child: ListView.builder(
                itemCount: 3,
                itemBuilder: (c, i) {
                  return Card(
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 8),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        children: [
                          Container(
                            height: 20,
                            width: 20,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle, border: Border.all()),
                            child: Center(
                              child: Container(
                                height: 12,
                                width: 12,
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border: Border.all(),
                                    color: Colors.green),
                              ),
                            ),
                          ),
                          const Spacer(),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                "Home",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              Text(
                                "1234 Lane road, Area, Location, Landmark",
                                style: TextStyle(fontSize: 12.sp),
                              ),
                            ],
                          ),
                          const Spacer(),
                          SizedBox(
                            height: 20,
                            width: 20,
                            child: Image.asset(AppImages.edit),
                          )
                        ],
                      ),
                    ),
                  );
                }),
          ),
          const LongLabeledButton(label: "Select Address")
        ],
      ),
    );
  }
}
