import 'package:flutter/material.dart';
import 'package:woloo_smart_hygiene/utils/app_images.dart';

class Category {
  String name;
  String imageUrl;
  Color color;
  Category({this.name = "", required this.imageUrl, this.color = Colors.red});
}

final categories = [
  Category(
      name: 'General',
      imageUrl: AppImages.general,
      color: const Color(0xffFDEBD2)),
  Category(
      name: 'Cleaning',
      imageUrl: AppImages.cleaning,
      color: const Color(0xffFBDDDD)),
  Category(
      name: 'Toilet Gadgets',
      imageUrl: AppImages.toileries,
      color: const Color(0xffC7E3F9)),
  Category(
      name: 'Dusting',
      imageUrl: AppImages.dusting,
      color: const Color(0xffD5FFED)),
  Category(
      name: 'Kitchen',
      imageUrl: AppImages.kitchen,
      color: const Color(0xffFEF9BD)),
  Category(
      name: 'Uniforms',
      imageUrl: AppImages.uniforms,
      color: const Color(0xffFBDDDD)),
];

final topBrands = [
  Category(imageUrl: AppImages.fenyl1),
  Category(imageUrl: AppImages.fenyl2),
  Category(imageUrl: AppImages.fenyl3),
  Category(imageUrl: AppImages.fenyl4),
  Category(imageUrl: AppImages.fenyl5),
  Category(imageUrl: AppImages.fenyl6),
];
