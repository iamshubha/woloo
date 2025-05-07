import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:woloo_smart_hygiene/b2b_store/cart.dart';
import 'package:woloo_smart_hygiene/b2b_store/ecom.dart';
import 'package:woloo_smart_hygiene/b2b_store/product_details.dart';
import 'package:woloo_smart_hygiene/utils/app_color.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final list = ["Pads", "Shampoo", "Wet Tissue Paper", "Hair Clips"];
    return Scaffold(
      appBar: const BackAppBar(),
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        children: [
          SizedBox(
            height: 16.h,
          ),
          const SearchBox(),
          SizedBox(
            height: 16.h,
          ),
          SearchedChipHeader(
            onTap: () {},
          ),
          SizedBox(
            height: 16.h,
          ),
          Wrap(
            runSpacing: 10,
            spacing: 10,
            children: List.generate(
              list.length,
              (i) => Chip(
                  elevation: 4,
                  backgroundColor: AppColors.themeBackground,
                  avatar: const Icon(
                    Icons.refresh,
                    color: AppColors.textgreyColor,
                  ),
                  label: Text(
                    list[i],
                    style: TextStyle(
                        fontSize: 16.sp,
                        color: AppColors.textgreyColor,
                        fontWeight: FontWeight.bold),
                  )),
            ),
          ),
          SizedBox(
            height: 16.h,
          ),
          Row(
            children: [
              Text(
                "Based on your Recent Searches",
                style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.bold),
              ),
              const Spacer(),
              SeeMoreButton(
                onTap: () {},
              )
            ],
          ),
          SizedBox(
            height: 16.h,
          ),
          const RecentSearches(),
        ],
      ),
    );
  }
}

class SearchedChipHeader extends StatelessWidget {
  const SearchedChipHeader({
    super.key,
    required this.onTap,
  });
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          "Recently Searched",
          style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.bold),
        ),
        const Spacer(),
        GestureDetector(
          onTap: () {},
          child: Text(
            "Clear",
            style: TextStyle(
              fontSize: 10.sp,
              color: AppColors.greyCircleColor,
            ),
          ),
        )
      ],
    );
  }
}

class SearchBox extends StatelessWidget {
  const SearchBox({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const XDecoratedBox(
      child: Row(
        spacing: 8,
        children: [
          SizedBox(
            height: 24,
            width: 24,
            child: Icon(Icons.search),
          ),
          Expanded(
            child: TextField(
              decoration: InputDecoration(
                isDense: true,
                isCollapsed: true,
                border: UnderlineInputBorder(),
                focusedBorder: UnderlineInputBorder(),
                hintText: "Search",
              ),
            ),
          ),
        ],
      ),
    );
  }
}
