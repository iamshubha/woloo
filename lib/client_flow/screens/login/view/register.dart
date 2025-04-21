


import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../screens/common_widgets/image_provider.dart';
import '../../../../utils/app_color.dart';
import '../../../../utils/app_constants.dart';
import '../../../../utils/app_images.dart';
import '../../../../utils/app_textstyle.dart';
import '../../../widgets/CustomButton.dart';
import '../../../widgets/CustomTextField.dart';
import '../bloc/signup_bloc.dart';
import '../bloc/signup_event.dart';
import '../bloc/signup_state.dart';
import 'choose_service.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final loginFormKey = GlobalKey<FormState>();
   SignupBloc loginBloc = SignupBloc();
final TextEditingController nameController = TextEditingController();
final TextEditingController emailController = TextEditingController();
final TextEditingController mobileController = TextEditingController();
final TextEditingController addressController = TextEditingController();
final TextEditingController cityController = TextEditingController();
final TextEditingController pincodeController = TextEditingController();
final TextEditingController passwordController = TextEditingController();
final TextEditingController confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return   Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body:    SingleChildScrollView(
        child: 
        Form(
       key: loginFormKey,
          child: Column(
            children: [
               const SizedBox(
                height: 50,
               ),
              Padding(
               padding: const EdgeInsets.symmetric( horizontal: 16), 
                child: Container(
                  // width: 380.w,
                  // height: 600.h,
                  // decoration: BoxDecoration(
                  //   borderRadius: BorderRadius.circular(60),
                  //
                  //   color: AppColors.white
                  // ),
                  child:  Column(
                    children: [
                            const SizedBox(
                            height: 20,
                             ),
                
                        CustomImageProvider(
                         image: AppImages.woloologo,
                         width: 178,
                         height: 153,
                        //  fit: BoxFit.cover,
                        ),
                          const SizedBox(
                            height: 10,
                             ),
                
                 CustomTextField(
                  controller: nameController,
                  hintText: SignUpConstant.name,
                  keyboardType: TextInputType.emailAddress,
                  // maxLength: 10,
                  validator: validateName
                  // prefixIcon: Icons.phone,
                ),
                       const SizedBox(
                            height: 10,
                             ),
          
                CustomTextField(
                  controller: emailController,
                  hintText: SignUpConstant.email,
                  keyboardType: TextInputType.text,
                  // maxLength: 10,
                  validator: validateEmail
                
                  // prefixIcon: Icons.phone,
                ), 
          
                     const SizedBox(
                            height: 10,
                             ),
          
                CustomTextField(
                  controller: mobileController,
                  hintText:SignUpConstant.mobileNo,
                  keyboardType: TextInputType.number,
                  maxLength: 10,
                  validator: validateMobile
                
                  // prefixIcon: Icons.phone,
                ), 
                      const SizedBox(
                            height: 10,
                             ),
          
                CustomTextField(
                  controller: addressController,
                  hintText: SignUpConstant.address,
                  keyboardType: TextInputType.text,
                  // maxLength: 10,
                  validator: 
                  validateAddress
                  // prefixIcon: Icons.phone,
                ), 
                      const SizedBox(
                            height: 10,
                             ),
          
                CustomTextField(
                  controller: cityController,
                  hintText: SignUpConstant.city,
                  keyboardType: TextInputType.text,
                  // maxLength: 10,
                  validator:
                 validateCity
                  // prefixIcon: Icons.phone,
                ), 
                         const SizedBox(
                            height: 10,
                             ),
          
                CustomTextField(
                  controller: pincodeController,
                  hintText: SignUpConstant.pinCode,
                  keyboardType: TextInputType.text,
                  maxLength: 10,
                  validator: 
                      validatePincode
                  // prefixIcon: Icons.phone,
                ),
                          const SizedBox(
                            height: 10,
                             ),
          
                CustomTextField(
                  controller: passwordController,
                  hintText: SignUpConstant.password,
                  keyboardType: TextInputType.text,
                  obscureText: true,
                  maxLength: 10,
                  validator: 
                  validatePassword
                  // prefixIcon: Icons.phone,
                ),
                              const SizedBox(
                            height: 10,
                             ),
          
                CustomTextField(
                  controller: confirmPasswordController,
                  hintText: SignUpConstant.confirmPassword,
                  keyboardType: TextInputType.text,
                  maxLength: 10,
                  obscureText: true,
                  validator: 
                 validateConfirmPassword
                  // prefixIcon: Icons.phone,
                ),
                      const SizedBox(
                            height: 5,
                             ),
          
                                BlocConsumer<SignupBloc, SignUpState>(
                    bloc: loginBloc,
                    listener: (context, state) {
                      if (state is SignUpLoading) {
                        EasyLoading.show(status: state.message);
                      }
          
                      if (state is CreateClient) {
                        EasyLoading.dismiss();
                        // loginBloc.add(Signup(
                        //   mobileNumber: mobileController.text,
                        //   email: emailController.text,
                        //   name: nameController.text,
                        //   password: passwordController.text,
                        //   address: addressController.text,
                        //   city: cityController.text,
                        //   clientTypeId: 10,
                        //   pincode: pincodeController.text
                        // ));

                        // Navigator.push(
                        //   context,
                        //   MaterialPageRoute(
                        //     builder: (context) => OTPScreen(
                        //       phoneNumber: controller.text,
                        //       loginBloc: loginBloc,
                        //       type: widget.type,
                        //     ),
                        //   ),
                        // );
                      }
                       if( state is  RegisterUser ){
                         EasyLoading.dismiss();
                          Navigator.of(context).pop();
                        //  Navigator.push(
                        //    context,
                        //    MaterialPageRoute(
                        //      builder: (context) =>
                        //          ChooseService(

                        //      ),
                        //    ),
                        //  );
                       }
          
                      if (state is SignUpError) {
                        EasyLoading.dismiss();
                        EasyLoading.showError(state.error);
                      }
          
                      // if (state is LoginGetDataSuccess) {
                      //   EasyLoading.dismiss();
                      //   setState(() {
                      //     /// Show hint only one time
                      //     /// * Works only on android platform
                      //     if (!_isHintShown && Platform.isAndroid) {
                      //       requestHint();
                      //     }
                      //   });
                      // }
                    },
                    builder: (context, state) {

                      if (state is CreateClient) {
                        // EasyLoading.dismiss();
                        loginBloc.add(Signup(
                          mobileNumber: mobileController.text,
                          email: emailController.text,
                          name: nameController.text,
                          password: passwordController.text,
                          address: addressController.text,
                          city: cityController.text,
                          clientTypeId: 10,
                          pincode: pincodeController.text
                        ));

                        // Navigator.push(
                        //   context,
                        //   MaterialPageRoute(
                        //     builder: (context) => OTPScreen(
                        //       phoneNumber: controller.text,
                        //       loginBloc: loginBloc,
                        //       type: widget.type,
                        //     ),
                        //   ),
                        // );
                      }

                      return GestureDetector(
                        onTap: () async {
                          bool isValid =
                              loginFormKey.currentState?.validate() ?? false;
                          if (!isValid) return;
          
                          // globalStorage.saveMobileNumber(
                          //     accessMobileNumber: controller.text  );
                          if (loginFormKey.currentState?.validate() ?? false) {
                            loginBloc.add(CreateClientEvent( 
                              mobileNumber: mobileController.text,
                              email: emailController.text,
                              name: nameController.text,
                              password: passwordController.text,
                              pincode: pincodeController.text,
                              city: cityController.text,
                              address: addressController.text,
                              ));
                          }
                        },
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                            vertical: 10.h,
                            horizontal: 20.w,
                          ),
                          child:
                     Custombutton(
                      color: AppColors.buttonYellowColor,
                      text: "Register", width: 300.w),
                        ),
                      );
                    },
                  ),
                     
             
                               const SizedBox(
                                height: 10
                               ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text("Already a user?",
                               style: AppTextStyle.font14bold,
                              ),
                              GestureDetector(
                                onTap: () {
                                  Navigator.pop(context);
                                },
                                child: Text("Login Now",
                                  
                                style: AppTextStyle.font14bold.copyWith(
                                                             decoration: TextDecoration.underline,
                                                           ),
                                 ),
                              )
                            ],
                          ),
                               const SizedBox(
                                height: 10,
                               ),
                        
                           
                       
                    ],
                  ),
                ),
              )
          
            ],
          ),
        ),
      ),
    );
  }




  String? validateName(String? value) {
  if (value == null || value.isEmpty) {
    return "Name is required";
  }
  if (value.length < 3) {
    return "Name must be at least 3 characters";
  }
  return null;
}

