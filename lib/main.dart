import 'package:flutter/material.dart';
import 'package:food_delivery/Models/product_models.dart';
import 'package:food_delivery/controllers/cart_controller.dart';
import 'package:food_delivery/routes/routes_helper.dart';
import 'package:food_delivery/screens/home/food_page_body.dart';
import 'package:food_delivery/screens/splash/splash_screen.dart';
import 'controllers/popluar_product_controller.dart';
import 'data/reposities/popular_product_repo.dart';
import 'helper/dependencies.dart' as dep;
import 'package:food_delivery/screens/food/popular_food_details.dart';
import 'package:food_delivery/screens/food/recommand_food_detail.dart';
import 'package:food_delivery/screens/home/main_food_page.dart';
import 'package:get/get.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await dep.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    Get.find<CartController>().getCartData();
    return GetBuilder<PopularProductController>(builder: (_){
      return GetBuilder<CartController>(builder: (_){
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          initialRoute: RoutesHelper.splashPage,
          getPages: RoutesHelper.routes,
        );
      });
    });
  }
}