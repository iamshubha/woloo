import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_storage/get_storage.dart';
import 'package:woloo_smart_hygiene/b2b_store/address_change_bottomsheet.dart';
import 'package:woloo_smart_hygiene/b2b_store/all_orders.dart';
import 'package:woloo_smart_hygiene/b2b_store/bloc/b2b_store_bloc.dart';
import 'package:woloo_smart_hygiene/b2b_store/bloc/b2b_store_event.dart';
import 'package:woloo_smart_hygiene/b2b_store/bloc/b2b_store_state.dart';
import 'package:woloo_smart_hygiene/b2b_store/cart.dart';
import 'package:woloo_smart_hygiene/b2b_store/collections.dart';
import 'package:woloo_smart_hygiene/b2b_store/models/address.dart';
import 'package:woloo_smart_hygiene/b2b_store/models/product_details.dart';
import 'package:woloo_smart_hygiene/b2b_store/product_details.dart';
import 'package:woloo_smart_hygiene/b2b_store/wishlist.dart';
import 'package:woloo_smart_hygiene/enums/product_mode.dart';
import 'package:woloo_smart_hygiene/extensions/string_extension.dart';
import 'package:woloo_smart_hygiene/utils/app_color.dart';
import 'package:woloo_smart_hygiene/utils/app_images.dart';
import 'package:woloo_smart_hygiene/utils/list.dart';
import 'package:woloo_smart_hygiene/utils/logger.dart';
import 'package:woloo_smart_hygiene/widgets/nav_bar.dart';

import '../hygine_services/view/address_notifier.dart';
import '../utils/app_textstyle.dart';
import 'custom_widget/start_rating.dart';

enum EcomTab { seeLess, seeAll }

class EcomScreen extends StatefulWidget {
  const EcomScreen({super.key});

  @override
  State<EcomScreen> createState() => _EcomScreenState();
}

class _EcomScreenState extends State<EcomScreen> {
  B2BStoreHomePage? _b2bStoreHomePage;
  bool _isDataLoaded = false;
  final B2bStoreBloc _b2bStoreBloc = B2bStoreBloc();
  EcomTab tab = EcomTab.seeLess;
  int currentIndex = 0;
  Addresses? address;
  final box = GetStorage();

  @override
  void initState() {
    _b2bStoreBloc.add(const StoreCustomerLoginReq(
        email: '000000000@gmail.com', pass: 'aaarati14'));
    super.initState();
    // address = getAddress();
  }

