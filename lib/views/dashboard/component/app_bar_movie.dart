import 'package:flutter/material.dart';

import '../../../utils/color_utils.dart';

class AppBarMovie extends StatelessWidget {
  const AppBarMovie({super.key, required this.ontap});

  final VoidCallback ontap;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return SizedBox(
      width: width,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text(
                'Welcome Back,',
                style: TextStyle(
                  fontSize: 14,
                  fontFamily: "Roboto",
                  fontWeight: FontWeight.normal,
                  color: ColorUtils.textColor,
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Text(
                'Reza Kurnia',
                style: TextStyle(
                    fontSize: 22,
                    fontFamily: "Roboto",
                    fontWeight: FontWeight.bold,
                    color: ColorUtils.textColor,
                    letterSpacing: 0.5),
              ),
            ],
          ),
          GestureDetector(
            onTap: ontap,
            child: const SizedBox(
              height: 30,
              width: 30,
              child: Icon(
                Icons.search_sharp,
                size: 30,
                color: Colors.white,
              ),
            ),
          )
        ],
      ),
    );
  }
}
