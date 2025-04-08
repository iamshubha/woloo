import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_it/get_it.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:woloo_smart_hygiene/app.dart';
import 'package:woloo_smart_hygiene/client_flow/screens/dashbaord/bloc/dashboard_event.dart';
import 'package:woloo_smart_hygiene/client_flow/screens/subcription/bloc/subscription_event.dart';
import 'package:woloo_smart_hygiene/screens/common_widgets/image_provider.dart';
import 'package:woloo_smart_hygiene/utils/app_constants.dart';
import 'package:woloo_smart_hygiene/utils/app_textstyle.dart';

import '../../../../core/local/global_storage.dart';
import '../../../../utils/app_color.dart';
import '../../../../utils/app_images.dart';
import '../../login/bloc/signup_bloc.dart';
import '../bloc/subscription_bloc.dart';
import '../bloc/subscription_state.dart';

class SubcriptionScreen extends StatefulWidget {
  const SubcriptionScreen({super.key});

  @override
  State<SubcriptionScreen> createState() => _SubcriptionScreenState();
}

class _SubcriptionScreenState extends State<SubcriptionScreen> {
  late Razorpay razorpay;
  String merchantKeyValue = "rzp_test_ZIlhyKgx2C38vT";
  String amountValue = "100";
  String orderIdValue = "";
  String mobileNumberValue = "8888888888";
    SubcriptionBloc subcriptionBloc = SubcriptionBloc();
      Map<String, dynamic>? decodedToken;
  GlobalStorage globalStorage = GetIt.instance();
  String orderId = "" ;
   @override
  void initState() {
    // TODO: implement initState
    super.initState();
     razorpay = Razorpay();
       var some =   globalStorage.getClientId();
    // decodedToken = JwtDecoder.decode(some);
     subcriptionBloc.add( CreateOrderEvent(clientId: some));

     // razorpay.
    // razorpay = Razorpay("rzp_test_qRGYYA5wZrpFvJ");
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.white,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric( horizontal: 16 ),
          child: Column(
            children: [
              ListTile(
                leading: CustomImageProvider(
                  image: AppImages.premiumImage,
                ),
                title: Text(
                  SubcriptionConstant.upgradeToPremium,
                  style: AppTextStyle.font18bold,
                ),
                subtitle: Text(
                  SubcriptionConstant.upgradeDescription,
                  style: AppTextStyle.font12bold,
                ),
              ),
              const SizedBox(
              height: 10,
            ),
        
              subCard(SubcriptionConstant.freePlan, SubcriptionConstant.freeFeature),
                const SizedBox(
                 height: 30,
                  ),
               subCard(SubcriptionConstant.premiumPlan, SubcriptionConstant.premiumFeature),
        
            ],
          ),
        ),
      ),
    );
  }
  Widget subCard(String title, String description) {
  return Container(
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
        Text(
          title,
          style: AppTextStyle.font18bold,
        ),
        const SizedBox(
          height: 10,
        ),
        Text(
          description,
          style: AppTextStyle.font14bold,
        ),
        const SizedBox(
          height: 20,
        ),
        row(SubcriptionConstant.freeTotalLogins),
        const SizedBox(
          height: 10,
        ),
        row(SubcriptionConstant.freeSupervisorLogin),
        const SizedBox(
          height: 10,
        ),
        row(SubcriptionConstant.freeJanitorLogins),
        const SizedBox(
          height: 10,
        ),
        row(SubcriptionConstant.freeLocation),
        const SizedBox(
          height: 10,
        ),
        row(SubcriptionConstant.freeFacilities),
         const SizedBox(
          height: 15,
        ),

               BlocConsumer(
                bloc: subcriptionBloc,
                 listener: (context, state) {
                       if ( state is SubscriptionLoading  ){

                 EasyLoading.show(status: state.message);
               }

               if( state is CreateOrder ){

                      
                             // YYYY-MM-DD format
                           // DateTime dateTime = DateTime.parse(dateString);
                    amountValue  =     state.orderModel.results.amount.toString(); // Example future date
                    orderId =   state.orderModel.results.id.toString();
                     print("amount $amountValue");
                    print("order $orderId");
                    EasyLoading.dismiss();
                 // gender = state.tasklist;

               }
               if(state is SubscriptionError  ){

                 EasyLoading.dismiss();
                 EasyLoading.showError( state.error.message);

               }

                 },
                
                 builder: (context, state) {
                   return ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                   minimumSize:  const Size(306, 59),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12), // <-- Radius
                                  ),
                                backgroundColor: AppColors.buttonBgColor
                   
                              ),
                   
                              onPressed: (){
                                
                            razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, handlePaymentErrorResponse);
                            razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, handlePaymentSuccessResponse);
                            razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, handleExternalWalletSelected);
                            razorpay.open(getPaymentOptions());
                   
                              }, child: Text(DashboardConst.getStarted,
                           style: AppTextStyle.font20bold.copyWith(
                             // color: AppColors.white
                           ),
                          ) );
                 }
               ),

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
    padding: const EdgeInsets.only(left: 35 ),
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
      'key': '$merchantKeyValue',
      'amount': int.parse(amountValue),
      'name': 'Woloo',
      'description': 'Premium Plan',
      'retry': {'enabled': true, 'max_count': 1},
      'send_sms_hash': true,
      'order_id': orderId,
      'prefill': {
        'contact': '$mobileNumberValue',
        'email': 'test@razorpay.com'
      },
      'external': {
        'wallets': ['paytm']
      }
    };
  }

    void handlePaymentErrorResponse(PaymentFailureResponse response){

    /** PaymentFailureResponse contains three values:
    * 1. Error Code
    * 2. Error Description
    * 3. Metadata
    **/
    showAlertDialog(context, "Payment Failed", "Code: ${response.code}\nDescription: ${response.message}\nMetadata:${response.error.toString()}");
  }

  void handlePaymentSuccessResponse(PaymentSuccessResponse response){

    /** Payment Success Response contains three values:
    * 1. Order ID
    * 2. Payment ID
    * 3. Signature
    **/
    showAlertDialog(context, "Payment Successful", "Payment ID: ${response.paymentId}");
  }

  void handleExternalWalletSelected(ExternalWalletResponse response){
    showAlertDialog(context, "External Wallet Selected", "${response.walletName}");
  }


   void showAlertDialog(BuildContext context, String title, String message){
    // set up the buttons
    Widget continueButton = ElevatedButton(
      child: const Text("Continue"),
      onPressed:  () {},
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


