


import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:woloo_smart_hygiene/client_flow/screens/login/bloc/signup_state.dart';
import 'package:woloo_smart_hygiene/client_flow/screens/login/view/choose_service.dart';
import 'package:woloo_smart_hygiene/client_flow/screens/login/view/register.dart';
import 'package:woloo_smart_hygiene/client_flow/utils/client_images.dart';
import 'package:woloo_smart_hygiene/client_flow/widgets/CustomButton.dart';
import 'package:woloo_smart_hygiene/screens/common_widgets/image_provider.dart';
import 'package:woloo_smart_hygiene/utils/app_color.dart';
import 'package:woloo_smart_hygiene/utils/app_constants.dart';
import 'package:woloo_smart_hygiene/utils/app_textstyle.dart';

import '../../../../utils/app_images.dart';
import '../../../widgets/CustomTextField.dart';
import '../bloc/signup_bloc.dart';
import '../bloc/signup_event.dart';

class ClientLogin extends StatefulWidget {
  const ClientLogin({super.key});

  @override
  State<ClientLogin> createState() => _ClientLoginState();
}

class _ClientLoginState extends State<ClientLogin> {

      SignupBloc loginBloc = SignupBloc();
      final TextEditingController passwordController = TextEditingController();
      final TextEditingController emailController = TextEditingController();
       final loginFormKey = GlobalKey<FormState>();
       
  @override
  Widget build(BuildContext context) {
    return   Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: 
      SingleChildScrollView(
        child: Form(
          key: loginFormKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
                SizedBox(
                height: 100.h,
               ),
              Padding(
               padding: const EdgeInsets.symmetric( horizontal: 16),
                child: Column(
                  children: [
                          const SizedBox(
                          height: 50,
                           ),
        
                      CustomImageProvider(
                       image: ClientImages.taskMaster,
                       width: 259,
                       height: 200,
                      //  fit: BoxFit.cover,
                      ),
                        const SizedBox(
                          height: 10,
                           ),
        
                                 CustomTextField(
                controller: emailController,
                hintText: "Enter your Email ID",
                keyboardType: TextInputType.emailAddress,
                // maxLength: 10,
                validator:  validateEmail
                // prefixIcon: Icons.phone,
                                ),
                     const SizedBox(
                          height: 10,
                           ),
        
                                CustomTextField(
                controller: passwordController,
                hintText: "Enter your Password",
                keyboardType: TextInputType.text,
                // maxLength: 10,
                validator: validatePassword
                // prefixIcon: Icons.phone,
                                ),
        
                    const SizedBox(
                          height: 15,
                           ),
        
                           BlocConsumer<SignupBloc ,SignUpState>(
                             bloc: loginBloc,
                            listener: (context, state) {
                               print("states $state");
                              if ( state is SignUpLoading){
                                     EasyLoading.show(status: state.message);
                               }
        
                              if (state is LoginUser  ) {
                                   EasyLoading.dismiss();
                                   Navigator.pushAndRemoveUntil(
                                     context,
                                     MaterialPageRoute(
                                       builder: (context) => const ChooseService(),
                                     ),
                                         (route) => false,
                                   );
                              }
        
                               if(state is SignUpError  ){
                                 EasyLoading.dismiss();
                                 EasyLoading.showError( state.error.message);
        
                               }
        
                            },
                            builder: (context, state) {
        
        
                      return   GestureDetector(
                        onTap: () {
        
        
                          //          bool isValid =
                          //     loginFormKey.currentState?.validate() ?? false;
                          // if (!isValid) return;
        
                                   print("object ${loginFormKey.currentState?.validate() }");
        
                          // globalStorage.saveMobileNumber(
                          //     accessMobileNumber: controller.text  );
                          if (loginFormKey.currentState?.validate() ?? false) {
                            print("object");
                            loginBloc.add(Login(
                              email: emailController.text,
                              password: passwordController.text,
                              ));
                          }
        
        
        
                           },
                     child: Custombutton(
                      color: AppColors.buttonYellowColor,
                      text: "Login", width: 300.w),
                   );
                            },
        
        
        
                            // listener: listener
        
        
                            ),
        
        
                             const SizedBox(
                              height: 25
                             ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(LoginConstant.newUserRegister,
                             style: AppTextStyle.font14bold,
                            ),
                             GestureDetector(
                              onTap: (){
                                   Navigator.of(context).push( MaterialPageRoute(builder: (context) {
                               return Register();
                                  },));
                              },
                               child: Text(LoginConstant.registration,
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
                        Text(LoginConstant.forgotPassword,
        
                         style: AppTextStyle.font14bold.copyWith(
                           decoration: TextDecoration.underline,
                         ),
                        ),
                             const SizedBox(
                              height: 20,
                             ),
                            //  SizedBox(
                            //   width: MediaQuery.of(context).size.width/1.6,
                            //   child: Divider()),
                            //        const SizedBox(
                            //   height: 20,
                            //  ),
                    // Custombutton(
                    // color: AppColors.buttonYellowColor,
                    // text: LoginConstant.loginAsSupervisor, width: 300.w),
        
                  ],
                ),
              )
        
            ],
          ),
        ),
      ),
    );
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


  String? validatePassword(String? value) {
  if (value == null || value.isEmpty) {
    return "Password is required";
  }
  if (value.length < 6) {
    return "Password must be at least 6 characters";
  }
  return null;
}
}