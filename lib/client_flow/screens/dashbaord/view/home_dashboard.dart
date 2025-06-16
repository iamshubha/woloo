import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:woloo_smart_hygiene/client_flow/utils/client_images.dart';
import 'package:woloo_smart_hygiene/screens/common_widgets/image_provider.dart';
import 'package:woloo_smart_hygiene/utils/app_color.dart';
import 'package:woloo_smart_hygiene/utils/app_constants.dart';
import 'package:woloo_smart_hygiene/utils/app_textstyle.dart';

import '../../../../core/local/global_storage.dart';
import '../../../../screens/login/view/login_screen.dart';
import '../../../../screens/supervisor_dashboard/view/supervisor_dashboard_screen.dart';
import '../../../../utils/app_images.dart';
import '../../../widgets/CustomButton.dart';
import '../../subcription/view/subcription.dart';
import '../bloc/dashboard_bloc.dart';
import '../bloc/dashboard_event.dart';
import '../bloc/dashboard_state.dart';
import '../data/model/facility_model.dart';
import 'home_tabbar.dart';

class HomeDashboard extends StatefulWidget {
  const HomeDashboard({super.key});

  @override
  State<HomeDashboard> createState() => _HomeDashboardState();
}

class _HomeDashboardState extends State<HomeDashboard> {
  ClientDashBoardBloc dashBoardBloc = ClientDashBoardBloc();
  Map<String, dynamic>? decodedToken;
  GlobalStorage globalStorage = GetIt.instance();
  List<Facility> facility = [];
  Duration difference = const Duration();

  bool isClientSupervisor = false;
  String? clientName;
  String? planId;
  String? formatted;
  bool isChanges = false;

