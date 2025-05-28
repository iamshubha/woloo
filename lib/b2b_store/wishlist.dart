import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:woloo_smart_hygiene/b2b_store/bloc/b2b_store_bloc.dart';
import 'package:woloo_smart_hygiene/b2b_store/bloc/b2b_store_event.dart';
import 'package:woloo_smart_hygiene/b2b_store/bloc/b2b_store_state.dart';
import 'package:woloo_smart_hygiene/b2b_store/ecom.dart';
import 'package:woloo_smart_hygiene/b2b_store/models/product_collections.dart';
import 'package:woloo_smart_hygiene/b2b_store/models/wishlist.dart';
import 'package:woloo_smart_hygiene/b2b_store/product_details.dart';
import 'package:woloo_smart_hygiene/utils/app_color.dart';
import 'package:woloo_smart_hygiene/utils/app_images.dart';
import 'package:woloo_smart_hygiene/widgets/nav_bar.dart';

class WishListScreen extends StatefulWidget {
  @override
  State<WishListScreen> createState() => _WishListScreenState();
}

class _WishListScreenState extends State<WishListScreen> {
  Wishlist? wishlistData;
  bool _isDataLoaded = false;
  final B2bStoreBloc _b2bStoreBloc = B2bStoreBloc();

  @override
  void initState() {
    // TODO: implement initState
    _b2bStoreBloc.add(const WishlistEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer(
        bloc: _b2bStoreBloc,
        listener: (context, state) {
          // print("dssa $state");
          if (state is WishlistLoading) {
            EasyLoading.show(status: state.message);
          }
          if (state is WishlistSuccess) {
            EasyLoading.dismiss();
            setState(() {
              wishlistData = state.wishlistData;
              _isDataLoaded = true;
              // _dashboardData = state.dashboardData;
            });
          }

          if (state is WishlistError) {
            EasyLoading.dismiss();
            EasyLoading.showError(state.error);
          }
        },
        builder: (context, snapshot) {
          return !_isDataLoaded
              ? Container()
              : Scaffold(
                  bottomNavigationBar: const XBottomBar(),
                  appBar: const EComAppbar(),
                  body: SingleChildScrollView(
                    child: Container(
                      decoration: const BoxDecoration(
                        color: AppColors.themeBackground,
                      ),
                      padding: EdgeInsets.symmetric(
                          vertical: 16.h, horizontal: 20.w),
                      child: Column(
                        spacing: 10.h,
                        children: [
                          Row(
                            children: [
                              Text("All Products",
                                  style: TextStyle(
                                      fontSize: 20.sp,
                                      fontWeight: FontWeight.bold)),
                              const Spacer(),
                              GestureDetector(
                                onTap: () {
                                  Navigator.pop(context);
                                },
                                child: const Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(
                                      Icons.arrow_back_ios_new_rounded,
                                      size: 10,
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Text(
                                      "Back",
                                      style: TextStyle(
                                          fontSize: 10,
                                          color: AppColors.greyCircleColor,
                                          fontWeight: FontWeight.bold),
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                          GridView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              crossAxisSpacing: 10,
                              mainAxisSpacing: 10,
                              childAspectRatio: 0.6,
                            ),
                            itemCount: wishlistData?.wishlist.items.length,
                            itemBuilder: (context, index) {
                              final product =
                                  wishlistData?.wishlist.items[index];
                              return GestureDetector(
                                onTap: () async {
                                  final result = await Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          ProductDetailsScreen(
                                      
                                        productData: product,
                                        isSelected: _b2bStoreBloc.favIds.any(
                                            (e) => e.containsKey(product.id)),
                                        productIdforWishList:
                                            _b2bStoreBloc.favIds.any((e) =>
                                                    e.containsKey(product.id))
                                                ? _b2bStoreBloc.favIds
                                                    .firstWhere((e) =>
                                                        e.entries.first.key ==
                                                        product.id)
                                                    .entries
                                                    .first
                                                    .value
                                        //         : "",
                                      ),
                                    ),
                                  );
                                  if (result != null && result == 'refresh') {
                                    _b2bStoreBloc.add(const WishlistEvent());
                                    print(
                                        'Returned from Page B with refresh signal (or physical back).');
                                    // _initializeData(); // Re-initialize or refresh data
                                  } else {
                                    _b2bStoreBloc.add(const WishlistEvent());
                                    print(
                                        'Returned from Page B without refresh signal or cancelled.');
                                  }
                                },
                                child: Stack(
                                  children: [
                                    Container(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 10.w),
                                      decoration: BoxDecoration(
                                          color: AppColors.themeBackground,
                                          borderRadius:
                                              BorderRadius.circular(25.r),
                                          boxShadow: const [
                                            BoxShadow(
                                              color: AppColors.greyShadowColor,
                                              blurRadius: 5.0,
                                              spreadRadius: 0.5,
                                              offset: Offset(0, 2),
                                            ),
                                            BoxShadow(
                                              color: AppColors.greyShadowColor,
                                              blurRadius: 5.0,
                                              spreadRadius: 0.5,
                                              offset: Offset(0, -1),
                                            ),
                                          ]),
                                      child: Column(
                                        spacing: 2.h,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          ClipRRect(
                                            borderRadius: BorderRadius.vertical(
                                                top: Radius.circular(25.r)),
                                            child: SizedBox(
                                              height: 165.h,
                                              width: double.infinity,
                                              child: Image.network(
                                                wishlistData
                                                        ?.wishlist
                                                        .items[index]
                                                        .productVariant
                                                        .product
                                                        .thumbnail ??
                                                    '',
                                                fit: BoxFit.contain,
                                              ),
                                            ),
                                          ),
                                          Text(
                                            wishlistData
                                                    ?.wishlist
                                                    .items[index]
                                                    .productVariant
                                                    .product
                                                    .title ??
                                                "",
                                            style: TextStyle(
                                                fontSize: 10.5.sp,
                                                fontWeight: FontWeight.bold),
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                          Text(
                                            wishlistData
                                                    ?.wishlist
                                                    .items[index]
                                                    .productVariant
                                                    .product
                                                    .subtitle ??
                                                "",
                                            style: TextStyle(
                                              fontSize: 8.sp,
                                              color: AppColors.textgreyColor,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          Row(
                                            children: List.generate(
                                              5,
                                              (i) => Container(
                                                  margin: EdgeInsets.only(
                                                      right: 2.w),
                                                  height: 10.h,
                                                  width: 10.w,
                                                  child: Image.asset(
                                                      AppImages.stars)),
                                            ),
                                          ),
                                          Row(
                                            children: [
                                              Text(
                                                "Rs. ${wishlistData?.wishlist.items[index].productVariant.calculatedPrice!.calculatedAmount.toString()}",
                                                style: TextStyle(
                                                  fontSize: 13.sp,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              const Spacer(),
                                              const AddToCartButton()
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                    Positioned(
                                      top: 20,
                                      right: 20,
                                      child: InkWell(
                                          onTap: () {},
                                          child: const Icon(
                                            // isSelected
                                            //     ?
                                            Icons.favorite_rounded,
                                            // : Icons.favorite_border_rounded,
                                            color: Colors.pink,
                                          )),
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                          SizedBox(
                            height: 60.h,
                          ),
                        ],
                      ),
                    ),
                  ),
                );
        });
  }
}
