import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:simple_floating_bottom_nav_bar/floating_item.dart';
import 'package:woloo_smart_hygiene/enums/ecom_tabs.dart';
import 'package:woloo_smart_hygiene/utils/app_color.dart';
import 'package:woloo_smart_hygiene/utils/app_images.dart';
import 'package:woloo_smart_hygiene/utils/list.dart';

class EcomScreen extends StatefulWidget {
  const EcomScreen({super.key});

  @override
  State<EcomScreen> createState() => _EcomScreenState();
}

class _EcomScreenState extends State<EcomScreen> {
  EcomTab tab = EcomTab.seeLess;
  int currentIndex = 0;
  List<FloatingBottomNavItem> bottomNavItems = const [
    FloatingBottomNavItem(
      inactiveIcon: Icon(Icons.home_outlined),
      activeIcon: Icon(Icons.home),
      label: "Home",
    ),
    FloatingBottomNavItem(
      inactiveIcon: Icon(Icons.search_outlined),
      activeIcon: Icon(Icons.search),
      label: "Search",
    ),
    FloatingBottomNavItem(
      inactiveIcon: Icon(Icons.add_circle_outline),
      activeIcon: Icon(Icons.add_circle),
      label: "Add",
    ),
    FloatingBottomNavItem(
      inactiveIcon: Icon(Icons.person_outline),
      activeIcon: Icon(Icons.person),
      label: "Profile",
    ),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // bottomNavigationBar: FloatingBottomNavBar(
      //   pages: const [
      //     Center(child: Text("Home")),
      //     Center(child: Text("Search")),
      //     Center(child: Text("Add")),
      //     Center(child: Text("Profile")),
      //   ],
      //   items: bottomNavItems,
      //   initialPageIndex: 0,
      //   backgroundColor: Colors.green,
      //   bottomPadding: 10,
      //   elevation: 0,
      //   radius: 20,
      //   width: 300,
      //   height: 40,
      // ),
      appBar: EComAppbar(
        isAll: tab == EcomTab.seeAll,
      ),
      body: tab == EcomTab.seeLess
          ? SingleChildScrollView(
              child: Column(
                children: [
                  const CategoriesSection(),
                  LandingProducts(
                    onTap: () {
                      setState(() {
                        if (tab == EcomTab.seeLess) {
                          tab = EcomTab.seeAll;
                        } else {
                          tab = EcomTab.seeLess;
                        }
                      });
                    },
                  ),
                ],
              ),
            )
          : Stack(
              children: [
                SingleChildScrollView(
                  child: Container(
                    decoration: const BoxDecoration(
                      color: AppColors.themeBackground,
                    ),
                    padding:
                        EdgeInsets.symmetric(vertical: 16.h, horizontal: 20.w),
                    child: Column(
                      spacing: 10.h,
                      children: [
                        Row(
                          children: [
                            Text("All Products",
                                style: TextStyle(
                                    fontSize: 20.sp,
                                    fontWeight: FontWeight.bold)),
                            const Spacer(),
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  tab = EcomTab.seeLess;
                                });
                              },
                              child: const Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(
                                    Icons.arrow_back_ios_new_rounded,
                                    size: 10,
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    "Back",
                                    style: TextStyle(
                                        fontSize: 10,
                                        color: AppColors.greyCircleColor,
                                        fontWeight: FontWeight.bold),
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                        GridView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 10,
                            mainAxisSpacing: 10,
                            childAspectRatio: 0.6,
                          ),
                          itemCount: topBrands.length,
                          itemBuilder: (context, index) {
                            return GridItem(
                              imageUrl: topBrands[index].imageUrl,
                            );
                          },
                        ),
                        SizedBox(
                          height: 60.h,
                        ),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  bottom: 20,
                  right: 0,
                  left: 0,
                  // alignment: Alignment.bottomCenter,
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 12.w),
                    padding: EdgeInsets.symmetric(
                      horizontal: 20.w,
                      vertical: 10.h,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.themeBackground,
                      borderRadius: BorderRadius.circular(12.r),
                      boxShadow: const [
                        BoxShadow(
                          color: AppColors.greyShadowColor,
                          blurRadius: 5.0,
                          spreadRadius: 0.5,
                          offset: Offset(0, -1),
                        ),
                      ],
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        XNavBarItems(
                          imageUrl: AppImages.homeIcon,
                          title: "Home",
                        ),
                        XNavBarItems(
                          imageUrl: AppImages.products,
                          title: "Products",
                        ),
                        XNavBarItems(
                          imageUrl: AppImages.monitoring,
                          title: "Monitoring",
                        ),
                        XNavBarItems(
                          imageUrl: AppImages.services,
                          title: "Services",
                        ),
                        XNavBarItems(
                          imageUrl: AppImages.profileIcon,
                          title: "Profile",
                        ),
                      ],
                    ),
                  ),
                )
             
              ],
            ),
    );
  }
}