  @override
  void initState() {
    super.initState();
    var some = globalStorage.getClientToken();
    String clintId = globalStorage.getClientId();

    clientName = globalStorage.getSupervisorName();

    DateTime now = DateTime.now();
    formatted = DateFormat('h:mm a, d MMM yyyy').format(now);

    print("plamn  $planId");

    dashBoardBloc.add(SubcriptionEvent(id: int.parse(clintId)));

    dashBoardBloc.add(CheckSupvisorEvent(id: int.parse(clintId)));

    decodedToken = JwtDecoder.decode(some);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: AppColors.white,
        titleSpacing: 0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            CustomImageProvider(
              image: AppImages.dashlogo,
              width: 80,
              height: 80,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Hello $clientName",
                  style: AppTextStyle.font14bold,
                ),
                Text(
                  formatted!,
                  style: AppTextStyle.font12,
                )
              ],
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 0),
          child: Column(
            children: [
              const SizedBox(
                height: 14,
              ),
              BlocConsumer(
                bloc: dashBoardBloc,
                listener: (context, state) {
                  print("state in dashbaord $state ");

                  if (state is DashboarLoading) {
                    EasyLoading.show(status: state.message);
                  }

                  if (state is GetAllFacility) {
                    EasyLoading.dismiss();

                    facility = state.facilityModel!.results!.facilities!;

                    print("facility length ${facility.length}");

                    if (facility.isEmpty) {
                      facility.add(Facility(
                        facilityName: "Add Facility/Task",
                        id: 0,
                      ));
                    }

                    facility.insert(
                        0,
                        Facility(
                          facilityName: "Add Facility/Task",
                          id: 0,
                        ));

                    print("facility length ${facility.length}");
                  }

                  if (state is Subcription) {
                    planId = globalStorage.getPlanId();
                    print("plan id $planId");

                    dashBoardBloc.add(GetAllFacilityEvent(
                        clientId: int.parse(globalStorage.getClientId())));

                    DateTime currentDate = DateTime.now();
                    DateTime futureDate =
                        state.subscriptionModel!.results!.expiryDate!;
                    print('Difference: $futureDate days');
                    difference = futureDate.difference(currentDate);

                    print('Difference: ${difference.inDays} days');

                    EasyLoading.dismiss();

                    if (difference.inDays == 0 && planId == "0") {
                      showDialog(
                        barrierDismissible: false,
                        context: context,
                        builder: (context) {
                          return PopScope(
                            canPop: false,
                            child: AlertDialog(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(60),
                              ),
                              backgroundColor: AppColors.white,
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
                                      "Your TASKMASTER Trial Period has expired. Kindly pay to Continue",
                                      style: AppTextStyle.font18bold,
                                    ),
                                    SizedBox(
                                      height: 20.h,
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        showModalBottomSheet(
                                          backgroundColor: Colors.transparent,
                                          context: context,
                                          builder: (context) {
                                            return SubcriptionScreen(
                                              dashBoardBloc: dashBoardBloc,
                                              isfromFacility: true,
                                              facilityId: facility[1].id,
                                            );
                                          },
                                        );
                                      },
                                      child: const Custombutton(
                                        width: 300,
                                        text: "Pay Now",
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      );
                    }
                  }

                  if (state is DashboarError) {
                    EasyLoading.dismiss();
                    EasyLoading.showError(state.error);
                  }
                },
                builder: (context, state) {
                  return difference.inDays != 0 && planId != "0"
                      ? const SizedBox()
                      : Column(
                          children: [
                            Text(
                              "Your Free Subscription shall end in ${difference.inDays} Days.",
                              style: AppTextStyle.font13
                                  .copyWith(color: AppColors.textgreyColor),
                            ),
                            GestureDetector(
                              onTap: () {
                                showModalBottomSheet(
                                  context: context,
                                  backgroundColor: Colors.transparent,
                                  builder: (context) {
                                    return SubcriptionScreen(
                                      dashBoardBloc: dashBoardBloc,
                                      isfromFacility: true,
                                      facilityId: facility[1].id,
                                    );
                                  },
                                );
                              },
                              child: Text(
                                textAlign: TextAlign.center,
                                DashboardConst.renew,
                                style: AppTextStyle.font13.copyWith(
                                  color: AppColors.textgreyColor,
                                  decoration: TextDecoration.underline,
                                ),
                              ),
                            ),
                          ],
                        );
                },
              ),
              BlocConsumer(
                  listener: (context, state) {
                    if (state is DashboarLoading) {
                      EasyLoading.show(status: state.message);
                    }

                    if (state is CheckSupervisor) {
                      EasyLoading.dismiss();

                      isClientSupervisor = state
                          .checkSupervisorModel!.results!.isClientSupervisor!;
                    }

                    if (state is DashboarError) {
                      EasyLoading.dismiss();
                      EasyLoading.showError(state.error);
                    }
                  },
                  bloc: dashBoardBloc,
                  builder: (context, state) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                DashboardConst.dashboardOverview,
                                style: AppTextStyle.font20bold,
                              ),
                              isClientSupervisor
                                  ? GestureDetector(
                                      onTap: () {
                                        String supervisorToken =
                                            globalStorage.getToken();

                                        Navigator.of(context)
                                            .push(MaterialPageRoute(
                                          builder: (context) {
                                            return supervisorToken == ""
                                                ? const LoginScreen(
                                                    type: null,
                                                  )
                                                : const SupervisorDashboard(
                                                    isFromSupervisor: true);
                                          },
                                        ));
                                      },
                                      child: Container(
                                        width: 40,
                                        height: 40,
                                        decoration: BoxDecoration(
                                          color: AppColors.white,
                                          borderRadius:
                                              BorderRadius.circular(12),
                                          boxShadow: [
                                            BoxShadow(
                                              color: Colors.black
                                                  .withValues(alpha: 0.2),
                                              spreadRadius: 1,
                                              blurRadius: 10,
                                              offset: const Offset(0, 0),
                                            ),
                                          ],
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: CustomImageProvider(
                                            image: AppImages.changeArrow,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                    )
                                  : const SizedBox()
                            ],
                          ),
                          SizedBox(
                              height: 945.h,
                              child: HomeTabbar(
                                facility: facility,
                                clientDashBoardBloc: dashBoardBloc,
                              ))
                        ],
                      ),
                    );
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
