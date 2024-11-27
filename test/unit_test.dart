// // import 'package:Woloo_Smart_hygiene/core/local/global_storage.dart';
// // import 'package:Woloo_Smart_hygiene/core/network/dio_client.dart';
// // import 'package:Woloo_Smart_hygiene/screens/login/bloc/login_bloc.dart';
// // import 'package:Woloo_Smart_hygiene/screens/login/view/login_screen.dart';
// // // import 'package:Woloo_Smart_hygiene/screens/login/view/login_screen.dart';
// // import 'package:flutter/material.dart';
// // import 'package:flutter_test/flutter_test.dart';
// // import 'package:mockito/mockito.dart';

// // import 'package:get_it/get_it.dart';
// // import 'package:easy_localization/easy_localization.dart';
// // import 'package:flutter_screenutil/flutter_screenutil.dart';

// // class MockLoginBloc extends Mock implements LoginBloc {

// // }
// // class MockGlobalStorage extends Mock implements GlobalStorage {


// // }

// // void main() {
// //   late MockLoginBloc mockLoginBloc;
// //   late MockGlobalStorage mockGlobalStorage;
// //   late LoginPageState loginPageState;
// //   // late MockDioClient mockDioClient;

// //   setUp(() {
// //     mockLoginBloc = MockLoginBloc();
// //     mockGlobalStorage = MockGlobalStorage();

// //     GetIt.I.registerSingleton<LoginBloc>(mockLoginBloc);
// //     GetIt.I.registerSingleton<GlobalStorage>(mockGlobalStorage);
// //       // GetIt.I.registerSingleton<DioClient>(MockDioClient());

// //     loginPageState = LoginPageState();
// //     loginPageState.loginBloc = mockLoginBloc;
// //   });

// //   tearDown(() {
// //     GetIt.I.reset();
// //   });

// //   group('LoginScreen State Tests', () {
// //     test('Form validation succeeds and OTP is sent', () async {
// //       loginPageState.controller.text = '1234567890';
// //       bool isValid = loginPageState.loginFormKey.currentState?.validate() ?? false;

// //       expect(isValid, true);
// //       loginPageState.globalStorage.saveMobileNumber(accessMobileNumber: loginPageState.controller.text);

// //       loginPageState.loginBloc.add(SendOTP(mobileNumber: loginPageState.controller.text));

// //       verify(mockGlobalStorage.saveMobileNumber(accessMobileNumber: '1234567890')).called(1);
// //       verify(mockLoginBloc.add(SendOTP(mobileNumber: '1234567890'))).called(1);
// //     });

// //     test('Form validation fails with invalid phone number', () {
// //       loginPageState.controller.text = '12345'; // Invalid number
// //       bool isValid = loginPageState.loginFormKey.currentState?.validate() ?? false;

// //       expect(isValid, false);
// //     //  verifyNever(mockLoginBloc.add(SendOTP(mobileNumber: "")));
// //     });


// //   });
// // }

// // import 'dart:convert';

// // import 'package:Woloo_Smart_hygiene/main.dart';
// // import 'package:http/http.dart' as http;
// // // import 'package:mocking/main.dart';
// // import 'package:mockito/annotations.dart';

// // // Generate a MockClient using the Mockito package.
// // // Create new instances of this class in each test.
// // import 'package:flutter_test/flutter_test.dart';
// // import 'package:http/http.dart' as http;
// // // import 'package:mocking/main.dart';
// // import 'package:mockito/annotations.dart';
// // import 'package:mockito/mockito.dart';

// // // import 'fetch_album_test.mocks.dart';
// // import 'unit_test.mocks.dart';

// // // Generate a MockClient using the Mockito package.
// // // Create new instances of this class in each test.
// // @GenerateMocks([http.Client])
// // void main() {
// //   group('fetchAlbum', () {
// //     test('returns an Album if the http call completes successfully', () async {
// //       final client = MockClient();

// //       // Use Mockito to return a successful response when it calls the
// //       // provided http.Client.
// //       when(client
// //               .get(Uri.parse('https://jsonplaceholder.typicode.com/albums/1')))
// //           .thenAnswer((_) async =>
// //               http.Response('{"userId": 1, "id": 2, "title": "mock"}', 200));

// //       expect(await fetchAlbum(client), isA<Album>());
// //     });

// //     test('throws an exception if the http call completes with an error', () {
// //       final client = MockClient();

// //       // Use Mockito to return an unsuccessful response when it calls the
// //       // provided http.Client.
// //       when(client
// //               .get(Uri.parse('https://jsonplaceholder.typicode.com/albums/1')))
// //           .thenAnswer((_) async => http.Response('Not Found', 404));

// //       expect(fetchAlbum(client), throwsException);
// //     });
// //   });
// // }

// import 'package:Woloo_Smart_hygiene/core/network/api_constant.dart';
// import 'package:Woloo_Smart_hygiene/core/network/dio_client.dart';
// import 'package:Woloo_Smart_hygiene/screens/login/data/model/send_otp.dart';
// import 'package:Woloo_Smart_hygiene/screens/login/data/model/verify_otp_model.dart';
// import 'package:Woloo_Smart_hygiene/screens/login/data/network/login_services.dart';
// import 'package:dio/dio.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:mockito/annotations.dart';
// import 'package:mockito/mockito.dart';
// import 'package:http/http.dart' as http;

// import 'unit_test.mocks.dart';

// @GenerateMocks([http.Client])
// void main() {
//   // late Dio dioClient;
//   // late String endpoint;
//   // late String baseUrl;
//    late  SendOtp  res;
//   late LoginService loginService;



//   group("Test Login Module Endpoint API calls", () {
//     setUp(() {