class XNavBarItems extends StatelessWidget {
  const XNavBarItems({
    super.key,
    required this.imageUrl,
    required this.title,
  });
  final String imageUrl;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          height: 23.h,
          width: 23.h,
          child: Image.asset(
            imageUrl,
            fit: BoxFit.fill,
          ),
        ),
        SizedBox(
          height: 8.h,
        ),
        Text(
          title,
          style: TextStyle(fontSize: 10.5.sp, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}

class LandingProducts extends StatelessWidget {
  const LandingProducts({
    super.key,
    this.onTap,
  });
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.themeBackground,
      padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 20.w),
      child: Column(
        spacing: 10.h,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                "Top Brands",
                style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold),
              ),
              const Spacer(),
              const SeeMoreButton()
            ],
          ),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              childAspectRatio: 1.0,
            ),
            itemCount: topBrands.length,
            itemBuilder: (context, index) {
              return BrandsGrid(
                imageUrl: topBrands[index].imageUrl,
              );
            },
          ),
          Row(
            children: [
              Text(
                "Collections",
                style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold),
              ),
              const Spacer(),
              SeeMoreButton(
                onTap: onTap,
              )
            ],
          ),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              childAspectRatio: 0.6,
            ),
            itemCount: topBrands.length,
            itemBuilder: (context, index) {
              return GridItem(
                imageUrl: topBrands[index].imageUrl,
              );
            },
          ),
          SizedBox(
            height: 5.h,
          ),
          Text(
            "New in Store",
            style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 130.h,
            child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemBuilder: (c, i) => ClipRRect(
                    borderRadius: BorderRadius.circular(25.r),
                    child: Image.asset(AppImages.bTemplate)),
                separatorBuilder: (c, i) => const SizedBox(
                      width: 10,
                    ),
                itemCount: 4),
          ),
        ],
      ),
    );
  }
}

class BrandsGrid extends StatelessWidget {
  const BrandsGrid({
    super.key,
    required this.imageUrl,
  });
  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25.r),
          boxShadow: const [
            BoxShadow(
              color: AppColors.greyShadowColor,
              blurRadius: 5.0,
              spreadRadius: 0.5,
              offset: Offset(0, 2),
            ),
            BoxShadow(
              color: AppColors.greyShadowColor,
              blurRadius: 5.0,
              spreadRadius: 0.5,
              offset: Offset(0, -1),
            ),
          ]),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(25.r),
        child: Image.asset(
          imageUrl,
          fit: BoxFit.fill,
        ),
      ),
    );
  }
}

class GridItem extends StatelessWidget {
  const GridItem({
    super.key,
    required this.imageUrl,
  });
  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w),
      decoration: BoxDecoration(
          color: AppColors.themeBackground,
          borderRadius: BorderRadius.circular(25.r),
          boxShadow: const [
            BoxShadow(
              color: AppColors.greyShadowColor,
              blurRadius: 5.0,
              spreadRadius: 0.5,
              offset: Offset(0, 2),
            ),
            BoxShadow(
              color: AppColors.greyShadowColor,
              blurRadius: 5.0,
              spreadRadius: 0.5,
              offset: Offset(0, -1),
            ),
          ]),
      child: Column(
        spacing: 2.h,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.vertical(top: Radius.circular(25.r)),
            child: SizedBox(
              height: 165.h,
              child: Image.asset(
                imageUrl,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Text(
            "vurky room freshner",
            style: TextStyle(fontSize: 10.5.sp, fontWeight: FontWeight.bold),
          ),
          Text(
            "vurky",
            style: TextStyle(
              fontSize: 8.sp,
              color: AppColors.textgreyColor,
              fontWeight: FontWeight.bold,
            ),
          ),
          Row(
            children: List.generate(
              5,
              (i) => Container(
                  margin: EdgeInsets.only(right: 2.w),
                  height: 10.h,
                  width: 10.w,
                  child: Image.asset(AppImages.stars)),
            ),
          ),
          Row(
            children: [
              Text(
                "Rs. 799",
                style: TextStyle(
                  fontSize: 13.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Spacer(),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 4.h),
                decoration: BoxDecoration(
                    color: AppColors.buttonColor,
                    borderRadius: BorderRadius.circular(3.r)),
                child: Row(
                  children: [
                    Icon(
                      Icons.shopping_cart_outlined,
                      color: AppColors.black,
                      size: 10.sp,
                    ),
                    SizedBox(
                      width: 5.w,
                    ),
                    Text(
                      "Add to Cart",
                      style: TextStyle(
                          fontSize: 8.sp,
                          color: AppColors.black,
                          fontWeight: FontWeight.bold),
                    )
                  ],
                ),
              )
            ],
          )
        ],
      ),
    );
 
  }
}