  _refresh() {
    _b2bStoreBloc.add(const Refresh());
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer(
        bloc: _b2bStoreBloc,
        listener: (context, state) {
          // print("dssa $state");
          if (state is B2BStoreLoading) {
            EasyLoading.show(status: state.message);
          }
          if (state is CartLoading) {
            EasyLoading.show(status: state.message);
          }
          if (state is B2BStoreSuccess) {
            EasyLoading.dismiss();
            setState(() {
              _b2bStoreHomePage = state.dashboardData;

              _isDataLoaded = true;

              // _dashboardData = state.dashboardData;
            });
          }
          if (state is WishlistSuccess) {
            EasyLoading.dismiss();
            _refresh();
          }
          if (state is CartSuccess) {
            EasyLoading.dismiss();
            _refresh();
          }
          if (state is B2BStoreError) {
            EasyLoading.dismiss();
            EasyLoading.showError(state.error);
          }
        },
        builder: (context, snapshot) {
          return Scaffold(
            resizeToAvoidBottomInset: false,
            bottomNavigationBar: const XBottomBar(),
            appBar: EComAppbar(
              cartValue: _isDataLoaded
                  ? _b2bStoreHomePage!.cartData.cart.items.length
                  : 0,
              onTap: () {
                _refresh();
              },
            ),
            body: SingleChildScrollView(
              child: _isDataLoaded
                  ? Column(
                      children: [
                        CategoriesSection(
                          productCategory: _b2bStoreHomePage!.productCategory,
                        ),
                        Container(
                          color: AppColors.themeBackground,
                          padding: EdgeInsets.symmetric(
                              vertical: 16.h, horizontal: 20.w),
                          child: Row(
                            children: [
                              Expanded(
                                  child: XTabButton(
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                const AllOrderScreen(),
                                          ),
                                        );
                                      },
                                      logo: AppImages.bag,
                                      label: "Order")),
                              SizedBox(
                                width: 10.w,
                              ),
                              Expanded(
                                  child: XTabButton(
                                      onTap: () async {
                                        final result = await Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (c) => WishListScreen(
                                                      productData:
                                                          _b2bStoreHomePage!
                                                              .productCollections
                                                              .products,

                                                      //          _b2bStoreBloc.favIds
                                                      // .any((e) =>
                                                      //     e.containsKey(product.id))
                                                    )));
                                        if (result != null &&
                                            result == 'refresh') {
                                          _refresh();
                                          print(
                                              'Returned from Page B with refresh signal (or physical back).');
                                        } else {
                                          _refresh();
                                          print(
                                              'Returned from Page B without refresh signal or cancelled.');
                                        }
                                      },
                                      logo: AppImages.favourites,
                                      label: "Favourites")),
                            ],
                          ),
                        ),
                        // LandingProducts(
                        //   favIds: _b2bStoreBloc.favIds,
                        //   topBrands: _b2bStoreHomePage!.topBrands,
                        //   productCollections:
                        //       _b2bStoreHomePage!.productCollections,
                        //   onTap: () {
                        //     Navigator.push(
                        //         context,
                        //         MaterialPageRoute(
                        //             builder: (c) => CollectionsScreen(
                        //                   products: _b2bStoreHomePage!
                        //                       .productCollections.products,
                        //                 )));
                        //   },
                        // ),
                        Container(
                          color: AppColors.themeBackground,
                          padding: EdgeInsets.symmetric(
                              vertical: 16.h, horizontal: 20.w),
                          child: Column(
                            spacing: 10.h,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    "Top Brands",
                                    style: TextStyle(
                                        fontSize: 20.sp,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  const Spacer(),
                                  const SeeMoreButton()
                                ],
                              ),
                              GridView.builder(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 3,
                                  crossAxisSpacing: 10,
                                  mainAxisSpacing: 10,
                                  childAspectRatio: 1.0,
                                ),
                                itemCount: _b2bStoreHomePage!
                                            .topBrands.collections!.length >
                                        6
                                    ? 6
                                    : _b2bStoreHomePage!.topBrands.collections!
                                        .length, //.length,
                                itemBuilder: (context, index) {
                                  return BrandsGrid(
                                    imageUrl: _b2bStoreHomePage!
                                            .topBrands
                                            .collections![index]
                                            .metadata
                                            ?.image ??
                                        '',
                                  );
                                },
                              ),
                              Row(
                                children: [
                                  Text(
                                    "Collections",
                                    style: TextStyle(
                                        fontSize: 20.sp,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  const Spacer(),
                                  SeeMoreButton(
                                    onTap: () async {
                                      final value = await Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (c) =>
                                                  const CollectionsScreen(
                                                      // products: _b2bStoreHomePage!
                                                      //     .productCollections
                                                      //     .products,
                                                      )));
                                      if (value != null && value == 'refresh') {
                                        _refresh();
                                      }
                                    },
                                  )
                                ],
                              ),

                              //product collections
                              GridView.builder(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 3,
                                  mainAxisSpacing: 10,
                                  crossAxisSpacing: 8,
                                  childAspectRatio: 0.5,
                                ),
                                itemCount: _b2bStoreHomePage!.productCollections
                                            .products.length >
                                        9
                                    ? 9
                                    : _b2bStoreHomePage!
                                        .productCollections.products.length,
                                itemBuilder: (context, index) {
                                  final product = _b2bStoreHomePage!
                                      .productCollections.products[index];

                                  int productCount = 0;
                                  _b2bStoreHomePage?.cartData.cart.items
                                      .forEach((i) {
                                    if (i.variantId ==
                                        product.variants![0].id) {
                                      productCount = i.quantity;
                                    }
                                  });
                                  // AddButtonMode mode = AddButtonMode.remove;
                                  return GestureDetector(
                                    onTap: () async {
                                      final result = await Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              ProductDetailsScreen(
                                            productData: product,
                                            isSelected: _b2bStoreBloc.favIds
                                                .any((e) =>
                                                    e.containsKey(product.id)),
                                            productIdforWishList: _b2bStoreBloc
                                                    .favIds
                                                    .any((e) => e.containsKey(
                                                        product.id))
                                                ? _b2bStoreBloc.favIds
                                                    .firstWhere((e) =>
                                                        e.entries.first.key ==
                                                        product.id)
                                                    .entries
                                                    .first
                                                    .value
                                                : "",
                                          ),
                                        ),
                                      );
                                      if (result != null &&
                                          result == 'refresh') {
                                        _refresh();
                                        print(
                                            'Returned from Page B with refresh signal (or physical back).');
                                        // _initializeData(); // Re-initialize or refresh data
                                      } else {
                                        _refresh();
                                        print(
                                            'Returned from Page B without refresh signal or cancelled.');
                                      }
                                    },
                                    child: Container(
                                      // padding: EdgeInsets.symmetric(horizontal: 10.w),
                                      child: Stack(
                                        children: [
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Container(
                                                height: 80.h,
                                                width: 80.h,
                                                decoration: BoxDecoration(
                                                    color: AppColors
                                                        .themeBackground,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            12.r),
                                                    boxShadow: const [
                                                      BoxShadow(
                                                        color: AppColors
                                                            .greyShadowColor,
                                                        blurRadius: 5.0,
                                                        spreadRadius: 0.5,
                                                        offset: Offset(0, 2),
                                                      ),
                                                      BoxShadow(
                                                        color: AppColors
                                                            .greyShadowColor,
                                                        blurRadius: 5.0,
                                                        spreadRadius: 0.5,
                                                        offset: Offset(0, -1),
                                                      ),
                                                    ]),
                                                child: Image.network(
                                                  product.thumbnail ?? '',
                                                  fit: BoxFit.contain,
                                                ),
                                              ),
                                              SizedBox(
                                                height: 5.h,
                                              ),
                                              Container(
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 5.w,
                                                    vertical: 2.h),
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          3.r),
                                                  color:
                                                      AppColors.lightCyanColor,
                                                ),
                                                child: Text(
                                                  "80ml",
                                                  style:
                                                      AppTextStyle.font10bold,
                                                ),
                                              ),
                                              SizedBox(
                                                height: 5.h,
                                              ),
                                              Text(
                                                product.title ?? "",
                                                style: TextStyle(
                                                    fontSize: 8.sp,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              // Text(
                                              //   products.subtitle ?? "",
                                              //   style: TextStyle(
                                              //     fontSize: 8.sp,
                                              //     color: AppColors.textgreyColor,
                                              //     fontWeight: FontWeight.bold,
                                              //   ),
                                              // ),
                                              Row(
                                                children: [
                                                  AnimatedRatingStars(
                                                    initialRating:
                                                        product.averageRating ??
                                                            0,
                                                    minRating: 0.0,
                                                    maxRating: 5.0,
                                                    filledColor: Colors.amber,
                                                    emptyColor: Colors.grey,
                                                    filledIcon: Icons.star,
                                                    halfFilledIcon:
                                                        Icons.star_half,
                                                    emptyIcon:
                                                        Icons.star_border,
                                                    onChanged: (a) {},
                                                    displayRatingValue: true,
                                                    interactiveTooltips: true,
                                                    customFilledIcon:
                                                        Icons.star,
                                                    customHalfFilledIcon:
                                                        Icons.star_half,
                                                    customEmptyIcon:
                                                        Icons.star_border,
                                                    starSize: 10,
                                                    animationDuration:
                                                        const Duration(
                                                            milliseconds: 300),
                                                    animationCurve:
                                                        Curves.easeInOut,
                                                    readOnly: false,
                                                  ),
                                                  if (product.reviewCount !=
                                                          null &&
                                                      product.reviewCount != 0)
                                                    Text(
                                                      "(${product.reviewCount ?? 0})",
                                                      style: AppTextStyle
                                                          .font10bold,
                                                    )
                                                ],
                                              ),

                                              Row(
                                                spacing: 5.w,
                                                children: [
                                                  Text(
                                                    "\u{20B9}${product.variants!.first.calculatedPrice!.calculatedAmount.toString()}",
                                                    style: TextStyle(
                                                      fontSize: 10.sp,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                  //TODO: Check Price Logic -- Abar asibo fire
                                                  Text(
                                                    "MRP ${product.variants!.first.calculatedPrice!.originalAmount.toString()}",
                                                    style: TextStyle(
                                                        decoration:
                                                            product.discountable ??
                                                                    false
                                                                ? TextDecoration
                                                                    .lineThrough
                                                                : null,
                                                        fontSize: 10.sp,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: AppColors
                                                            .textgreyColor),
                                                  ),
                                                ],
                                              )
                                            ],
                                          ),
                                          Positioned(
                                              right: 0,
                                              top: 80,
                                              child: InkWell(
                                                onTap: () async {
                                                  _b2bStoreBloc.add(AddToCart(
                                                      quantity: 1,
                                                      variant_id: product
                                                          .variants![0].id));
                                                  // if (widget.isSelected) {
                                                  //   widget.onRemove?.call();
                                                  // } else {
                                                  //   widget.onAdd?.call();
                                                  // }
                                                  // setState(() {
                                                  //   mode = AddButtonMode.add;
                                                  // });
                                                  await Future.delayed(
                                                      const Duration(
                                                          milliseconds: 500),
                                                      () {
                                                    // setState(() {
                                                    //   mode =
                                                    //       AddButtonMode.count;
                                                    // });
                                                  });

                                                  // if (widget.onTap != null) {
                                                  //   widget.onTap!();
                                                  // }
                                                  //Add to cart 1st time
                                                },
                                                borderRadius:
                                                    BorderRadius.circular(3.r),
                                                child: AnimatedContainer(
                                                  padding: EdgeInsets.symmetric(
                                                      horizontal: 5.w,
                                                      vertical: 2.h),
                                                  decoration: BoxDecoration(
                                                      border: Border.all(
                                                          color: AppColors
                                                              .buttonColor,
                                                          width: 1.5),
                                                      color: productCount == 0
                                                          ? AppColors
                                                              .themeBackground
                                                          : AppColors
                                                              .buttonYellowColor,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              3.r)),
                                                  duration: const Duration(
                                                      milliseconds: 500),
                                                  child: Center(
                                                    child: productCount == 0
                                                        // AddButtonMode.remove
                                                        ? Text(
                                                            "Add",
                                                            style: AppTextStyle
                                                                .font10bold,
                                                          )
                                                        // :
                                                        //  mode ==
                                                        //         AddButtonMode
                                                        //             .add
                                                        //     ? Text(
                                                        //         "Added",
                                                        //         style: AppTextStyle
                                                        //             .font10bold,
                                                        //       )
                                                        : Row(
                                                            spacing: 10,
                                                            children: [
                                                              InkWell(
                                                                onTap: () {
                                                                  if (productCount ==
                                                                      0) return;

                                                                  // productCount -=
                                                                  //     1;
                                                                  // if (productCount ==
                                                                  //     0) {
                                                                  //   productCount =
                                                                  //       1;
                                                                  //   // mode = AddButtonMode
                                                                  //   //     .remove;
                                                                  //   // if (widget.onRemove != null) {
                                                                  //   //   widget.onRemove!();
                                                                  //   // }
                                                                  // }

                                                                  // setState(
                                                                  //     () {});
                                                                  productCount ==
                                                                          0
                                                                      ? EasyLoading
                                                                          .showError(
                                                                              "Product count cannot be less than 0")
                                                                      : null;
                                                                  _b2bStoreHomePage
                                                                      ?.cartData
                                                                      .cart
                                                                      .items
                                                                      .forEach(
                                                                          (i) {
                                                                    if (i.variantId ==
                                                                        product
                                                                            .variants![0]
                                                                            .id) {
                                                                      productCount -=
                                                                          1;
                                                                      _b2bStoreBloc.add(AddRemoveItemReq(
                                                                          count:
                                                                              productCount,
                                                                          itemId:
                                                                              i.id));
                                                                    }
                                                                  });
                                                                },
                                                                child:
                                                                    Container(
                                                                  decoration: BoxDecoration(
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              4),
                                                                      border: Border.all(
                                                                          width:
                                                                              1,
                                                                          color:
                                                                              AppColors.black)),
                                                                  padding: const EdgeInsets
                                                                      .symmetric(
                                                                      vertical:
                                                                          2,
                                                                      horizontal:
                                                                          2),
                                                                  child:
                                                                      const Icon(
                                                                    Icons
                                                                        .remove,
                                                                    size: 8,
                                                                  ),
                                                                ),
                                                              ),
                                                              Text(
                                                                productCount
                                                                    .toString(),
                                                                style:
                                                                    AppTextStyle
                                                                        .font10,
                                                              ),
                                                              InkWell(
                                                                onTap: () {
                                                                  // productCount += 1;
                                                                  // setState(() {});
                                                                  // if (widget.onAdd != null) {
                                                                  //   widget.onAdd!();
                                                                  // }
                                                                  //  productCount == 0
                                                                  //   ? addToCart(context)
                                                                  //   :
                                                                  // To add value
                                                                  _b2bStoreHomePage
                                                                      ?.cartData
                                                                      .cart
                                                                      .items
                                                                      .forEach(
                                                                          (i) {
                                                                    if (i.variantId ==
                                                                        product
                                                                            .variants![0]
                                                                            .id) {
                                                                      productCount +=
                                                                          1;
                                                                      _b2bStoreBloc.add(AddRemoveItemReq(
                                                                          count:
                                                                              productCount,
                                                                          itemId:
                                                                              i.id));
                                                                    }
                                                                  });
                                                                },
                                                                child:
                                                                    Container(
                                                                  decoration: BoxDecoration(
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              4),
                                                                      border: Border.all(
                                                                          width:
                                                                              1,
                                                                          color:
                                                                              AppColors.black)),
                                                                  padding: const EdgeInsets
                                                                      .symmetric(
                                                                      vertical:
                                                                          2,
                                                                      horizontal:
                                                                          2),
                                                                  child:
                                                                      const Icon(
                                                                    Icons.add,
                                                                    size: 10,
                                                                  ),
                                                                ),
                                                              )
                                                            ],
                                                          ),
                                                  ),
                                                ),
                                              )
                                              // AddAnimatedButton(
                                              //   onAdd: (v) {
                                              //     productCount == 0
                                              //         ? addToCart(context)
                                              //         :
                                              //         // To add value
                                              //         cartModel?.cart.items.forEach((i) {
                                              //             if (i.variantId ==
                                              //                 widget.productData?.variants![0].id) {
                                              //               productCount += 1;
                                              //               _b2bStoreBloc.add(AddRemoveItemReq(
                                              //                   count: productCount, itemId: i.id));
                                              //             }
                                              //           });
                                              //   },
                                              //   onRemove: () {
                                              //     productCount == 0
                                              //         ? EasyLoading.showError(
                                              //             "Product count cannot be less than 0")
                                              //         : null;
                                              //     cartModel?.cart.items.forEach((i) {
                                              //       if (i.variantId == widget.productData?.variants![0].id) {
                                              //         productCount -= 1;
                                              //         _b2bStoreBloc.add(
                                              //             AddRemoveItemReq(count: productCount, itemId: i.id));
                                              //       }
                                              //     });
                                              //   },
                                              //   onTap: () {},
                                              // ))

                                              ),
                                          product.variants.first
                                                      .inventoryQuantity ==
                                                  0
                                              ? Align(
                                                  alignment:
                                                      Alignment.topCenter,
                                                  child: Container(
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            horizontal: 5.w,
                                                            vertical: 2.h),
                                                    decoration: BoxDecoration(
                                                      color: AppColors
                                                          .lightCyanColor,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              4),
                                                    ),
                                                    child: Text(
                                                      "Out of Stock",
                                                      style: TextStyle(
                                                          fontSize: 6.sp,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color:
                                                              AppColors.black),
                                                    ),
                                                  ),
                                                )
                                              : SizedBox(),
                                          // Positioned(
                                          //   // left: 8,
                                          //   // right: 8,
                                          //   child: Container(
                                          //     padding: EdgeInsets.symmetric(
                                          //         horizontal: 5.w,
                                          //         vertical: 2.h),
                                          //     decoration: BoxDecoration(
                                          //         color:
                                          //             AppColors.lightCyanColor,
                                          //         borderRadius:
                                          //             BorderRadius.circular(4)),
                                          //     child: Text(
                                          //       "Out of Stock",
                                          //       style: AppTextStyle.font10bold,
                                          //     ),
                                          //   ),
                                          // )
                                        ],
                                      ),
                                    ),

                                    //  GridItem(
                                    //   productCount: productCount,
                                    //   b2bStoreBloc: _b2bStoreBloc,
                                    //   products: product,
                                    //   cartModel:  _b2bStoreHomePage?.cartData.cart,

                                    //   isSelected: _b2bStoreBloc.favIds.any(
                                    //       (e) => e.containsKey(product.id)),
                                    //   productIdforWishList: _b2bStoreBloc.favIds
                                    //           .any((e) =>
                                    //               e.containsKey(product.id))
                                    //       ? _b2bStoreBloc.favIds
                                    //           .firstWhere((e) =>
                                    //               e.entries.first.key ==
                                    //               product.id)
                                    //           .entries
                                    //           .first
                                    //           .value
                                    //       : "",
                                    //   // imageUrl: productCollections.products![index].thumbnail ?? '',
                                    // ),
                                  );
                                },
                              ),
                              SizedBox(
                                height: 5.h,
                              ),
                              Text(
                                "New in Store",
                                style: TextStyle(
                                    fontSize: 20.sp,
                                    fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                height: 130.h,
                                child: ListView.separated(
                                    scrollDirection: Axis.horizontal,
                                    itemBuilder: (c, i) => ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(25.r),
                                        child:
                                            Image.asset(AppImages.bTemplate)),
                                    separatorBuilder: (c, i) => const SizedBox(
                                          width: 10,
                                        ),
                                    itemCount: 4),
                              ),
                            ],
                          ),
                        )
                      ],
                    )
                  : Container(),
            ),
          );
        });
  }

  Addresses? getAddress() {
    final addressData = box.read("address");
    logger.w(addressData);
    address = Addresses.fromJson(jsonDecode(addressData ?? ""));
    logger.w(address);
    // address = Addresses.fromJson(jsonDecode(addressData));
    // print(address);
    // setState(() {});
    return address;
  }
}

