import 'dart:async';

import 'package:flutter/material.dart';
import 'package:food_delivery/Models/product_models.dart';
import 'package:food_delivery/controllers/cart_controller.dart';
import 'package:food_delivery/controllers/popluar_product_controller.dart';
import 'package:food_delivery/routes/routes_helper.dart';
import 'package:food_delivery/utils/dimensions.dart';
import 'package:food_delivery/widgets/big_text.dart';
import 'package:get/get.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with TickerProviderStateMixin{
  late Animation<double> animation;
  late AnimationController _animationController;
  
  @override
  void initState() {
    super.initState();
    _loadResource();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..forward();
    animation = CurvedAnimation(parent: _animationController, curve: Curves.linear);
    Timer(
      Duration(seconds: 3),
        ()=>Get.offNamed(RoutesHelper.initRoute)
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ScaleTransition(
              scale: animation,
              child: Center(child: Image.asset('assets/images/splash.png'))),
          SizedBox(height: Dimensions.height10,),
          Center(child: BigText(text: 'The Best Food',color: Colors.blue,size: Dimensions.height30,))
        ],
      ),
    );
  }

  _loadResource() async{
    Get.find<PopularProductController>().initData(ProductModel(),Get.find<CartController>());
  }
}
