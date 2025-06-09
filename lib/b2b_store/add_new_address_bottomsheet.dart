import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_places_flutter/google_places_flutter.dart';
import 'package:google_places_flutter/model/place_type.dart';
import 'package:google_places_flutter/model/prediction.dart';
import 'package:woloo_smart_hygiene/b2b_store/bloc/b2b_store_bloc.dart';
import 'package:woloo_smart_hygiene/b2b_store/bloc/b2b_store_event.dart';
import 'package:woloo_smart_hygiene/b2b_store/bloc/b2b_store_state.dart';
import 'package:woloo_smart_hygiene/b2b_store/cart.dart';
import 'package:woloo_smart_hygiene/utils/app_color.dart';
import 'package:woloo_smart_hygiene/utils/app_constants.dart';
import 'package:woloo_smart_hygiene/utils/app_textstyle.dart';
import 'package:woloo_smart_hygiene/utils/logger.dart';

class AddressBottomSheet extends StatefulWidget {
  const AddressBottomSheet({super.key});

  @override
  State<AddressBottomSheet> createState() => _AddressBottomSheetState();
}

class _AddressBottomSheetState extends State<AddressBottomSheet>
    with SingleTickerProviderStateMixin {
  final B2bStoreBloc _b2bStoreBloc = B2bStoreBloc();
  final _formKey = GlobalKey<FormState>();

  // Controllers
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _flatNoController = TextEditingController();
  final _stateController = TextEditingController();
  final _apartmentController = TextEditingController();
  final _cityController = TextEditingController();
  final _pincodeController = TextEditingController(); // Maps to postal_code
  final _phoneController = TextEditingController(); // Maps to phone
  final _labelController = TextEditingController(); // Maps to address_name
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = BottomSheet.createAnimationController(this);
  }

  @override
  void dispose() {
    _controller.dispose();
    // Don't dispose _formKey.currentState, it's managed by the framework
    _firstNameController.dispose();
    _lastNameController.dispose();
    _flatNoController.dispose();
    _stateController.dispose();
    _apartmentController.dispose();
    _cityController.dispose();
    _pincodeController.dispose();
    _phoneController.dispose();
    _labelController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<B2bStoreBloc, B2BStoreState>(
      bloc: _b2bStoreBloc, // Use the bloc instance obtained from context
      listener: (context, state) {
        if (state is AddAddressSuccess) {
          Fluttertoast.showToast(
              msg: "Address added successfully",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.blue,
              textColor: Colors.white,
              fontSize: 16.0);
          Navigator.pop(context);
        }
      },
      builder: (context, snapshot) {
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
          decoration: BoxDecoration(
              color: const Color.fromARGB(255, 238, 238, 238),
              borderRadius: BorderRadius.vertical(top: Radius.circular(40.r))),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              spacing: 2.h,
              children: [
                SizedBox(height: 20.h),
                Row(
                  children: [
                    IconButton(
                        onPressed: () => Navigator.pop(context),
                        icon: const Icon(Icons.arrow_back_sharp)),
                    SizedBox(width: 10.w),
                    Text("Add New Address", style: AppTextStyle.font14bold),
                  ],
                ),
                SizedBox(height: 10.h), // Added spacing
                Row(
                  children: [
                    Expanded(
                      child: XDecoratedBox(
                        padding: 4,
                        child: XDesignedTextField(
                          // keyboardType: TextInputType.text,
                          hintText: "First Name",
                          controller: _firstNameController,
                          validator: _requiredValidator,
                        ),
                      ),
                    ),
                    SizedBox(width: 8.w), // Added spacing between fields
                    Expanded(
                      child: XDecoratedBox(
                        padding: 4,
                        child: XDesignedTextField(
                          // keyboardType: TextInputType.text,
                          hintText: "Last Name",
                          controller: _lastNameController,
                          validator: _requiredValidator,
                        ),
                      ),
                    ),
                  ],
                ),
                XDecoratedBox(
                  padding: 4,
                  child: XDesignedTextField(
                    // keyboardType: TextInputType.text,
                    hintText: "Flat No.",
                    controller: _flatNoController,
                    validator: _requiredValidator,
                  ),
                ),
                XDecoratedBox(
                  padding: 4,
                  child: XDesignedTextField(
                    // keyboardType: TextInputType.text,
                    hintText: "Apartment Name/Road/Area",
                    controller: _apartmentController,
                  ),
                ),
                Row(
                  children: [
                    // Padding(
                    //   padding:
                    //       EdgeInsets.symmetric(horizontal: 16.w, vertical: 5.h),
                    //   child: Container(
                    //     // height: 36.h,
                    //     decoration: BoxDecoration(
                    //       borderRadius: BorderRadius.circular(7),
                    //       boxShadow: [
                    //         BoxShadow(
                    //           color:
                    //               Colors.black.withOpacity(0.2), // Shadow color
                    //           spreadRadius: 1, // Spread effect
                    //           blurRadius: 10, // Blur effect
                    //           offset: const Offset(0, 5), // Bottom shadow
                    //         ),
                    //       ],
                    //     ),
                    //     child:
                    //      GooglePlaceAutoCompleteTextField(
                    //       placeType: PlaceType.cities,
                    //       // focusNode: _cityFocusNode,
                    //       textEditingController: _cityController,
                    //       googleAPIKey:
                    //           "AIzaSyCkPmUz4UlRdzcKG9gniW9Qfrgzsjhnb_4",
                    //       inputDecoration: InputDecoration(
                    //         contentPadding: const EdgeInsets.symmetric(
                    //             vertical: 12.0, horizontal: 5),
                    //         hintText: SignUpConstant.city,
                    //         hintStyle: TextStyle(
                    //             color: Colors.grey,
                    //             fontSize: 16.sp,
                    //             fontWeight: FontWeight.w700),
                    //         border: OutlineInputBorder(
                    //           borderRadius: BorderRadius.circular(0),
                    //           borderSide: BorderSide.none,
                    //         ),
                    //         fillColor: AppColors.white,
                    //         filled: true,
                    //       ),

                    //       validator: (valu, p1) {
                    //         setState(() {});
                    //         print("val $valu");

                    //         // FocusManager.instance.primaryFocus?.unfocus();
                    //         if (valu == null || valu.isEmpty) {
                    //           return "City is required";
                    //         }
                    //       },
                    //       // debounceTime: 400,
                    //       countries: ["in", "fr"],
                    //       isLatLngRequired: true,
                    //       getPlaceDetailWithLatLng: (Prediction prediction) {
                    //         print("placeDetails" + prediction.lat.toString());
                    //       },

                    //       itemClick: (Prediction prediction) {
                    //         _cityController.text = prediction.description ?? "";
                    //       },

                    //       // seperatedBuilder: const Divider(),
                    //       containerHorizontalPadding: 10,
                    //       // OPTIONAL// If you want to customize list view item builder
                    //       itemBuilder: (context, index, Prediction prediction) {
                    //         return Container(
                    //           color: AppColors.white,
                    //           padding: const EdgeInsets.all(10),
                    //           child: Row(
                    //             children: [
                    //               const Icon(Icons.location_on),
                    //               const SizedBox(
                    //                 width: 7,
                    //               ),
                    //               Expanded(
                    //                   child: Text(
                    //                       "${prediction.description ?? ""}"))
                    //             ],
                    //           ),
                    //         );
                    //       },
                    //       formSubmitCallback: () {
                    //         print("dgd");
                    //       },
                    //     ),
                    //   ),
                    // ),

                    Expanded(
                      child: XDecoratedBox(
                        padding: 4,
                        child: XDesignedTextField(
                          hintText: "City",
                          controller: _cityController,
                          validator: _requiredValidator,
                          // keyboardType: TextInputType.text,
                        ),
                      ),
                    ),
                    SizedBox(width: 8.w),
                    Expanded(
                      child: XDecoratedBox(
                        padding: 4,
                        child: XDesignedTextField(
                          hintText: "State",
                          controller: _stateController,
                          // keyboardType: TextInputType.text,
                        ),
                      ),
                    ),
                  ],
                ),
                XDecoratedBox(
                  padding: 4,
                  child: XDesignedTextField(
                    hintText: "Pincode",
                    controller: _pincodeController,
                    validator: _pincodeValidator,
                    // keyboardType: TextInputType.number, // Set keyboard type
                  ),
                ),
                XDecoratedBox(
                  padding: 4,
                  child: XDesignedTextField(
                    hintText: "Phone",
                    controller: _phoneController,
                    validator: _phoneValidator,
                    // keyboardType: TextInputType.phone, // Set keyboard type
                  ),
                ),
                XDecoratedBox(
                  padding: 4,
                  child: XDesignedTextField(
                    // keyboardType: TextInputType.text,
                    hintText: "Save as (Home/Office/Others)",
                    controller: _labelController,
                    validator: _requiredValidator,
                  ),
                ),
                SizedBox(height: 20.h), // Spacing before button
                LongLabeledButton(
                  label: "Submit",
                  color: AppColors.buttonYellowColor,
                  onTap: () {
                    if (_formKey.currentState!.validate()) {
                      // Combine address fields for `address_1` as per your JSON structure
                      String fullAddress1 = _flatNoController.text.trim();
                      if (_apartmentController.text.trim().isNotEmpty) {
                        fullAddress1 += ", ${_apartmentController.text.trim()}";
                      }

                      // _b2bStoreBloc.add(
                      final v = AddressReq(
                        first_name: _firstNameController.text.trim(),
                        last_name: _lastNameController.text.trim(),
                        address_1: fullAddress1, // Combined address
                        city: _cityController.text.trim(),
                        // Map 'phone' from JSON to 'phone_number' in AddressReq
                        phone_number: _phoneController.text.trim(),
                        // Map 'postal_code' from JSON to 'pincode' in AddressReq
                        pincode: _pincodeController.text.trim(),
                        province: _stateController.text
                            .trim(), // Assuming fixed for now, consider making this dynamic
                        // Map 'address_name' from JSON to 'address_name' in AddressReq
                        address_name: _labelController.text.trim(),
                      );
                      logger.w(v);
                      _b2bStoreBloc.add(v);
                      // );
                    }
                  },
                ),
                SizedBox(height: 10.h), // Spacing below button
                // If the bottom sheet might be covering the keyboard,
                // add some padding at the bottom.
                MediaQuery.of(context).viewInsets.bottom != 0
                    ? SizedBox(height: MediaQuery.of(context).viewInsets.bottom)
                    : const SizedBox.shrink(),
              ],
            ),
          ),
        );
      },
    );
  }

  String? _requiredValidator(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'This field is required';
    }
    return null;
  }

  String? _pincodeValidator(String? value) {
    if (value == null || value.trim().isEmpty) return 'Pincode is required';
    // Changed to allow 6 digits based on common Indian pincodes
    if (!RegExp(r'^\d{6}$').hasMatch(value)) return 'Invalid 6-digit pincode';
    return null;
  }

  String? _phoneValidator(String? value) {
    if (value == null || value.trim().isEmpty)
      return 'Phone number is required';
    if (!RegExp(r'^\d{10}$').hasMatch(value))
      return 'Invalid 10-digit phone number';
    return null;
  }
}