class XTabButton extends StatelessWidget {
  const XTabButton({
    super.key,
    required this.logo,
    required this.label,
    this.onTap,
  });
  final String logo;
  final String label;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
        decoration: BoxDecoration(
          color: AppColors.buttonYellowColor,
          borderRadius: BorderRadius.circular(4),
        ),
        child: Row(
          spacing: 10,
          children: [
            ImageIcon(
              AssetImage(logo),
              size: 20,
            ),
            Text(
              label,
              style: AppTextStyle.font14bold,
            )
          ],
        ),
      ),
    );
  }
}

class BrandsGrid extends StatelessWidget {
  const BrandsGrid({super.key, required this.imageUrl});
  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25.r),
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
      child: ClipRRect(
        borderRadius: BorderRadius.circular(25.r),
        child: imageUrl.isEmpty
            ? Image.asset(AppImages.woloologo)
            : CachedNetworkImage(
                imageUrl: imageUrl,
                fit: BoxFit.fill,
              ),
      ),
    );
  }
}

// class GridItem extends StatefulWidget {
//   final Product products;
//   final cart.Cart? cartModel;
//   // final String imageUrl;
//   final String productIdforWishList;
//   final bool isSelected;
//   final B2bStoreBloc b2bStoreBloc;
//   // final VoidCallback? onTap;
//   final int productCount;
//   const GridItem(
//       {super.key,
//       required this.products,
//       this.isSelected = false,
//       // this.onTap,
//       this.productIdforWishList = '',
//       required this.cartModel,
//       required this.b2bStoreBloc,
//       required this.productCount
//       // required this.imageUrl,
//       });

