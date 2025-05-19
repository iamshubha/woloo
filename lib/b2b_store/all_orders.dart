import 'package:animated_rating_stars/animated_rating_stars.dart';
import 'package:flutter/material.dart';
import 'package:woloo_smart_hygiene/b2b_store/cart.dart';
import 'package:woloo_smart_hygiene/b2b_store/order_details.dart';
import 'package:woloo_smart_hygiene/b2b_store/product_details.dart';
import 'package:woloo_smart_hygiene/utils/app_color.dart';
import 'package:woloo_smart_hygiene/utils/app_images.dart';
import 'package:woloo_smart_hygiene/utils/app_textstyle.dart';

class AllOrderScreen extends StatelessWidget {
  const AllOrderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const BackAppBar(),
      body: Column(
        children: [
          CartHeader(
              imgPath: AppImages.bag,
              title: "Order",
              subtitle: "check your recent order here"),
          const SizedBox(
            height: 10,
          ),
          Expanded(
              child: ListView.separated(
                  itemBuilder: (c, i) => XDecoratedBox(
                          child: Column(
                        spacing: 20,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text("Order Id : 1234567890"),
                          Column(
                            mainAxisSize: MainAxisSize.min,
                            spacing: 10,
                            children: List.generate(
                                4, (i) => const OrderItemWithReview()),
                          )
                        ],
                      )),
                  separatorBuilder: (c, i) => const SizedBox(
                        height: 10,
                      ),
                  itemCount: 5)),
        ],
      ),
    );
  }
}

class OrderItemWithReview extends StatelessWidget {
  const OrderItemWithReview({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return XDecoratedBox(
        child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          spacing: 20,
          children: [
            Flexible(
              flex: 2,
              child: SizedBox(
                height: 60,
                width: 60,
                child: Image.asset(AppImages.pest),
              ),
            ),
            Flexible(
              flex: 8,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Small Menstrual Cups",
                    style: AppTextStyle.font14bold,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text("Rs. 480"),
                      // const Spacer(),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (c) => const OrderScreen()));
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              vertical: 4, horizontal: 8),
                          decoration: BoxDecoration(
                              color: AppColors.buttonYellowColor,
                              borderRadius: BorderRadius.circular(6)),
                          child: Row(
                            children: [
                              Text(
                                "Check Status",
                                style: AppTextStyle.font12bold,
                              ),
                              const Icon(
                                Icons.arrow_forward_ios,
                                size: 20,
                              )
                            ],
                          ),
                        ),
                      )
                    ],
                  )
                ],
              ),
            )
          ],
        ),
        AnimatedRatingStars(
          initialRating: 3.5,
          minRating: 0.0,
          maxRating: 5.0,
          filledColor: Colors.amber,
          emptyColor: Colors.grey,
          filledIcon: Icons.star,
          halfFilledIcon: Icons.star_half,
          emptyIcon: Icons.star_border,
          onChanged: (double rating) {
            // Handle the rating change here
            print('Rating: $rating');
          },
          displayRatingValue: true,
          interactiveTooltips: true,
          customFilledIcon: Icons.star,
          customHalfFilledIcon: Icons.star_half,
          customEmptyIcon: Icons.star_border,
          starSize: 30.0,
          animationDuration: const Duration(milliseconds: 300),
          animationCurve: Curves.easeInOut,
          readOnly: false,
        ),
        const Text("Rate this product now"),
      ],
    ));
  }
}
