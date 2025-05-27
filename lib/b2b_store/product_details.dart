import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:woloo_smart_hygiene/b2b_store/bloc/b2b_store_bloc.dart';
import 'package:woloo_smart_hygiene/b2b_store/bloc/b2b_store_event.dart';
import 'package:woloo_smart_hygiene/b2b_store/bloc/b2b_store_state.dart';
import 'package:woloo_smart_hygiene/b2b_store/cart.dart';
import 'package:woloo_smart_hygiene/b2b_store/ecom.dart';
import 'package:woloo_smart_hygiene/b2b_store/models/cart.dart' as cart_model;
import 'package:woloo_smart_hygiene/b2b_store/models/customer_reviews.dart';
import 'package:woloo_smart_hygiene/b2b_store/models/product_collections.dart'
    as product_collections;
import 'package:woloo_smart_hygiene/utils/app_color.dart';
import 'package:woloo_smart_hygiene/utils/app_images.dart';
import 'package:woloo_smart_hygiene/utils/list.dart';
import 'package:woloo_smart_hygiene/utils/logger.dart';
import 'package:woloo_smart_hygiene/widgets/cart_bottomsheet.dart';

class ProductDetailsScreen extends StatefulWidget {
  final product_collections.Product? productData;
  ProductDetailsScreen(
      {super.key,
      this.productData,
      required this.isSelected,
      this.productIdforWishList = ''});
  final bool isSelected;
  String productIdforWishList;
  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  final B2bStoreBloc _b2bStoreBloc = B2bStoreBloc();
  bool _isDataLoaded = false;
  cart_model.CartModel? cartModel;
  int productCount = 0;
  late bool isSelected;
  CustomerReviews? customerReviews;
  @override
  initState() {
    super.initState();

    _b2bStoreBloc.add(const GetCartData());
    logger.w(widget.productData?.id);
    _b2bStoreBloc.add(GetOrderReview(productId: widget.productData?.id ?? ''));
    isSelected = widget.isSelected;
  }