//       // final sl = GetIt.instance;
//        var dio = Dio();
//     // sl.registerSingleton(() => DioClient(dio));
// //     GetIt.I.registerSingleton<GlobalStorage>(mockGlobalStorage);
//       // GetIt.I.registerSingleton<DioClient>(MockDioClient());
//       // baseUrl = "https://staging-api.woloo.in";
//       // dioClient = Dio(BaseOptions());
//       // endpoint =  APIConstants.SEND_OTP;
//       loginService = LoginService(dio: DioClient(dio) );
      
//       //UniversityEndpoint(dioClient, baseUrl: baseUrl);
//     });

//     test('Test send otp endpoints ', () async {
//       // dioClient.httpClientAdapter = _createMockAdapterForSearchRequest(
//       //   200,
//       //   [],
//       // );
//        final client = MockClient();
//         when(client
//               .post(
//                 body: {  "mobileNumber": "8097267015",},
//                 Uri.parse(APIConstants.BASE_URL+ APIConstants.SEND_OTP )))
//           .thenAnswer((_) async =>
//               http.Response('   "results": {  "request_id": "8bac61ad-2926-4821-8a77-2113f49b4491"  },"success": true', 200));
//         res =    await loginService.sendOTP( phoneNumber: "8097267015");
//       expect(res, isA<SendOtp>());
//     //  var result =  await loginService.sendOTP( phoneNumber: "8097267015");
//      //   print("res ${result.requestId}");
//       // await endpoint.getUniversitiesByCountry("us");
//     //  expect(result, SendOtp(requestId: "ea7e8e99-edfe-4e7f-b6d9-42abc0a306f1" ));
//     });

//         test('testing api endpoints', () async {
//       // dioClient.httpClientAdapter = _createMockAdapterForSearchRequest(
//       //   200,
//       //   [],
//       // );
//        final client = MockClient();
//         when(client
//               .post(
//                 body: {  "request_id" : "6de27dd6-e3f9-4b7b-8e14-3a5aeda1db3f", "otp":"8183"},
//                 Uri.parse(APIConstants.BASE_URL+ APIConstants.VERIFY_OTP )))
//           .thenAnswer((_) async =>
//               http.Response('  "results": { "name": "shrirang  jangam",  "mobile": "8097267015", "id": 419, "role_id": 2,  "token": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6NDE5LCJyb2xlX2lkIjoyLCJpYXQiOjE3MzA3NzQ1OTUsImV4cCI6MTczMTM3OTM5NX0.cHWD0idDyb4NNRaFQHl05caNYz-9CzyWp6gW3_XKxWs"  }, "success": true', 200));

//       expect(await loginService.verifyOTP(otp: "8183", requestId: "6de27dd6-e3f9-4b7b-8e14-3a5aeda1db3f"), isA<VerifyOtpModel>());
//     //  var result =  await loginService.sendOTP( phoneNumber: "8097267015");
//      //   print("res ${result.requestId}");
//       // await endpoint.getUniversitiesByCountry("us");
//     //  expect(result, SendOtp(requestId: "ea7e8e99-edfe-4e7f-b6d9-42abc0a306f1" )) ;
//     });

//     //   test('Test endpoint calls ', () async {
//     //   // dioClient.httpClientAdapter = _createMockAdapterForSearchRequest(
//     //   //   200,
//     //   //   [],
//     //   // );
//     //    final client = MockClient();
//     //     when(client
//     //           .post(
//     //             body: {  "mobileNumber": "8097267015",},
//     //             Uri.parse(APIConstants.BASE_URL+ APIConstants.SEND_OTP )))
//     //       .thenAnswer((_) async =>
//     //           http.Response('   "results": {  "request_id": "8bac61ad-2926-4821-8a77-2113f49b4491"  },"success": true', 200));

//     //   expect(await loginService.sendOTP( phoneNumber: "8097267015"), isA<SendOtp>());
//     // //  var result =  await loginService.sendOTP( phoneNumber: "8097267015");
//     //  //   print("res ${result.requestId}");
//     //   // await endpoint.getUniversitiesByCountry("us");
//     // //  expect(result, SendOtp(requestId: "ea7e8e99-edfe-4e7f-b6d9-42abc0a306f1" )) ;
//     // });

//     // test('Test endpoint returns error', () async {
//     //   // dioClient.httpClientAdapter = _createMockAdapterForSearchRequest(
//     //   //   404,
//     //   //   {"error": "Not found!"},
//     //   // );
//     //   SendOtp? response;
//     //   DioError? error;
//     //   // try {
//     //     final client = MockClient();

//     //   // Use Mockito to return an unsuccessful response when it calls the
//     //   // provided http.Client.
//     //      when(client
//     //           .post(
//     //             body: {  "mobileNumber": "8097267015",},
//     //             Uri.parse(APIConstants.BASE_URL+ APIConstants.SEND_OTP )))
//     //       .thenAnswer((_) async => http.Response('Bad Request', 400));

//     //   expect(await loginService.sendOTP( phoneNumber: "809726701"), throwsException);
//     // //    var result =  await loginService.sendOTP( phoneNumber: "8097267015");
//     //   // } on DioError catch (dioError, _) {
//     //     // error = dioError;
//     //   // }
//     //  // expect(response, null);
//     // //  expect(error?.error, "Http status error [404]");
//     // });

//     // test('Test endpoint calls and returns 2 valid universities', () async {
//     //   dioClient.httpClientAdapter = _createMockAdapterForSearchRequest(
//     //     200,
//     //     generateTwoValidUniversities(),
//     //   );
//     //   var result = await endpoint.getUniversitiesByCountry("us");
//     //   expect(result, expectedTwoValidUniversities());
//     // });
//   });
// }