class SeeMoreButton extends StatelessWidget {
  const SeeMoreButton({
    super.key,
    this.onTap,
  });
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            "See More",
            style: TextStyle(
              fontSize: 10.sp,
              color: AppColors.greyCircleColor,
            ),
          ),
          SizedBox(
            width: 5.w,
          ),
          Container(
            height: 15.h,
            width: 15.h,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: AppColors.greyCircleColor,
                width: 1.5,
              ),
            ),
            child: const Center(
              child: Icon(
                Icons.arrow_forward_ios_rounded,
                color: AppColors.black,
                size: 12,
              ),
            ),
          )
        ],
      ),
    );
  }
}

class CategoriesSection extends StatelessWidget {
  const CategoriesSection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
      decoration: const BoxDecoration(
        color: AppColors.containerTabColor,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Text(
            'Categories',
            style: TextStyle(
              fontSize: 20.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 10.h),
          SizedBox(
            height: 100.h,
            child: ListView.separated(
              itemCount: categories.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                final category = Category(
                  name: categories[index].name,
                  imageUrl: categories[index].imageUrl,
                  color: categories[index].color,
                );
                return Column(
                  children: [
                    CircleAvatar(
                      radius: 36.5.r,
                      backgroundColor: category.color,
                      child: Center(
                        child: Image.asset(
                          category.imageUrl,
                          width: 40.w,
                          height: 40.h,
                        ),
                      ),
                    ),
                    SizedBox(height: 10.h),
                    Text(
                      category.name,
                      style: TextStyle(
                        fontSize: 10.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                );
              },
              separatorBuilder: (context, index) {
                return SizedBox(
                  width: 10.w,
                );
              },
            ),
          )
        ],
      ),
    );
  }
}

class EComAppbar extends StatelessWidget implements PreferredSizeWidget {
  const EComAppbar({
    super.key,
    this.isAll = false,
  });
  final bool isAll;
  @override
  Size get preferredSize => const Size.fromHeight(130);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.themeBackground,
      actions: [
        Badge(
          label: const Text('2'),
          child: CircleAvatar(
            backgroundColor: AppColors.greyIcon,
            child: IconButton(
              icon: ImageIcon(AssetImage(AppImages.bag)),
              onPressed: () {},
            ),
          ),
        ),
        SizedBox(width: 10.w),
      ],
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Home',
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          Row(
            children: [
              Text(
                "1234 Lane road, Area, Location, Landmark",
                style: TextStyle(
                  fontSize: 12.sp,
                  color: Colors.grey,
                ),
              ),
              SizedBox(width: 5.w),
              Container(
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    shape: BoxShape.circle),
                child: const Icon(
                  Icons.arrow_drop_down,
                  color: Colors.grey,
                ),
              ),
            ],
          )
        ],
      ),
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(65),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 5.h),
          child: Row(
            children: [
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12.r),
                      boxShadow: const [
                        BoxShadow(
                          color: AppColors.greyShadowColor,
                          blurRadius: 5.0,
                          spreadRadius: 0.5,
                          offset: Offset(0, 2),
                        ),
                        BoxShadow(
                          color: AppColors.greyShadowColor,
                          blurRadius: 5.0,
                          spreadRadius: 0.5,
                          offset: Offset(0, -1),
                        ),
                      ]),
                  child: TextField(
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: AppColors.themeBackground,
                      hintText: 'Search Products',
                      prefixIcon: const Icon(Icons.search),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.r),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ),
              ),
              if (isAll) ...[
                SizedBox(
                  width: 10.w,
                ),
                Container(
                  height: 41.h,
                  width: 41.h,
                  decoration: const BoxDecoration(
                    color: AppColors.themeBackground,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.greyShadowColor,
                        blurRadius: 5.0,
                        spreadRadius: 0.5,
                        offset: Offset(0, 2),
                      ),
                      BoxShadow(
                        color: AppColors.greyShadowColor,
                        blurRadius: 5.0,
                        spreadRadius: 0.5,
                        offset: Offset(0, -1),
                      ),
                    ],
                  ),
                  child: Center(
                    child: Image.asset(
                      AppImages.tuneLogo,
                      height: 20.h,
                      width: 20.w,
                    ),
                  ),
                )
              ]
            ],
          ),
        ),
      ),
    );
  }
}