//   @override
//   State<GridItem> createState() => _GridItemState();
// }

// class _GridItemState extends State<GridItem> {
//   // final B2bStoreBloc _b2bStoreBloc = B2bStoreBloc();
//   AddButtonMode mode = AddButtonMode.remove;
//   int productCount = 1;

//   @override
//   void initState() {
//     productCount = widget.productCount;
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       // padding: EdgeInsets.symmetric(horizontal: 10.w),
//       child: Stack(
//         children: [
//           Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               Container(
//                 height: 80.h,
//                 width: 80.h,
//                 decoration: BoxDecoration(
//                     color: AppColors.themeBackground,
//                     borderRadius: BorderRadius.circular(12.r),
//                     boxShadow: const [
//                       BoxShadow(
//                         color: AppColors.greyShadowColor,
//                         blurRadius: 5.0,
//                         spreadRadius: 0.5,
//                         offset: Offset(0, 2),
//                       ),
//                       BoxShadow(
//                         color: AppColors.greyShadowColor,
//                         blurRadius: 5.0,
//                         spreadRadius: 0.5,
//                         offset: Offset(0, -1),
//                       ),
//                     ]),
//                 child: Image.network(
//                   widget.products.thumbnail ?? '',
//                   fit: BoxFit.contain,
//                 ),
//               ),
//               SizedBox(
//                 height: 5.h,
//               ),
//               Container(
//                 padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 2.h),
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(3.r),
//                   color: AppColors.lightCyanColor,
//                 ),
//                 child: Text(
//                   "80ml",
//                   style: AppTextStyle.font10bold,
//                 ),
//               ),
//               SizedBox(
//                 height: 5.h,
//               ),
//               Text(
//                 widget.products.title ?? "",
//                 style: TextStyle(fontSize: 8.sp, fontWeight: FontWeight.bold),
//               ),
//               // Text(
//               //   products.subtitle ?? "",
//               //   style: TextStyle(
//               //     fontSize: 8.sp,
//               //     color: AppColors.textgreyColor,
//               //     fontWeight: FontWeight.bold,
//               //   ),
//               // ),
//               Row(
//                 children: [
//                   AnimatedRatingStars(
//                     initialRating: 3.5,
//                     minRating: 0.0,
//                     maxRating: 5.0,
//                     filledColor: Colors.amber,
//                     emptyColor: Colors.grey,
//                     filledIcon: Icons.star,
//                     halfFilledIcon: Icons.star_half,
//                     emptyIcon: Icons.star_border,
//                     onChanged: (a) {},
//                     displayRatingValue: true,
//                     interactiveTooltips: true,
//                     customFilledIcon: Icons.star,
//                     customHalfFilledIcon: Icons.star_half,
//                     customEmptyIcon: Icons.star_border,
//                     starSize: 10,
//                     animationDuration: const Duration(milliseconds: 300),
//                     animationCurve: Curves.easeInOut,
//                     readOnly: false,
//                   ),
//                   Text(
//                     "(1288)",
//                     style: AppTextStyle.font10bold,
//                   )
//                 ],
//               ),

