import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:free_lancer/core/utils/app_colors.dart';

class AboutUsWidget extends StatelessWidget {
  final String image;
  final String name;
  final String jobTitle;
  final String description;
  const AboutUsWidget({
    super.key,
    required this.name,
    required this.jobTitle,
    required this.description,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: AppColors.white.withOpacity(0.4),
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            blurRadius: 5,
            color: AppColors.grey.withOpacity(0.2),
            offset: const Offset(0, 5),
          ),
          BoxShadow(
            blurRadius: 5,
            color: AppColors.grey.withOpacity(0.2),
            offset: const Offset(5, 0),
          ),
          BoxShadow(
            blurRadius: 5,
            color: AppColors.grey.withOpacity(0.2),
            offset: const Offset(-5, 0),
          ),
        ],
      ),
      child: ListView(
        children: [
          Card(
            elevation: 0.5,
            color: AppColors.white.withOpacity(0.8),
            child: Column(
              children: [
                CircleAvatar(
                  radius: 50,
                  child: SvgPicture.asset(
                    image,
                  ),
                ),
                Text(
                  name,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                    color: AppColors.black,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  jobTitle,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                    color: AppColors.black,
                  ),
                ),
              ],
            ),
          ),
          Text(
            description,
            style: const TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.normal,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.call),
              ),
              IconButton(
                onPressed: () {},
                icon: const Icon(CupertinoIcons.chat_bubble_fill),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
