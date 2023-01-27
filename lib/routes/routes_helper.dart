import 'package:food_delivery/Models/product_models.dart';
import 'package:food_delivery/screens/address/add_address.dart';
import 'package:food_delivery/screens/cart/cart_page.dart';
import 'package:food_delivery/screens/food/popular_food_details.dart';
import 'package:food_delivery/screens/food/recommand_food_detail.dart';
import 'package:food_delivery/screens/home/home_page.dart';
import 'package:food_delivery/screens/home/main_food_page.dart';
import 'package:food_delivery/screens/splash/splash_screen.dart';
import 'package:get/get.dart';

class RoutesHelper{
  static const String initRoute = "/";
  static const String popularFood = '/popularFood';
  static const String recommendedFood = '/recommendedFood';
  static const String cartPage = '/cartPage';
  static const String splashPage = '/splashPage';
  static const String addAddressPage = '/addAddressPage';
  static String getPopularFood(int index)=>'$popularFood';
  static String getInit()=>'$initRoute';
  static String getRecommendFood()=>'$recommendedFood';
  static List<GetPage> routes = [
    GetPage(name: '/', page: ()=> const HomePage() , transition: Transition.fadeIn),
    GetPage(name: popularFood, page: (){
      return PopularFoodDetails();
    }),
    GetPage(name: recommendedFood, page: ()=> const RecommendFoodDetail()),
    GetPage(name: cartPage, page: ()=>CartPage()),
    GetPage(name: splashPage, page: ()=>SplashScreen()),
    GetPage(name: addAddressPage, page: ()=> AddAddress())
  ];
}