//               Row(
//                 spacing: 5.w,
//                 children: [
//                   Text(
//                     "\u{20B9}${widget.products.variants!.last.calculatedPrice!.calculatedAmount.toString()}",
//                     style: TextStyle(
//                       fontSize: 10.sp,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                   Text(
//                     "MRP 1299",
//                     style: TextStyle(
//                         decoration: TextDecoration.lineThrough,
//                         fontSize: 10.sp,
//                         fontWeight: FontWeight.bold,
//                         color: AppColors.textgreyColor),
//                   ),
//                 ],
//               )
//             ],
//           ),
//           Positioned(
//               right: 0,
//               top: 80,
//               child: InkWell(
//                 onTap: () async {
//                   // if (widget.isSelected) {
//                   //   widget.onRemove?.call();
//                   // } else {
//                   //   widget.onAdd?.call();
//                   // }
//                   // setState(() {
//                   //   mode = AddButtonMode.add;
//                   // });
//                   // await Future.delayed(const Duration(milliseconds: 500), () {
//                   //   setState(() {
//                   //     mode = AddButtonMode.count;
//                   //   });
//                   // });

//                   // if (widget.onTap != null) {
//                   //   widget.onTap!();
//                   // }
//                   //Add to cart 1st time
//                   widget.b2bStoreBloc.add(AddToCart(
//                       quantity: 1,
//                       variant_id: widget.products.variants![0].id));
//                 },
//                 borderRadius: BorderRadius.circular(3.r),
//                 child: AnimatedContainer(
//                   padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 2.h),
//                   decoration: BoxDecoration(
//                       border:
//                           Border.all(color: AppColors.buttonColor, width: 1.5),
//                       color: mode == AddButtonMode.remove
//                           ? AppColors.themeBackground
//                           : AppColors.buttonYellowColor,
//                       borderRadius: BorderRadius.circular(3.r)),
//                   duration: const Duration(milliseconds: 500),
//                   child: Center(
//                     child: mode == AddButtonMode.remove
//                         ? Text(
//                             "Add",
//                             style: AppTextStyle.font10bold,
//                           )
//                         : mode == AddButtonMode.add
//                             ? Text(
//                                 "Added",
//                                 style: AppTextStyle.font10bold,
//                               )
//                             : Row(
//                                 spacing: 10,
//                                 children: [
//                                   InkWell(
//                                     onTap: () {
//                                       if (productCount == 0) return;
//                                       productCount -= 1;
//                                       if (productCount == 0) {
//                                         productCount = 1;
//                                         mode = AddButtonMode.remove;
//                                         // if (widget.onRemove != null) {
//                                         //   widget.onRemove!();
//                                         // }
//                                       }

