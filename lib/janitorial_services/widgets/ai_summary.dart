import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:woloo_smart_hygiene/utils/app_images.dart';

class AiSummaryCard extends StatelessWidget {
  final String summary;

  const AiSummaryCard({
    super.key,
    required this.summary,
    this.fontSize = 20,
  });
  final double fontSize;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(35),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                'AI Summary ',
                style: TextStyle(
                  fontSize: fontSize.sp,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(
                width: 8,
              ),
              SizedBox(
                height: 24,
                width: 24,
                child: Image.asset(AppImages.twinkleLogo),
              ),
            ],
          ),
          const SizedBox(height: 12),
          summary.isEmpty
              ? const Text('[Summary here]',
                  style: TextStyle(color: Colors.grey))
              : Text(
                  summary,
                  style: const TextStyle(fontSize: 14),
                ),
        ],
      ),
    );
  }
}
