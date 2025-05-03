


import 'package:flutter/material.dart';
import 'package:woloo_smart_hygiene/client_flow/screens/dashbaord/view/home.dart';

import '../../../../screens/common_widgets/image_provider.dart';
import '../../../../utils/app_color.dart';
import '../../../../utils/app_images.dart';
import '../../../../utils/app_textstyle.dart';
import '../../subcription/view/clientprofile.dart';
import 'home_dashboard.dart';

class ClientDashboard extends StatefulWidget {
  const ClientDashboard({super.key});

  @override
  State<ClientDashboard> createState() => _ClientDashboardState();
}

class _ClientDashboardState extends State<ClientDashboard> {
       int _selectedIndex = 0;
     void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

      final List<Widget> _widgetOptions = <Widget>[
        const HomeDashboard(),
         const Clientprofile()

       ];

  @override
  Widget build(BuildContext context) {
    return   Scaffold(
      backgroundColor: AppColors.white,
      // appBar: AppBar(
      //   backgroundColor: AppColors.white,
      // ),
      body:
      Center(child: _widgetOptions.elementAt(_selectedIndex)),
      bottomNavigationBar:  BottomNavigationBar(
            backgroundColor: AppColors.white,
          elevation: 15,
          unselectedItemColor:  AppColors.black,
          unselectedLabelStyle:  AppTextStyle.font12bold,
          items:  <BottomNavigationBarItem>[
            const BottomNavigationBarItem(
              icon: Icon(Icons.task_outlined,
               size: 30,
              ),
              label: 'Home',
      
            ),
            BottomNavigationBarItem(
              icon:  CustomImageProvider(
                image: AppImages.iotIcons,
                width: 30,
                height: 30,
                color:
                _selectedIndex == 1 ?
                AppColors.buttonBgColor
                : null
                ,
              ),
              label: 'Profile',
      
            ),
          
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: AppColors.buttonBgColor,
          onTap: _onItemTapped,
        ),
    );
  }
}