String? validateEmail(String? value) {
  if (value == null || value.isEmpty) {
    return "Email is required";
  }
  final emailRegex = RegExp(r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$");
  if (!emailRegex.hasMatch(value)) {
    return "Enter a valid email";
  }
  return null;
}

String? validateMobile(String? value) {
  if (value == null || value.isEmpty) {
    return "Mobile number is required";
  }
  if (!RegExp(r'^[0-9]{10}$').hasMatch(value)) {
    return "Enter a valid 10-digit number";
  }
  return null;
}

String? validateAddress(String? value) {
  if (value == null || value.isEmpty) {
    return "Address is required";
  }
  if (value.length < 5) {
    return "Address must be at least 5 characters";
  }
  return null;
}

String? validateCity(String? value) {
  if (value == null || value.isEmpty) {
    return "City is required";
  }
  return null;
}

String? validatePincode(String? value) {
  if (value == null || value.isEmpty) {
    return "Pincode is required";
  }
  if (!RegExp(r'^[0-9]{6}$').hasMatch(value)) {
    return "Enter a valid 6-digit pincode";
  }
  return null;
}

String? validatePassword(String? value) {
  if (value == null || value.isEmpty) {
    return "Password is required";
  }
  if (value.length < 6) {
    return "Password must be at least 6 characters";
  }
  return null;
}

String? validateConfirmPassword(String? value) {
  if (value == null || value.isEmpty) {
    return "Confirm Password is required";
  }
  if (value != passwordController.text) {
    return "Passwords do not match";
  }
  return null;
}

}