//                                       setState(() {});
//                                     },
//                                     child: Container(
//                                       decoration: BoxDecoration(
//                                           borderRadius:
//                                               BorderRadius.circular(4),
//                                           border: Border.all(
//                                               width: 1,
//                                               color: AppColors.black)),
//                                       padding: const EdgeInsets.symmetric(
//                                           vertical: 2, horizontal: 2),
//                                       child: const Icon(
//                                         Icons.remove,
//                                         size: 8,
//                                       ),
//                                     ),
//                                   ),
//                                   Text(
//                                     productCount.toString(),
//                                     style: AppTextStyle.font10,
//                                   ),
//                                   InkWell(
//                                     onTap: () {
//                                       // productCount += 1;
//                                       // setState(() {});
//                                       // if (widget.onAdd != null) {
//                                       //   widget.onAdd!();
//                                       // }
//                                       //  productCount == 0
//                                       //   ? addToCart(context)
//                                       //   :
//                                       // To add value
//                                       widget.cartModel?.items.forEach((i) {
//                                         if (i.variantId ==
//                                             widget.products.variants![0].id) {
//                                           productCount += 1;
//                                           widget.b2bStoreBloc.add(
//                                               AddRemoveItemReq(
//                                                   count: productCount,
//                                                   itemId: i.id));
//                                         }
//                                       });
//                                     },
//                                     child: Container(
//                                       decoration: BoxDecoration(
//                                           borderRadius:
//                                               BorderRadius.circular(4),
//                                           border: Border.all(
//                                               width: 1,
//                                               color: AppColors.black)),
//                                       padding: const EdgeInsets.symmetric(
//                                           vertical: 2, horizontal: 2),
//                                       child: const Icon(
//                                         Icons.add,
//                                         size: 10,
//                                       ),
//                                     ),
//                                   )
//                                 ],
//                               ),
//                   ),
//                 ),
//               )
//               // AddAnimatedButton(
//               //   onAdd: (v) {
//               //     productCount == 0
//               //         ? addToCart(context)
//               //         :
//               //         // To add value
//               //         cartModel?.cart.items.forEach((i) {
//               //             if (i.variantId ==
//               //                 widget.productData?.variants![0].id) {
//               //               productCount += 1;
//               //               _b2bStoreBloc.add(AddRemoveItemReq(
//               //                   count: productCount, itemId: i.id));
//               //             }
//               //           });
//               //   },
//               //   onRemove: () {
//               //     productCount == 0
//               //         ? EasyLoading.showError(
//               //             "Product count cannot be less than 0")
//               //         : null;
//               //     cartModel?.cart.items.forEach((i) {
//               //       if (i.variantId == widget.productData?.variants![0].id) {
//               //         productCount -= 1;
//               //         _b2bStoreBloc.add(
//               //             AddRemoveItemReq(count: productCount, itemId: i.id));
//               //       }
//               //     });
//               //   },
//               //   onTap: () {},
//               // ))

