import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_it/get_it.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:woloo_smart_hygiene/app.dart';
import 'package:woloo_smart_hygiene/client_flow/screens/dashbaord/bloc/dashboard_event.dart';
import 'package:woloo_smart_hygiene/client_flow/screens/dashbaord/bloc/dashboard_state.dart';
import 'package:woloo_smart_hygiene/client_flow/screens/subcription/bloc/subscription_event.dart';
import 'package:woloo_smart_hygiene/screens/common_widgets/image_provider.dart';
import 'package:woloo_smart_hygiene/utils/app_constants.dart';
import 'package:woloo_smart_hygiene/utils/app_textstyle.dart';
import 'package:woloo_smart_hygiene/utils/logger.dart';

import '../../../../core/local/global_storage.dart';
import '../../../../utils/app_color.dart';
import '../../../../utils/app_images.dart';
import '../../../utils/client_images.dart';
import '../../../widgets/CustomButton.dart';
import '../../dashbaord/bloc/dashboard_bloc.dart';
import '../../dashbaord/view/dashboard.dart';
import '../../login/bloc/signup_bloc.dart';
import '../bloc/subscription_bloc.dart';
import '../bloc/subscription_state.dart';

class SubcriptionScreen extends StatefulWidget {
  ClientDashBoardBloc? dashBoardBloc;
  bool? isfromFacility;
  // = ClientDashBoardBloc();
  SubcriptionScreen(
      {super.key, this.dashBoardBloc, required this.isfromFacility});

  @override
  State<SubcriptionScreen> createState() => _SubcriptionScreenState();
}

class _SubcriptionScreenState extends State<SubcriptionScreen> {
  late Razorpay razorpay;
  String merchantKeyValue = "rzp_test_ZIlhyKgx2C38vT";
  String amountValue = "";
  String orderIdValue = "";
  String mobileNumberValue = "8888888888";
  SubcriptionBloc subcriptionBloc = SubcriptionBloc();
  Map<String, dynamic>? decodedToken;
  GlobalStorage globalStorage = GetIt.instance();
  String orderId = "";
  // ClientDashBoardBloc  dashBoardBloc = ClientDashBoardBloc();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    razorpay = Razorpay();
    var some = globalStorage.getClientId();
    mobileNumberValue = globalStorage.getClientMobileNo();
    // decodedToken = JwtDecoder.decode(some);

    subcriptionBloc.add(CreateOrderEvent(clientId: some));