  @override
  Widget build(BuildContext context) {
    final sizeList = ["S", "M", "L", "XL"];
    return BlocConsumer(
      bloc: _b2bStoreBloc,
      listener: (context, state) {
        if (state is CartLoading) {
          EasyLoading.show(status: state.message);
        }

        // if (state is WishlistLoading) {
        //   EasyLoading.show(status: state.message);
        // }
        if (state is CartSuccess) {
          EasyLoading.dismiss();
          setState(() {
            cartModel = state.cartData;
            cartModel?.cart.items.forEach((i) {
              if (i.variantId == widget.productData?.variants![0].id) {
                productCount = i.quantity;
              }
            });
            // print(state.cartData.cart);
            // _addressesData = state.addressesData;
            // _b2bStoreHomePage = state.dashboardData;

            _isDataLoaded = true;
            // _dashboardData = state.dashboardData;
          });
        }

        if (state is WishlistSuccess) {
          EasyLoading.dismiss();
          logger.w(state);
          // widget.productData?.id ==
          //     state.wishlistData.wishlist.items.first.productVariant.productId;
          final data = state.wishlistData.wishlist.items.firstWhere((item) =>
              item.productVariant.productId == widget.productData?.id);

          setState(() {
            widget.productIdforWishList = data.id;
          });
        }

        if (state is CustomerReviewSuccess) {
          customerReviews = state.customerReview;
          logger.w(customerReviews);
        }

        if (state is CartError) {
          EasyLoading.dismiss();
          EasyLoading.showError(state.error);
        }

        // if (state is WishlistError) {
        //   EasyLoading.dismiss();
        //   EasyLoading.showError(state.error);
        // }

        // if (state is ReadyToShip) {
        //   EasyLoading.dismiss();
        //   showCartBottomSheet(context);
        // }
      },
      builder: (context, state) {
        return !_isDataLoaded
            ? Container()
            : Scaffold(
                bottomSheet: XDecoratedBox(
                  child: Row(
                    children: [
                      Expanded(
                        child: LongLabeledButton(
                          onTap: () async {
                            if (productCount == 0) {
                              final val = await addToCart(context);
                              EasyLoading.show(status: "loading...");
                              await Future.delayed(Duration(seconds: 2));
                              EasyLoading.dismiss();
                              if (val) {
                                showCartBottomSheet(context);
                              }
                              return;
                            } else {
                              showCartBottomSheet(context);
                            }
                          },
                          label: "Buy Now",
                        ),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      Expanded(
                        child: LongLabeledButton(
                          onTap: () {
                            addToCart(context);
                          },
                          label: "Add to Cart",
                        ),
                      ),
                    ],
                  ),
                ),
                appBar: const BackAppBar(),
                body: SingleChildScrollView(
                  padding:
                      EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
                  child: Column(
                    spacing: 16.h,
                    children: [
                      ImageView(
                        imageUrl: widget.productData?.thumbnail ?? '',
                        onTap: () {
                          if (!isSelected) {
                            _b2bStoreBloc.add(AddToWishList(
                              variantId:
                                  widget.productData?.variants![0].id ?? '',
                            ));
                          } else {
                            _b2bStoreBloc.add(RemoveWishList(
                                itemId: widget.productIdforWishList));
                          }

                          isSelected = !isSelected;
                          setState(() {});
                        },
                        isSelected: isSelected,
                      ),
                      Column(
                        spacing: 10.h,
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Row(
                                children: List.generate(
                                  5,
                                  (index) => Container(
                                    margin: const EdgeInsets.only(left: 2),
                                    height: 15,
                                    child: Image.asset(
                                      AppImages.stars,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              Text(
                                "(5)",
                                style: TextStyle(
                                    fontSize: 20.sp,
                                    fontWeight: FontWeight.bold),
                              ),
                              Container(
                                height: 20,
                                width: 20,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                      color: AppColors.alertShadowColor),
                                ),
                                child: const Center(
                                  child: Icon(
                                    Icons.arrow_forward_ios_outlined,
                                    size: 15,
                                  ),
                                ),
                              ),
                              const Spacer(),
                              CartAddRemove(
                                value: productCount,
                                onAdd: () {
                                  productCount == 0
                                      ? addToCart(context)
                                      :
                                      // To add value
                                      cartModel?.cart.items.forEach((i) {
                                          if (i.variantId ==
                                              widget.productData?.variants![0]
                                                  .id) {
                                            productCount += 1;
                                            _b2bStoreBloc.add(AddRemoveItemReq(
                                                count: productCount,
                                                itemId: i.id));
                                          }
                                        });
                                  // setState(() {});
                                },
                                onRemove: () {
                                  productCount == 0
                                      ? EasyLoading.showError(
                                          "Product count cannot be less than 0")
                                      : null;
                                  // if (productCount == 1) {
                                  //   // EasyLoading.showError(
                                  //   //     "Product count cannot be less than 0");
                                  //   cartModel?.cart.items.forEach((i) {
                                  //     if (i.variantId ==
                                  //         widget.productData?.variants![0].id) {
                                  //       _b2bStoreBloc
                                  //           .add(DeleteItemReq(itemId: i.id));
                                  //     }
                                  //   });
                                  //   return;
                                  // }
                                  cartModel?.cart.items.forEach((i) {
                                    if (i.variantId ==
                                        widget.productData?.variants![0].id) {
                                      productCount -= 1;
                                      _b2bStoreBloc.add(AddRemoveItemReq(
                                          count: productCount, itemId: i.id));
                                    }
                                  });
                                },
                              )
                            ],
                          ),
                          Text(
                            widget.productData?.title ?? "",
                            style: TextStyle(
                                fontSize: 20.sp, fontWeight: FontWeight.bold),
                          ),
                          Row(
                            children: [
                              Text(
                                "Rs. ${widget.productData?.variants![0].calculatedPrice!.calculatedAmount.toString()}",
                                // "Rs. ${productData.variants!.last.calculatedPrice!.calculatedAmount.toString()}",

                                // "Rs. 799",
                                style: TextStyle(
                                    fontSize: 36.sp,
                                    fontWeight: FontWeight.bold),
                              ),
                              const Spacer(),
                              ShortLabelledButton(
                                onTap: () async {
                                  if (productCount == 0) {
                                    final val = await addToCart(context);
                                    EasyLoading.show(status: "loading...");
                                    await Future.delayed(Duration(seconds: 2));
                                    EasyLoading.dismiss();
                                    if (val) {
                                      showCartBottomSheet(context);
                                    }
                                    return;
                                  } else {
                                    showCartBottomSheet(context);
                                  }
                                },
                              )
                            ],
                          ),
                          Text(
                            widget.productData?.subtitle ?? "",
                            style: TextStyle(
                                color: AppColors.textgreyColor,
                                fontSize: 20.sp,
                                fontWeight: FontWeight.bold),
                          ),
                          const Divider(
                            thickness: 2,
                          ),
                          Text(
                            "Description",
                            style: TextStyle(
                                // color: AppColors.textgreyColor,
                                fontSize: 20.sp,
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            widget.productData?.description ?? "",
                            style: TextStyle(
                                // color: AppColors.textgreyColor,
                                fontSize: 14.sp,
                                fontWeight: FontWeight.bold),
                          ),
                          // const Divider(
                          //   thickness: 2,
                          // ),
                        ],
                      ),

                      // const ProductTitleDesc(),
                      // const XColorsSelection(),
                      // SizeWidget(sizeList: sizeList),
                      const Divider(
                        thickness: 2,
                      ),
                      const HomeAddress(),
                      const Divider(
                        thickness: 2,
                      ),
                      Row(
                        children: [
                          Text(
                            "Based on your Recent Searches",
                            style: TextStyle(
                                fontSize: 14.sp, fontWeight: FontWeight.bold),
                          ),
                          const Spacer(),
                          SeeMoreButton(
                            onTap: () {},
                          )
                        ],
                      ),
                      const RecentSearches(),
                      if (customerReviews?.reviews.isNotEmpty ?? false)
                        Row(
                          children: [
                            Text(
                              "Ratings & Reviews",
                              style: TextStyle(
                                  fontSize: 14.sp, fontWeight: FontWeight.bold),
                            ),
                            const Spacer(),
                            SeeMoreButton(
                              onTap: () {},
                            )
                          ],
                        ),
                      ListView.separated(
                        itemCount: customerReviews?.reviews.length ?? 0,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (c, i) {
                          final review = customerReviews?.reviews[i];
                          return ReviewCard(
                              name: review?.customer?.firstName ?? "Customer",
                              date: review?.formattedCreatedAt ?? "",
                              rating: review?.rating?.toDouble() ?? 0.0,
                              review: review?.comment ?? "No review provided");
                        },
                        separatorBuilder: (c, i) {
                          return const SizedBox(
                            height: 10,
                          );
                        },
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                    ],
                  ),
                ),
              );
      },
    );
  }

  void showCartBottomSheet(BuildContext context) {
    // _b2bStoreBloc.add(const ProceedToShip());
    // await Future.delayed(Duration(seconds: 2));
    showModalBottomSheet(
      isScrollControlled: true,
      isDismissible: true, // <-- Allow tap outside to dismiss
      enableDrag: true, // <-- Allow swipe down to dismiss

      backgroundColor: Colors
          .transparent, // Optional: if you want rounded corners to show correctly

      context: context,
      builder: (_) => CartBottomSheet(
        onTap: () {
          _b2bStoreBloc.add(const GetCartData());
          logger.w(widget.productData?.id);
          _b2bStoreBloc
              .add(GetOrderReview(productId: widget.productData?.id ?? ''));
          isSelected = widget.isSelected;
        },
      ), //AddressBottomSheet
    );
  }

  Future<bool> addToCart(BuildContext context) async {
    try {
      _b2bStoreBloc.add(AddToCart(
          quantity: 1, variant_id: widget.productData?.variants![0].id));

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Item added to cart!'),
        ),
      );
      return true;
    } catch (e) {
      return false;
    }
  }
}