//               ),
//         ],
//       ),
//     );
//   }
// }

// class AddAnimatedButton extends StatefulWidget {
//   const AddAnimatedButton(
//       {super.key,
//       this.onTap,
//       this.onAdd,
//       this.onRemove,
//       required this.productCount});

//   final VoidCallback? onTap;
//   final VoidCallback? onAdd;
//   final VoidCallback? onRemove;
//   final int productCount; //= 1;

//   @override
//   State<AddAnimatedButton> createState() => _AddAnimatedButtonState();
// }

// class _AddAnimatedButtonState extends State<AddAnimatedButton> {
//   int productCount = 1;
//   AddButtonMode mode = AddButtonMode.remove;
//   @override
//   Widget build(BuildContext context) {
//     return
//  }
// }

class AddToCartButton extends StatelessWidget {
  const AddToCartButton({
    super.key,
    this.onTap,
  });
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(3.r),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 4.h),
        decoration: BoxDecoration(
            color: AppColors.buttonColor,
            borderRadius: BorderRadius.circular(3.r)),
        child: Row(
          children: [
            Icon(
              Icons.shopping_cart_outlined,
              color: AppColors.black,
              size: 10.sp,
            ),
            SizedBox(
              width: 5.w,
            ),
            Text(
              "Add to Cart",
              style: TextStyle(
                  fontSize: 8.sp,
                  color: AppColors.black,
                  fontWeight: FontWeight.bold),
            )
          ],
        ),
      ),
    );
  }
}

class SeeMoreButton extends StatelessWidget {
  const SeeMoreButton({
    super.key,
    this.onTap,
  });
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            "See More",
            style: TextStyle(
              fontSize: 10.sp,
              color: AppColors.greyCircleColor,
            ),
          ),
          SizedBox(
            width: 5.w,
          ),
          Container(
            height: 15.h,
            width: 15.h,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: AppColors.greyCircleColor,
                width: 1.5,
              ),
            ),
            child: const Center(
              child: Icon(
                Icons.arrow_forward_ios_rounded,
                color: AppColors.black,
                size: 12,
              ),
            ),
          )
        ],
      ),
    );
  }
}

