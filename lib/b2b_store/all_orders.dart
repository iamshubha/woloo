import 'package:animated_rating_stars/animated_rating_stars.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:woloo_smart_hygiene/b2b_store/bloc/b2b_store_bloc.dart';
import 'package:woloo_smart_hygiene/b2b_store/bloc/b2b_store_event.dart';
import 'package:woloo_smart_hygiene/b2b_store/bloc/b2b_store_state.dart';
import 'package:woloo_smart_hygiene/b2b_store/cart.dart';
import 'package:woloo_smart_hygiene/b2b_store/models/order_details.dart';
import 'package:woloo_smart_hygiene/b2b_store/order_details.dart';
import 'package:woloo_smart_hygiene/b2b_store/product_details.dart';
import 'package:woloo_smart_hygiene/extensions/string_extension.dart';
import 'package:woloo_smart_hygiene/utils/app_color.dart';
import 'package:woloo_smart_hygiene/utils/app_images.dart';
import 'package:woloo_smart_hygiene/utils/app_textstyle.dart';

import '../utils/logger.dart';

class AllOrderScreen extends StatefulWidget {
  const AllOrderScreen({super.key});

  @override
  State<AllOrderScreen> createState() => _AllOrderScreenState();
}

class _AllOrderScreenState extends State<AllOrderScreen> {
  final B2bStoreBloc _b2bStoreBloc = B2bStoreBloc();
  OrderDetails? orderDetailsData;
  bool isLoading = true;
  @override
  void initState() {
    _b2bStoreBloc.add(const OrderDetailsEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<B2bStoreBloc, B2BStoreState>(
        bloc: _b2bStoreBloc,
        listener: (context, state) {
          if (state is OrderDetailsLoading) {
            EasyLoading.show(status: state.message);
          }
          if (state is OrderDetailsSuccess) {
            EasyLoading.dismiss();
            setState(() {
              orderDetailsData = state.orderDetailsData;
              isLoading = false;
              // print(state.orderDetailsData.orderSets.first);
            });
          }
          if (state is OrderDetailsError) {
            EasyLoading.dismiss();
            EasyLoading.showError(state.error);
          }
        },
        builder: (context, snapshot) {
          return !isLoading
              ? Scaffold(
                  appBar: const BackAppBar(),
                  body: Column(
                    children: [
                      CartHeader(
                          imgPath: AppImages.bag,
                          title: "Order",
                          subtitle: "check your recent order here"),
                      const SizedBox(
                        height: 10,
                      ),
                      Expanded(
                          child: ListView.separated(
                        itemCount: orderDetailsData!.orderSets.length,
                        itemBuilder: (c, i) => XDecoratedBox(
                            child: Column(
                          spacing: 20,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(orderDetailsData!.orderSets[i].id.toString(),
                                style: AppTextStyle.font14bold),
                            Column(
                              mainAxisSize: MainAxisSize.min,
                              spacing: 10,
                              children: List.generate(
                                  orderDetailsData!
                                          .orderSets[i].orders.isNotEmpty
                                      ? orderDetailsData!
                                          .orderSets[i].orders[0].items.length
                                      : 0, (j) {
                                final orderSet = orderDetailsData!.orderSets[i];
                                if (orderSet.orders.isEmpty ||
                                    orderSet.orders[0].items.isEmpty) {
                                  return Container(); // Return empty container if no items
                                }
                                return OrderItemWithReview(
                                  orderSet: orderSet,
                                  orderDetails: orderDetailsData!
                                      .orderSets[i].orders[0].items[j],
                                  onChanged: (value) {
                                    logger.w("$value");

                                    showModalBottomSheet(
                                        context: context,
                                        isScrollControlled: true,
                                        builder: (c) {
                                          return ReviewBottomSheet(
                                              onSubmit: (reviewGiven) {
                                            _b2bStoreBloc.add(ReviewEvent(
                                              product_id: orderDetailsData!
                                                      .orderSets[i]
                                                      .orders[0]
                                                      .items[j]
                                                      .productId ??
                                                  "",
                                              rating: value.toInt(),
                                              comment: reviewGiven,
                                              line_item_id: orderDetailsData!
                                                  .orderSets[i]
                                                  .orders[0]
                                                  .items[j]
                                                  .detail!
                                                  .itemId
                                                  .toString(),
                                            ));
                                          });
                                        });
                                  },
                                );
                              }),
                            )
                          ],
                        )),
                        separatorBuilder: (c, i) => const SizedBox(
                          height: 10,
                        ),
                      )),
                    ],
                  ),
                )
              : Container();
        });
  }
}

class OrderItemWithReview extends StatelessWidget {
  final Item orderDetails;
  final Function(double) onChanged;
  final OrderSet orderSet;
  const OrderItemWithReview({
    super.key,
    required this.orderDetails,
    required this.onChanged,
    required this.orderSet,
  });

  @override
  Widget build(BuildContext context) {
    return XDecoratedBox(
        child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          spacing: 20,
          children: [
            Flexible(
              flex: 2,
              child: SizedBox(
                height: 60,
                width: 60,
                child: orderDetails.thumbnail.isEmptyOrNull
                    ? Image.asset(AppImages.appLogo)
                    : CachedNetworkImage(
                        imageUrl: orderDetails.thumbnail ?? ''),
              ),
            ),
            Flexible(
              flex: 8,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    orderDetails.subtitle ?? '',
                    style: AppTextStyle.font14bold,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Rs. ${orderDetails.unitPrice!.floorToDouble()}",
                          style: AppTextStyle.font14bold),
                      // const Spacer(),
                      Column(
                        children: [
                          // Text("data"),
                          InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (c) => OrderScreen(
                                            orderSet: orderSet,
                                          )));
                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 4, horizontal: 8),
                              decoration: BoxDecoration(
                                  color: AppColors.buttonYellowColor,
                                  borderRadius: BorderRadius.circular(6)),
                              child: Row(
                                children: [
                                  Text(
                                    "Check Status",
                                    style: AppTextStyle.font12bold,
                                  ),
                                  const Icon(
                                    Icons.arrow_forward_ios,
                                    size: 20,
                                  )
                                ],
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  )
                ],
              ),
            )
          ],
        ),
        AnimatedRatingStars(
          initialRating: 3.5,
          minRating: 0.0,
          maxRating: 5.0,
          filledColor: Colors.amber,
          emptyColor: Colors.grey,
          filledIcon: Icons.star,
          halfFilledIcon: Icons.star_half,
          emptyIcon: Icons.star_border,
          onChanged: onChanged,
          displayRatingValue: true,
          interactiveTooltips: true,
          customFilledIcon: Icons.star,
          customHalfFilledIcon: Icons.star_half,
          customEmptyIcon: Icons.star_border,
          starSize: 30.0,
          animationDuration: const Duration(milliseconds: 300),
          animationCurve: Curves.easeInOut,
          readOnly: false,
        ),
        Text(
          "Rate this product now",
          style: AppTextStyle.font12bold,
        ),
      ],
    ));
  }
}
