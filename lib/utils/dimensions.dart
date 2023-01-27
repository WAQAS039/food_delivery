import 'package:get/get.dart';

class Dimensions{
  static double screenHeight = Get.context!.height;
  static double screenWeight = Get.context!.width;


  static double pageView = screenHeight / 2.64;
  static double pageViewContainer = screenHeight / 3.84;
  static double pageViewTextContainer = screenHeight/7.03;

  // dynamic height for padding and margin
  static double height10 = screenHeight/84.4;
  static double height15 = screenHeight/56.27;
  static double height20 = screenHeight/42.2;
  static double height30 = screenHeight/28.13;
  static double height45 = screenHeight/18.76;

  // dynamic height for padding and margin
  static double width10 = screenHeight/84.3;
  static double width15 = screenHeight/56.27;
  static double width20 = screenHeight/42.2;
  static double width30 = screenHeight/28.13;
  static double width45 = screenHeight/18.76;

  static double font20 = screenHeight / 42.2;
  static double font16 = screenHeight / 52.75;
  static double font26 = screenHeight / 32.46;
  static double radius20 = screenHeight / 42.2;
  static double radius30 = screenHeight / 52.75;

  //Icon Size
  static double iconSize24 = screenHeight/34.5;
  static double iconSize20 = screenHeight/42.2;
  static double iconSize16 = screenHeight/42.2;

  // list view size
  static double listviewImageSize = screenWeight/3.25;
  static double listviewTextContainer = screenWeight/3.9;

  // popular food detail
  static double popularFoodContainer = screenHeight/2.41;
}