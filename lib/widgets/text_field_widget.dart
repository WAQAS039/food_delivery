import 'package:flutter/material.dart';
import 'package:food_delivery/utils/dimensions.dart';

class TextFieldWidget extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  const TextFieldWidget({Key? key,required this.controller,required this.hintText}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: Dimensions.height10,right: Dimensions.height10,top: Dimensions.height20),

      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(Dimensions.height30),
        boxShadow: [
          BoxShadow(
              offset: const Offset(0,4),
              blurRadius: 1,
              spreadRadius: 1,
              color: Colors.grey.withOpacity(0.1))
        ]
      ),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          hintText: hintText,
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.white,
              width: 0.0
            )
          ),
          enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(
                  color: Colors.white,
                  width: 0.0
              )
          )
        ),
      ),
    );
  }
}
