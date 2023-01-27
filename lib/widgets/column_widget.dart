import 'package:flutter/material.dart';
import 'package:food_delivery/widgets/small_text.dart';

import '../utils/app_colors.dart';
import '../utils/dimensions.dart';
import 'big_text.dart';
import 'icon_and_text.dart';

class AppColumn extends StatelessWidget {
  final String text;
  const AppColumn({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        BigText(text: text,size: Dimensions.font26,),
        SizedBox(height: Dimensions.height10,),
        Row(
          children: [
            Wrap(children: List.generate(5, (index) => Icon(Icons.star, color: AppColors.mainColor,size: Dimensions.iconSize20,)),),
            SizedBox(width: Dimensions.width10,),
            SmallText(text: '4.5'),
            SizedBox(width: Dimensions.width10,),
            SmallText(text: '1234 '),
            const SizedBox(width: 5,),
            SmallText(text: 'comments '),
          ],
        ),
        SizedBox(height: Dimensions.height10,),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: const[
            IconAndText(
                iconData: Icons.circle_sharp,
                text: 'Normal',
                iconColor: AppColors.iconColor1),
            IconAndText(
                iconData: Icons.location_on,
                text: '1.7Km',
                iconColor: AppColors.mainColor),
            IconAndText(
                iconData: Icons.watch_later_outlined,
                text: '32min',
                iconColor: AppColors.iconColor2),
          ],
        )
      ],
    );
  }
}

