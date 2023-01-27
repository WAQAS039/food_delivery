import 'package:flutter/material.dart';
import 'package:food_delivery/routes/routes_helper.dart';
import 'package:food_delivery/utils/dimensions.dart';
import 'package:food_delivery/widgets/text_field_widget.dart';
import 'package:get/get.dart';

class AccountInformation extends StatefulWidget {
  const AccountInformation({Key? key}) : super(key: key);

  @override
  State<AccountInformation> createState() => _AccountInformationState();
}

class _AccountInformationState extends State<AccountInformation> {
  var email = TextEditingController();
  var password = TextEditingController();
  var phone = TextEditingController();
  var address = TextEditingController();
  var formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Container(
            margin: EdgeInsets.only(top: Dimensions.height45),
            child: Center(
              child: CircleAvatar(
                backgroundColor: Colors.white,
                backgroundImage: const AssetImage('assets/images/splash.png',),radius: Dimensions.height45+Dimensions.height20,),
            ),
          ),
          Form(
            key: formKey,
              child: Column(
                children: [
                  TextFieldWidget(controller: email, hintText: "Email"),
                  TextFieldWidget(controller: password, hintText: "Password"),
                  TextFieldWidget(controller: phone, hintText: "Phone"),
                  TextFieldWidget(controller: address, hintText: "Address")
                ],
              )),
          ElevatedButton(onPressed: (){
            Get.toNamed(RoutesHelper.addAddressPage);
          }, child: const Text('Address'))
        ],
      ),
    );
  }
}
