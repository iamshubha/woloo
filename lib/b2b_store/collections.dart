import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:woloo_smart_hygiene/b2b_store/bloc/b2b_store_bloc.dart';
import 'package:woloo_smart_hygiene/b2b_store/bloc/b2b_store_event.dart';
import 'package:woloo_smart_hygiene/b2b_store/bloc/b2b_store_state.dart';
import 'package:woloo_smart_hygiene/b2b_store/ecom.dart';
import 'package:woloo_smart_hygiene/b2b_store/models/product_collections.dart';
import 'package:woloo_smart_hygiene/b2b_store/product_details.dart';
import 'package:woloo_smart_hygiene/utils/app_color.dart';
import 'package:woloo_smart_hygiene/widgets/nav_bar.dart';

class CollectionsScreen extends StatefulWidget {
  const CollectionsScreen({
    super.key,
  });

  @override
  State<CollectionsScreen> createState() => _CollectionsScreenState();
}

class _CollectionsScreenState extends State<CollectionsScreen> {
  final B2bStoreBloc _b2bStoreBloc = B2bStoreBloc();
  B2BStoreHomePage? _b2bStoreHomePage;
  bool _isDataLoaded = false;
  _refresh() {
    _b2bStoreBloc.add(const Refresh());
  }

  @override
  void initState() {
    _b2bStoreBloc.add(const Refresh());
    super.initState();
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
            bottomNavigationBar: const XBottomBar(),
            appBar: const EComAppbar(),
            body: _isDataLoaded
                ? SingleChildScrollView(
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
                          // GridView.builder(
                          //   shrinkWrap: true,
                          //   physics: const NeverScrollableScrollPhysics(),
                          //   gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          //     crossAxisCount: 2,
                          //     crossAxisSpacing: 10,
                          //     mainAxisSpacing: 10,
                          //     childAspectRatio: 0.6,
                          //   ),
                          //   itemCount: products.length,
                          //   itemBuilder: (context, index) {
                          //     final product = products[index];
                          //     return GridItem(
                          //       onTap: (){

                          //       },
                          //       products: product,
                          //       // imageUrl: topBrands[index].imageUrl,
                          //     );
                          //   },
                          // ),
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
                            itemCount: _b2bStoreHomePage!
                                .productCollections.products.length,
                            itemBuilder: (context, index) {
                              final product = _b2bStoreHomePage!
                                  .productCollections.products[index];
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
                                                : "",
                                      ),
                                    ),
                                  );
                                  if (result != null && result == 'refresh') {
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
                                child: GridItem(
                                  products: product,
                                  isSelected: _b2bStoreBloc.favIds
                                      .any((e) => e.containsKey(product.id)),
                                  productIdforWishList: _b2bStoreBloc.favIds
                                          .any((e) => e.containsKey(product.id))
                                      ? _b2bStoreBloc.favIds
                                          .firstWhere((e) =>
                                              e.entries.first.key == product.id)
                                          .entries
                                          .first
                                          .value
                                      : "",
                                  // imageUrl: productCollections.products![index].thumbnail ?? '',
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
                  )
                : Container(),
          );
        });
  }
}
