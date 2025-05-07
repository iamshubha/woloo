import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:woloo_smart_hygiene/b2b_store/bloc/b2b_store_bloc.dart';
import 'package:woloo_smart_hygiene/b2b_store/bloc/b2b_store_event.dart';
import 'package:woloo_smart_hygiene/b2b_store/bloc/b2b_store_state.dart';
import 'package:woloo_smart_hygiene/b2b_store/cart.dart';
import 'package:woloo_smart_hygiene/b2b_store/models/address.dart';
import 'package:woloo_smart_hygiene/janitorial_services/screens/host_dashboard_screen.dart';
import 'package:woloo_smart_hygiene/utils/app_color.dart';
import 'package:woloo_smart_hygiene/utils/app_textstyle.dart';

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
  final _localityController = TextEditingController();
  final _apartmentController = TextEditingController();
  final _cityController = TextEditingController();
  final _pincodeController = TextEditingController();
  final _phoneController = TextEditingController();
  final _labelController = TextEditingController();
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = BottomSheet.createAnimationController(this);
  }

  @override
  void dispose() {
    _controller.dispose();
    _formKey.currentState?.dispose();
    _firstNameController.dispose();
    _lastNameController.dispose();
    _flatNoController.dispose();
    _localityController.dispose();
    _apartmentController.dispose();
    _cityController.dispose();
    _pincodeController.dispose();
    _phoneController.dispose();
    _labelController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // return
    //  BottomSheet(
    //   onClosing: () => FocusScope.of(context).unfocus(),
    //   builder: (context) {
    return BlocConsumer<B2bStoreBloc, B2BStoreState>(
        bloc: _b2bStoreBloc,
        listener: (context, state) {
          if (state is AddAddressSuccess) {
            Navigator.pop(context);
          }
        },
        builder: (context, snapshot) {
          return Container(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius:
                    BorderRadius.vertical(top: Radius.circular(40.r))),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(height: 20.h),
                  Row(
                    children: [
                      IconButton(
                          onPressed: () => Navigator.pop(context),
                          icon: const Icon(Icons.arrow_back_sharp)),
                      SizedBox(width: 10.w),
                      Text("Add Address", style: AppTextStyle.font14bold),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: XDecoratedBox(
                          padding: 4,
                          child: XDesignedTextField(
                            hintText: "First Name",
                            controller: _firstNameController,
                            validator: _requiredValidator,
                          ),
                        ),
                      ),
                      Expanded(
                        child: XDecoratedBox(
                          padding: 4,
                          child: XDesignedTextField(
                            hintText: "Last Name",
                            controller: _lastNameController,
                            validator: _requiredValidator,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: XDecoratedBox(
                          padding: 4,
                          child: XDesignedTextField(
                            hintText: "Flat No.",
                            controller: _flatNoController,
                            validator: _requiredValidator,
                          ),
                        ),
                      ),
                      Expanded(
                        child: XDecoratedBox(
                          padding: 4,
                          child: XDesignedTextField(
                            hintText: "Locality",
                            controller: _localityController,
                            validator: _requiredValidator,
                          ),
                        ),
                      ),
                    ],
                  ),
                  XDecoratedBox(
                    padding: 4,
                    child: XDesignedTextField(
                      hintText: "Apartment Name/Road/Area",
                      controller: _apartmentController,
                      validator: _requiredValidator,
                    ),
                  ),
                  XDecoratedBox(
                    padding: 4,
                    child: XDesignedTextField(
                      hintText: "City",
                      controller: _cityController,
                      validator: _requiredValidator,
                    ),
                  ),
                  XDecoratedBox(
                    padding: 4,
                    child: XDesignedTextField(
                      hintText: "Pincode",
                      controller: _pincodeController,
                      validator: _pincodeValidator,
                    ),
                  ),
                  XDecoratedBox(
                    padding: 4,
                    child: XDesignedTextField(
                      hintText: "Phone",
                      controller: _phoneController,
                      validator: _phoneValidator,
                    ),
                  ),
                  XDecoratedBox(
                    padding: 4,
                    child: XDesignedTextField(
                      hintText: "Save as (Home/Office/Others)",
                      controller: _labelController,
                      validator: _requiredValidator,
                    ),
                  ),
                  LongLabeledButton(
                    label: "Submit",
                    color: AppColors.buttonYellowColor,
                    onTap: () {
                      if (_formKey.currentState!.validate()) {
                        // Form is valid, proceed
                        print("Form submitted");
                        _b2bStoreBloc.add(
                          AddressReq(
                            addressReqBody: AddressReqBody(
                              address1: _apartmentController.text,
                              addressName: 'Default',
                              city: _cityController.text,
                              firstName: _firstNameController.text,
                              lastName: _lastNameController.text,
                              phone: _phoneController.text,
                              postalCode: _pincodeController.text,
                              province: '',
                            ),
                          ),
                        );
                      }
                    },
                  ),
                ],
              ),
            ),
          );
        });
    //   },
    // );
  }

  String? _requiredValidator(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'This field is required';
    }
    return null;
  }

  String? _pincodeValidator(String? value) {
    if (value == null || value.trim().isEmpty) return 'Pincode is required';
    if (!RegExp(r'^\d{5,6}$').hasMatch(value)) return 'Invalid pincode';
    return null;
  }

  String? _phoneValidator(String? value) {
    if (value == null || value.trim().isEmpty) return 'Phone is required';
    if (!RegExp(r'^\d{10}$').hasMatch(value)) return 'Invalid phone number';
    return null;
  }
}