    // razorpay.
    // razorpay = Razorpay("rzp_test_qRGYYA5wZrpFvJ");
  }

  @override
  Widget build(BuildContext context) {
    return
        // Scaffold(
        //   backgroundColor: AppColors.white,
        //   appBar: AppBar(
        //     backgroundColor: AppColors.white,
        //   ),
        //   body:
        Container(
      height: 600,

      decoration: const BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(80.0),
          topRight: Radius.circular(80.0),
        ),
      ),

      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              const SizedBox(
                height: 30,
              ),
              ListTile(
                leading: CustomImageProvider(
                  image: AppImages.premiumImage,
                  width: 60,
                  height: 60,
                ),
                title: const Text(
                  textAlign: TextAlign.center,
                  SubcriptionConstant.upgradeToPremium,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                // subtitle: Text(
                //   SubcriptionConstant.upgradeDescription,
                //   style: AppTextStyle.font12bold,
                // ),
              ),
              const SizedBox(
                height: 10,
              ),

              // subCard(SubcriptionConstant.freePlan, SubcriptionConstant.freeFeature),
              const SizedBox(
                height: 30,
              ),
              BlocConsumer(
                  bloc: widget.dashBoardBloc,
                  listener: (context, state) {
                    print("dssa $state");
                    if (state is SubscriptionLoading) {
                      EasyLoading.show(status: state.message);
                    }

                    if (state is Subcription) {
                      // YYYY-MM-DD format
                      // DateTime dateTime = DateTime.parse(dateString);
                      // amountValue  =     state.orderModel.results.amount.toString(); // Example future date
                      // orderId =   state.orderModel.results.id.toString();
                      // print("amount $amountValue");
                      // print("order $orderId");
                      EasyLoading.dismiss();
                    }
                    if (state is SubscriptionError) {
                      EasyLoading.dismiss();
                      EasyLoading.showError(state.error.message);
                    }
                  },
                  builder: (context, state) {
                    return subCard(SubcriptionConstant.premiumPlan,
                        SubcriptionConstant.premiumFeature);
                  }),
              const SizedBox(
                height: 30,
              ),

              BlocConsumer(
                  bloc: subcriptionBloc,
                  listener: (context, state) {
                    if (state is SubscriptionLoading) {
                      EasyLoading.show(status: state.message);
                    }

                    if (state is CreateOrder) {
                      // YYYY-MM-DD format
                      // DateTime dateTime = DateTime.parse(dateString);
                      amountValue = state.orderModel.results.amount
                          .toString(); // Example future date
                      orderId = state.orderModel.results.id.toString();
                      print("amount $amountValue");
                      print("order $orderId");
                      EasyLoading.dismiss();
                      // gender = state.tasklist;
                    }
                    if (state is SubscriptionError) {
                      EasyLoading.dismiss();
                      EasyLoading.showError(state.error.message);
                    }
                  },
                  builder: (context, state) {
                    return ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            minimumSize: Size(
                                MediaQuery.of(context).size.width / 1.1, 59),
                            shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.circular(12), // <-- Radius
                            ),
                            backgroundColor: AppColors.buttonBgColor),
                        onPressed: () {
                          logger.w(getPaymentOptions);
                          razorpay.on(Razorpay.EVENT_PAYMENT_ERROR,
                              handlePaymentErrorResponse);
                          razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS,
                              handlePaymentSuccessResponse);
                          razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET,
                              handleExternalWalletSelected);
                          razorpay.open(getPaymentOptions());
                        },
                        child: Text(
                          "Pay Now",
                          style: AppTextStyle.font20bold.copyWith(
                              // color: AppColors.white
                              ),
                        ));
                  }),
            ],
          ),
        ),
      ),
      // ),
    );
  }

  Widget subCard(String title, String description) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 20,
      ),
      decoration: BoxDecoration(
          color: AppColors.white, // Background color of the container
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.2), // Shadow color
              spreadRadius: 1, // How wide the shadow should spread
              blurRadius: 10, // The blur effect of the shadow
              offset: const Offset(0, 0), // No offset for shadow on all sides
            ),
          ],
          borderRadius: BorderRadius.circular(36.r)),
      child: Column(
        children: [
          const SizedBox(
            height: 15,
          ),
          CustomImageProvider(
            image: ClientImages.taskMasterblack,
            width: 170.w,
            height: 71.h,
          ),

          const SizedBox(
            height: 15,
          ),
          // Text(
          //   title,
          //   style: AppTextStyle.font18bold,
          // ),
          const SizedBox(
            height: 10,
          ),
          Text(
            "Continue your services at Rs. 499 per\n Facility",
            style: AppTextStyle.font14bold,
            textAlign: TextAlign.center,
          ),
          const SizedBox(
            height: 20,
          ),
          // row(SubcriptionConstant.freeTotalLogins),
          // const SizedBox(
          //   height: 10,
          // ),
          // row(SubcriptionConstant.freeSupervisorLogin),
          // const SizedBox(
          //   height: 10,
          // ),
          // row(SubcriptionConstant.freeJanitorLogins),
          // const SizedBox(
          //   height: 10,
          // ),
          // row(SubcriptionConstant.freeLocation),
          // const SizedBox(
          //   height: 10,
          // ),
          // row(SubcriptionConstant.freeFacilities),
          //  const SizedBox(
          //   height: 15,
          // ),

          const SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }

  Widget row(
    String title,
  ) {
    return Padding(
      padding: const EdgeInsets.only(left: 35),
      child: Row(
        children: [
          CustomImageProvider(
            image: AppImages.checkIcons,
            width: 17,
            height: 17,
          ),
          const SizedBox(
            width: 10,
          ),
          Text(
            title,
            style: AppTextStyle.font14bold,
          ),
        ],
      ),
    );
  }

  Map<String, Object> getPaymentOptions() {
    return {
      'key': merchantKeyValue,
      'amount': int.parse(amountValue),
      'name': 'Woloo',
      'description': 'Premium Plan',
      'retry': {'enabled': true, 'max_count': 1},
      'send_sms_hash': true,
      'order_id': orderId,
      'prefill': {'contact': mobileNumberValue, 'email': 'test@razorpay.com'},
      'external': {
        'wallets': ['paytm']
      }
    };
  }

  void handlePaymentErrorResponse(PaymentFailureResponse response) {
    /** PaymentFailureResponse contains three values:
    * 1. Error Code
    * 2. Error Description
    * 3. Metadata
    **/
    showDialog(
      // barrierDismissible: false,
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(60),
          ),

          backgroundColor: AppColors.white,
          // title:  Center(
          //   child: Text("Your Free Subscription has expired",
          //    style: AppTextStyle.font20bold,
          //    textAlign: TextAlign.center,
          //   ),
          // ),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                CustomImageProvider(
                  image: ClientImages.warning,
                  width: 86.w,
                  height: 86.h,
                ),
                SizedBox(
                  height: 10.h,
                ),
                Text(
                  textAlign: TextAlign.center,
                  "Oops! Your payment has not gone through",
                  style: AppTextStyle.font18bold,
                ),
                SizedBox(
                  height: 20.h,
                ),
                // const Custombutton(
                //   width: 300,
                //   text: "Pay Now",
                // )
              ],
            ),
          ),
        );
      },
    );
    // showAlertDialog(context, "Payment Failed", "Code: ${response.code}\nDescription: ${response.message}\nMetadata:${response.error.toString()}");
  }

  void handlePaymentSuccessResponse(PaymentSuccessResponse response) {
    /** Payment Success Response contains three values:
    * 1. Order ID
    * 2. Payment ID
    * 3. Signature
    **/
    globalStorage.getClientId();
    String clintId = globalStorage.getClientId();
    widget.dashBoardBloc!.add(SubcriptionEvent(id: int.parse(clintId)));
    if (widget.isfromFacility!) {
      print("is from facility");

      globalStorage.savePaymentId(accessPayemntId: response.paymentId!);
    }

    showDialog(
      // barrierDismissible: false,
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),

          backgroundColor: AppColors.white,
          // title:  Center(
          //   child: Text("Your Free Subscription has expired",
          //    style: AppTextStyle.font20bold,
          //    textAlign: TextAlign.center,
          //   ),
          // ),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                CustomImageProvider(
                  image: ClientImages.verify,
                  width: 86.w,
                  height: 86.h,
                ),
                SizedBox(
                  height: 10.h,
                ),
                Text(
                  textAlign: TextAlign.center,
                  "Your TASKMASTER Premium is now active",
                  style: AppTextStyle.font18bold,
                ),
                SizedBox(
                  height: 20.h,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).pop();
                    Navigator.of(context).pop();
                  },
                  child: const Custombutton(
                    width: 300,
                    text: "Go to Home",
                  ),
                )
              ],
            ),
          ),
        );
      },
    );

    // showAlertDialog(context, "Payment Successful", "Payment ID: ${response.paymentId}");
  }

  void handleExternalWalletSelected(ExternalWalletResponse response) {
    showAlertDialog(
        context, "External Wallet Selected", "${response.walletName}");
  }

  void showAlertDialog(BuildContext context, String title, String message) {
    // set up the buttons
    Widget continueButton = ElevatedButton(
      child: const Text("Continue"),
      onPressed: () {},
    );
    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text(title),
      content: Text(message),
    );
    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
// }
}