class ShortLabelledButton extends StatelessWidget {
  const ShortLabelledButton({
    super.key,
    this.onTap,
    this.label = "Buy Now",
  });
  final String label;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(8),
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 5.h),
        decoration: BoxDecoration(
            color: AppColors.lightCyanColor,
            borderRadius: BorderRadius.circular(8)),
        child: Center(
          child: Text(
            label,
            style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}

class RecentSearches extends StatelessWidget {
  const RecentSearches({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 230.h,
      width: double.infinity,
      child: ListView.separated(
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          itemBuilder: (c, i) => HorizontalListTile(
                imgURL: topBrands[i].imageUrl,
              ),
          separatorBuilder: (c, i) => const SizedBox(
                width: 10,
              ),
          itemCount: topBrands.length),
    );
  }
}

class HomeAddress extends StatelessWidget {
  const HomeAddress({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
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
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              Text(
                "Address - Home",
                style: TextStyle(fontSize: 15.sp, fontWeight: FontWeight.bold),
              ),
              const Spacer(),
              Text(
                "Change",
                style: TextStyle(
                    color: AppColors.textgreyColor,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.bold),
              )
            ],
          ),
          const Row(
            children: [
              Expanded(
                flex: 2,
                child: Divider(
                  thickness: 2,
                ),
              ),
              Spacer(
                flex: 4,
              )
            ],
          ),
          Text(
            "1234 Lane road, Area, Location, Landmark",
            style: TextStyle(fontSize: 14.sp, color: AppColors.textgreyColor),
          )
        ],
      ),
    );
  }
}

