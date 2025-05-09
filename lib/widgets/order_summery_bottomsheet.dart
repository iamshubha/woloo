import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_storage/get_storage.dart';
import 'package:woloo_smart_hygiene/b2b_store/bloc/b2b_store_bloc.dart';
import 'package:woloo_smart_hygiene/b2b_store/bloc/b2b_store_event.dart';
import 'package:woloo_smart_hygiene/b2b_store/bloc/b2b_store_state.dart';
import 'package:woloo_smart_hygiene/b2b_store/cart.dart';
import 'package:woloo_smart_hygiene/b2b_store/models/address.dart';
import 'package:woloo_smart_hygiene/b2b_store/models/cart.dart';
import 'package:woloo_smart_hygiene/janitorial_services/screens/host_dashboard_screen.dart';
import 'package:woloo_smart_hygiene/utils/app_images.dart';
import 'package:woloo_smart_hygiene/widgets/address_change_bottomsheet.dart';
import 'package:woloo_smart_hygiene/widgets/cart_bottomsheet.dart';

class OrderSummeryBottomSheet extends StatefulWidget {
  const OrderSummeryBottomSheet({
    super.key,
  });

  @override
  State<OrderSummeryBottomSheet> createState() =>
      _OrderSummeryBottomSheetState();
}

class _OrderSummeryBottomSheetState extends State<OrderSummeryBottomSheet> {
  final B2bStoreBloc _b2bStoreBloc = B2bStoreBloc();
  bool _isDataLoaded = false;
  CartModel? cartModel;
  Addresses? address;
  final box = GetStorage();
  @override
  void initState() {
    super.initState();
    _b2bStoreBloc.add(const GetCartData());
    address = getAddress();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer(
      bloc: _b2bStoreBloc,
      listener: (context, state) {
        if (state is CartLoading) {
          EasyLoading.show(status: state.message);
        }
        if (state is CartSuccess) {
          EasyLoading.dismiss();
          setState(() {
            print(state.cartData.cart);
            // _addressesData = state.addressesData;
            // _b2bStoreHomePage = state.dashboardData;
            cartModel = state.cartData;
            _isDataLoaded = true;
            // _dashboardData = state.dashboardData;
          });
        }

        if (state is CartError) {
          EasyLoading.dismiss();
          EasyLoading.showError(state.error);
        }
      },
      builder: (context, state) {
        return !_isDataLoaded
            ? Container()
            : Container(
                height: MediaQuery.of(context).size.height * 0.6,
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(40.r))),
                child: Column(
                    // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    spacing: 10,
                    children: [
                      const XBottmSheetTopDecor(),
                      // const SizedBox(
                      //   height: 20,
                      // ),
                      CartHeader(
                          imgPath: AppImages.list,
                          title: "Order Summary",
                          subtitle:
                              "Check the summary of your order here before paying"),
                      const Divider(),
                      Expanded(
                        child: ListView(
                          children: [
                            ListView.builder(
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              // Prevents nested scrolling
                              itemCount: cartModel?.cart?.items
                                  .length, // Replace with your cart item count
                              itemBuilder: (context, index) {
                                final item = cartModel?.cart?.items[index];
                                return Padding(
                                  padding: EdgeInsets.symmetric(vertical: 8.h),
                                  child: CartItemCard(
                                    item: item,
                                  ),
                                );
                              },
                            ),
                            const Divider(),
                            AddressChangeWidget(address: address),
                            const Divider(),
                            XDecoratedBox(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                spacing: 10,
                                children: [
                                  const EditHeader(label: "Payment Details"),
                                  Row(
                                    children: [
                                      SizedBox(
                                          height: 40,
                                          width: 40,
                                          child:
                                              Image.asset(AppImages.upiIcon)),
                                      const Text(
                                        "UPI App",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            const Divider(),
                            PricingCalculate(
                              total: cartModel?.cart?.total,
                              subTotal: cartModel?.cart?.subtotal,
                              discount: cartModel?.cart?.discountTotal,
                              itemTotal: cartModel?.cart?.itemTotal,
                            ),
                            const Divider(),
                            const SizedBox(
                              height: 20,
                            ),
                          ],
                        ),
                      ),
                      const Divider(),

                      LongLabeledButton(
                        label: "Pay via [payment method]",
                        onTap: () {
                          _b2bStoreBloc.add(const Payment());
                        },
                      )
                    ]),
              );
      },
    );
  }

  Addresses? getAddress() {
    address = Addresses.fromJson(jsonDecode(box.read("address")));
    // setState(() {});
    return address;
  }
}
