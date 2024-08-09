import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/svg.dart';

class CircleWidget extends StatelessWidget {
  final String text;
  final String svgImage;
  const CircleWidget({
    super.key,
    required this.text,
    required this.svgImage,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(5),
      height: 25,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(),
      ),
      child: Row(
        children: [
          SvgPicture.asset(svgImage),
          const SizedBox(width: 5),
          Text(
            text,
            style: const TextStyle(
              fontSize: 10,
            ),
          ),
        ],
      ),
    );
  }
}