class ReviewCard extends StatelessWidget {
  const ReviewCard({
    super.key,
    required this.name,
    required this.date,
    required this.rating,
    required this.review,
  });

  final String name;
  final String date;
  final double rating;
  final String review;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.w),
      margin: EdgeInsets.symmetric(vertical: 8.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 5,
            spreadRadius: 1,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const CircleAvatar(
                radius: 20,
                backgroundColor: Colors.grey, // Placeholder for profile image
              ),
              SizedBox(width: 10.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      "Posted on $date",
                      style: TextStyle(
                        fontSize: 12.sp,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                children: [
                  Icon(
                    Icons.star,
                    color: Colors.amber,
                    size: 16.sp,
                  ),
                  SizedBox(width: 4.w),
                  Text(
                    rating.toStringAsFixed(1),
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const Divider(
            thickness: 1,
            height: 20,
          ),
          Text(
            review,
            style: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }
}

class HorizontalListTile extends StatelessWidget {
  const HorizontalListTile({
    super.key,
    required this.imgURL,
  });
  final String imgURL;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 165.w,
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
              child: Image.asset(
                imgURL,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Text(
            "vurky room freshner",
            style: TextStyle(fontSize: 10.5.sp, fontWeight: FontWeight.bold),
          ),
          Text(
            "vurky",
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
                "Rs. 799",
                style: TextStyle(
                  fontSize: 13.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Spacer(),
              Container(
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
              )
            ],
          )
        ],
      ),
    );
  }
}

class SizeWidget extends StatelessWidget {
  const SizeWidget({
    super.key,
    required this.sizeList,
  });

  final List<String> sizeList;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
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
        // spacing: 10.h,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 10.h,
          ),
          Text(
            "Size",
            style: TextStyle(fontSize: 15.sp, fontWeight: FontWeight.bold),
          ),
          const Row(
            children: [
              Expanded(
                flex: 2,
                child: Divider(
                  thickness: 2,
                ),
              ),
              Spacer(
                flex: 4,
              ),
            ],
          ),
          SizedBox(
            height: 26,
            child: ListView.separated(
              itemCount: sizeList.length,
              separatorBuilder: (context, index) {
                return const SizedBox(
                  width: 5,
                );
              },
              scrollDirection: Axis.horizontal,
              itemBuilder: (c, i) => Container(
                height: 30,
                width: 30,
                decoration: BoxDecoration(boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.1),
                    spreadRadius: 1,
                    blurRadius: 5,
                    offset: const Offset(0, 3),
                  ),
                ], shape: BoxShape.circle, color: Colors.white),
                child: Center(
                  child: Text(sizeList[i]),
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }
}

