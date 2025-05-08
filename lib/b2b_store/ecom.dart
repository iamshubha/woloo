import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_storage/get_storage.dart';
import 'package:woloo_smart_hygiene/b2b_store/bloc/b2b_store_bloc.dart';
import 'package:woloo_smart_hygiene/b2b_store/bloc/b2b_store_event.dart';
import 'package:woloo_smart_hygiene/b2b_store/bloc/b2b_store_state.dart';
import 'package:woloo_smart_hygiene/b2b_store/cart.dart';
import 'package:woloo_smart_hygiene/b2b_store/collections.dart';
import 'package:woloo_smart_hygiene/b2b_store/models/address.dart';
import 'package:woloo_smart_hygiene/b2b_store/models/product_collections.dart';
import 'package:woloo_smart_hygiene/b2b_store/models/product_details.dart';
import 'package:woloo_smart_hygiene/b2b_store/product_details.dart';
import 'package:woloo_smart_hygiene/utils/app_color.dart';
import 'package:woloo_smart_hygiene/utils/app_images.dart';
import 'package:woloo_smart_hygiene/utils/list.dart';
import 'package:woloo_smart_hygiene/widgets/address_change_bottomsheet.dart';

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
    address = getAddress();
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
          if (state is B2BStoreSuccess) {
            EasyLoading.dismiss();
            setState(() {
              _b2bStoreHomePage = state.dashboardData;
              _isDataLoaded = true;
              // _dashboardData = state.dashboardData;
            });
          }

          if (state is B2BStoreError) {
            EasyLoading.dismiss();
            EasyLoading.showError(state.error);
          }
        },
        builder: (context, snapshot) {
          return Scaffold(
            // floatingActionButton: FloatingActionButton(onPressed: () {
            //   print(_b2bStoreHomePage!.topBrands);
            // }),
            appBar: EComAppbar(
              selectedAddress: address?.address1 ?? "",
            ),
            body: SingleChildScrollView(
              child: _isDataLoaded
                  ? Column(
                      children: [
                        CategoriesSection(
                          productCategory: _b2bStoreHomePage!.productCategory,
                        ),
                        LandingProducts(
                          topBrands: _b2bStoreHomePage!.topBrands,
                          productCollections:
                              _b2bStoreHomePage!.productCollections,
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (c) => CollectionsScreen(
                                          products: _b2bStoreHomePage!
                                              .productCollections.products,
                                        )));
                          },
                        ),
                      ],
                    )
                  : Container(),
            ),
          );
        });
  }

  Addresses? getAddress() {
    address = Addresses.fromJson(jsonDecode(box.read("address")));
    // setState(() {});
    return address;
  }
}

class LandingProducts extends StatelessWidget {
  final VoidCallback? onTap;
  TopBrands topBrands;

  ProductCollections productCollections;

  LandingProducts({
    super.key,
    required this.topBrands,
    required this.productCollections,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.themeBackground,
      padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 20.w),
      child: Column(
        spacing: 10.h,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                "Top Brands",
                style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold),
              ),
              const Spacer(),
              const SeeMoreButton()
            ],
          ),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              childAspectRatio: 1.0,
            ),
            itemCount: topBrands.collections!.length > 6
                ? 6
                : topBrands.collections!.length, //.length,
            itemBuilder: (context, index) {
              return BrandsGrid(
                imageUrl: topBrands.collections![index].metadata?.image ?? '',
              );
            },
          ),
          Row(
            children: [
              Text(
                "Collections",
                style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold),
              ),
              const Spacer(),
              SeeMoreButton(
                onTap: onTap,
              )
            ],
          ),

          //product collections
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              childAspectRatio: 0.6,
            ),
            itemCount: productCollections.products.length > 8
                ? 8
                : productCollections.products.length,
            itemBuilder: (context, index) {
              return GridItem(
                products: productCollections.products[index],
                // imageUrl: productCollections.products![index].thumbnail ?? '',
              );
            },
          ),
          SizedBox(
            height: 5.h,
          ),
          Text(
            "New in Store",
            style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 130.h,
            child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemBuilder: (c, i) => ClipRRect(
                    borderRadius: BorderRadius.circular(25.r),
                    child: Image.asset(AppImages.bTemplate)),
                separatorBuilder: (c, i) => const SizedBox(
                      width: 10,
                    ),
                itemCount: 4),
          ),
        ],
      ),
    );
  }
}

class BrandsGrid extends StatelessWidget {
  const BrandsGrid({
    super.key,
    required this.imageUrl,
  });
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

class GridItem extends StatelessWidget {
  final Product products;
  // final String imageUrl;
  const GridItem({
    super.key,
    required this.products,
    // required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProductDetailsScreen(
              productData: products,
            ),
          ),
        );
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10.w),
        decoration: BoxDecoration(
            color: AppColors.themeBackground,
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
        child: Column(
          spacing: 2.h,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.vertical(top: Radius.circular(25.r)),
              child: SizedBox(
                height: 165.h,
                width: double.infinity,
                child: Image.network(
                  products.thumbnail ?? '',
                  fit: BoxFit.contain,
                ),
              ),
            ),
            Text(
              products.title ?? "",
              style: TextStyle(fontSize: 10.5.sp, fontWeight: FontWeight.bold),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            Text(
              products.subtitle ?? "",
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
                    margin: EdgeInsets.only(right: 2.w),
                    height: 10.h,
                    width: 10.w,
                    child: Image.asset(AppImages.stars)),
              ),
            ),
            Row(
              children: [
                Text(
                  "Rs. ${products.variants!.last.calculatedPrice!.calculatedAmount.toString()}",
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
    );
  }
}

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
              itemCount: productCategory.productCategories!.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                final category = Category(
                  name: productCategory.productCategories![index].name ?? '',
                  imageUrl: productCategory
                          .productCategories![index].metadata!.image ??
                      '',
                  color: Color(int.tryParse(
                          "0xFF${productCategory.productCategories![index].metadata!.backgroundColor}") ??
                      00000),
                );
                return Column(
                  children: [
                    CircleAvatar(
                      radius: 36.5.r,
                      backgroundColor: category.color,
                      child: Center(
                        child: Image.network(
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
  const EComAppbar({
    super.key,
    this.isAll = false,
    this.textFieldHintText = 'Search Products',
    this.selectedAddress = '',
  });
  final String textFieldHintText;
  final bool isAll;
  final String selectedAddress;
  @override
  Size get preferredSize => const Size.fromHeight(130);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false, // Remove default back button
      backgroundColor: AppColors.themeBackground,
      actions: [
        Badge(
          label: const Text('2'),
          child: CircleAvatar(
            backgroundColor: AppColors.greyIcon,
            child: IconButton(
              icon: ImageIcon(AssetImage(AppImages.bag)),
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (_) => const CartScreen()));
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
              builder: (_) =>
                  const AddressChangeBottomSheet(), //AddressBottomSheet
            ),
            child: Row(
              children: [
                Text(
                  selectedAddress.isEmpty ? "Select Address" : selectedAddress,
                  style: TextStyle(
                    fontSize: 12.sp,
                    color: Colors.grey,
                  ),
                ),
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
