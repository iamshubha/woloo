import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:Woloo_Smart_hygiene/screens/janitor_customer_request/view/local_widgets/customer_request_list_widget.dart';
import 'package:Woloo_Smart_hygiene/utils/app_color.dart';
import 'package:Woloo_Smart_hygiene/utils/app_constants.dart';

class CustomerRequestList extends StatefulWidget {
  const CustomerRequestList({Key? key}) : super(key: key);

  @override
  State<CustomerRequestList> createState() => _CustomerRequestListState();
}

class _CustomerRequestListState extends State<CustomerRequestList> {
  bool cancelButtonTap = true;
  bool yesButtonTap = false;
  int selectedCard = -1;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppColors.white,
        title: Text(
          MyCustomerRequestListScreenConstants.TITLE_TEXT,
          style: TextStyle(
            fontSize: 24.sp,
            fontWeight: FontWeight.w400,
            color: Colors.black,
          ),
        ),
        leading: IconButton(
          color: AppColors.black30,
          icon: const Icon(
            Icons.arrow_back,
            color: AppColors.black,
            size: 30,
          ),
          // color: AppColors.black,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 20.h,
          ),
          Expanded(
            child: RequestListWidget(
              requestType: 'Classic cleaning',
              customerName: 'Amol jagptap',
              dateAndTime: '22 Jun 2023, 12:00 PM-01:00 PM',
              location:
                  'Flat no. 302, vedant apartment DP road Pimple nilakh ,',
              onTapItem: () {},
              status: 'Pending',
            ),
          ),
        ],
      ),
    );
  }
}