class XColorsSelection extends StatelessWidget {
  const XColorsSelection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
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
        // spacing: 10.h,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 10.h,
          ),
          Text(
            "Colours",
            style: TextStyle(fontSize: 15.sp, fontWeight: FontWeight.bold),
          ),
          const Row(
            children: [
              Expanded(
                flex: 2,
                child: Divider(
                  thickness: 2,
                ),
              ),
              Spacer(
                flex: 4,
              ),
            ],
          ),
          SizedBox(
            height: 26,
            child: ListView.separated(
              itemCount: 10,
              separatorBuilder: (context, index) {
                return const SizedBox(
                  width: 5,
                );
              },
              scrollDirection: Axis.horizontal,
              itemBuilder: (c, i) => Container(
                height: 26,
                width: 26,
                decoration: const BoxDecoration(
                    shape: BoxShape.circle, color: Colors.red),
                child: const Center(
                  child: Icon(Icons.check),
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }
}

class CartAddRemove extends StatelessWidget {
  const CartAddRemove({
    super.key,
    this.onRemove,
    this.onAdd,
    this.value = 1,
  });
  final VoidCallback? onRemove;
  final VoidCallback? onAdd;
  final int value;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
          color: AppColors.lightCyanColor,
          borderRadius: BorderRadius.circular(4)),
      child: Row(
        spacing: 7,
        children: [
          XAddRemove(
            onTap: onRemove,
            // if (productCount <= 1) return;
            // _b2bStoreBloc.add(AddRemoveItemReq(
            //     itemId: widget.productId, count: productCount));
            // setState(() {
            //   productCount--;
            // });

            icon: Icons.remove,
          ),
          const SizedBox(
            width: 15,
          ),
          const Icon(
            Icons.shopping_cart,
            size: 22,
          ),
          Text(
            value.toString(),
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            width: 15,
          ),
          XAddRemove(
            onTap: onAdd,
            icon: Icons.add,
          ),
        ],
      ),
    );
  }
}

class XAddRemove extends StatelessWidget {
  const XAddRemove({
    super.key,
    this.onTap,
    required this.icon,
  });
  final VoidCallback? onTap;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4),
            border: Border.all(width: 2, color: AppColors.black)),
        padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 2),
        child: Icon(
          icon,
          size: 15,
        ),
      ),
    );
  }
}

class ImageView extends StatelessWidget {
  final String imageUrl;
  const ImageView(
      {super.key, required this.imageUrl, this.onTap, this.isSelected = false});
  final VoidCallback? onTap;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 382,
      width: 382,
      decoration: BoxDecoration(
        color: Colors.red,
        borderRadius: BorderRadius.circular(47),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius:
            BorderRadius.circular(47), // Match the container's border radius
        child: Stack(
          children: [
            Image.network(
              imageUrl,
              fit: BoxFit.cover, // Ensures the image fills the container
              height: 382, // Match the container's height
              width: 382, // Match the container's width
            ),
            Positioned(
              top: 20,
              right: 20,
              child: InkWell(
                  onTap: onTap,
                  child: Icon(
                    isSelected
                        ? Icons.favorite_rounded
                        : Icons.favorite_border_rounded,
                    color: isSelected ? Colors.pink : null,
                  )),
            ),
          ],
        ),
      ),
    );
  }
}

class BackAppBar extends StatelessWidget implements PreferredSizeWidget {
  const BackAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white, // Matches the design
      elevation: 0, // Removes shadow for a flat look
      leadingWidth: 100, // Adjust width for the "Back" button
      leading: GestureDetector(
        onTap: () {
          Navigator.pop(context); // Navigate back when tapped
        },
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(width: 10), // Add spacing from the edge
            Icon(
              Icons.arrow_back_ios,
              color: AppColors.textgreyColor,
              size: 16, // Adjust icon size
            ),
            SizedBox(width: 5), // Spacing between icon and text
            Text(
              "Back",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: AppColors.textgreyColor,
                fontSize: 14, // Adjust font size
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