class CategoriesSection extends StatelessWidget {
  ProductCategory productCategory;
  CategoriesSection({
    super.key,
    required this.productCategory,
  });

  @override
  Widget build(BuildContext context) {
    // logger.w(productCategory.productCategories);
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
      decoration: const BoxDecoration(
        color: AppColors.containerTabColor,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Text(
            'Categories',
            style: TextStyle(
              fontSize: 20.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 10.h),
          SizedBox(
            height: 100.h,
            child: ListView.separated(
              itemCount: productCategory.productCategories != null
                  ? productCategory.productCategories!.length
                  : 0,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                final category = Category(
                  name: productCategory.productCategories?[index].name ?? '',
                  imageUrl: productCategory
                          .productCategories?[index].metadata?.image ??
                      '',
                  color: Color(int.tryParse(
                          "0xFF${productCategory.productCategories?[index].metadata?.backgroundColor}") ??
                      00000),
                );
                return Column(
                  children: [
                    CircleAvatar(
                      radius: 36.5.r,
                      backgroundColor: category.color,
                      child: Center(
                        child: category.imageUrl.isEmptyOrNull
                            ? Image.asset(
                                AppImages.woloologo,
                                width: 40.w,
                                height: 40.h,
                              )
                            : Image.network(
                                category.imageUrl,
                                width: 40.w,
                                height: 40.h,
                              ),
                      ),
                    ),
                    SizedBox(height: 10.h),
                    Text(
                      category.name,
                      style: TextStyle(
                        fontSize: 10.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                );
              },
              separatorBuilder: (context, index) {
                return SizedBox(
                  width: 10.w,
                );
              },
            ),
          )
        ],
      ),
    );
  }
}

class EComAppbar extends StatelessWidget implements PreferredSizeWidget {
  const EComAppbar(
      {super.key,
      this.isAll = false,
      this.textFieldHintText = 'Search Products',
      this.cartValue,
      this.productMode = ProductMode.productDetails,
      this.onTap});
  final ProductMode productMode;

  final String textFieldHintText;
  final bool isAll;
  final VoidCallback? onTap;
  final int? cartValue;
  @override
  Size get preferredSize => const Size.fromHeight(130);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false, // Remove default back button
      backgroundColor: AppColors.themeBackground,
      actions: [
        cartValue != 0
            ? Badge(
                label: Text(cartValue.toString()),
                child: CircleAvatar(
                  backgroundColor: AppColors.greyIcon,
                  child: IconButton(
                    icon: ImageIcon(AssetImage(AppImages.bag)),
                    onPressed: () async {
                      final value = await Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => const CartScreen()));
                      if (value != null && value == 'refresh') {
                        if (onTap != null) {
                          onTap!();
                        }
                      }
                    },
                  ),
                ),
              )
            : Badge(
                label: const Text("0"),
                child: CircleAvatar(
                  backgroundColor: AppColors.greyIcon,
                  child: IconButton(
                    icon: ImageIcon(AssetImage(AppImages.bag)),
                    onPressed: () async {
                      final value = await Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => const CartScreen()));
                      if (value != null && value == 'refresh') {
                        if (onTap != null) {
                          onTap!();
                        }
                      }
                    },
                  ),
                ),
              ),
        SizedBox(width: 10.w),
      ],
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Home',
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          InkWell(
            onTap: () => showModalBottomSheet(
              isScrollControlled: true,
              isDismissible: true, // <-- Allow tap outside to dismiss
              enableDrag: true, // <-- Allow swipe down to dismiss

              backgroundColor: Colors
                  .transparent, // Optional: if you want rounded corners to show correctly

              context: context,
              builder: (_) => AddressChangeBottomSheet(
                productMode: productMode,
              ), //AddressBottomSheet
            ),
            child: Row(
              children: [
                ValueListenableBuilder<Addresses>(
                    valueListenable: selectedAddress,
                    builder: (context, value, child) {
                      return Text(
                        value.address1.isEmptyOrNull
                            ? "Select New Address"
                            : value.address1!,
                        style: TextStyle(
                          fontSize: 12.sp,
                          color: Colors.grey,
                        ),
                      );
                    }),
                SizedBox(width: 5.w),
                Container(
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      shape: BoxShape.circle),
                  child: const Icon(
                    Icons.arrow_drop_down,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(65),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 5.h),
          child: Row(
            children: [
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12.r),
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
                  child: TextField(
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: AppColors.themeBackground,
                      hintText: textFieldHintText,
                      prefixIcon: const Icon(Icons.search),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.r),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ),
              ),
              if (isAll) ...[
                SizedBox(
                  width: 10.w,
                ),
                Container(
                  height: 41.h,
                  width: 41.h,
                  decoration: const BoxDecoration(
                    color: AppColors.themeBackground,
                    shape: BoxShape.circle,
                    boxShadow: [
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
                    ],
                  ),
                  child: Center(
                    child: Image.asset(
                      AppImages.tuneLogo,
                      height: 20.h,
                      width: 20.w,
                    ),
                  ),
                )
              ]
            ],
          ),
        ),
      ),
    );
  }
}
