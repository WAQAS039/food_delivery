
import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery/Models/cart_model.dart';
import 'package:food_delivery/Models/product_models.dart';
import 'package:food_delivery/controllers/cart_controller.dart';
import 'package:food_delivery/data/reposities/popular_product_repo.dart';
import 'package:food_delivery/utils/app_colors.dart';
import 'package:get/get.dart';

class PopularProductController extends GetxController{
  final PopularProductRepo repo;
  PopularProductController({required this.repo});
  late CartController _cartController;
  // List<dynamic> _popularProductList = [];
  // List<dynamic> get popularProductList => _popularProductList;
  //
  // bool _loaded = false;
  // bool get isLoaded=> _loaded;
  // Future<void> getPopularProductList() async {
  //   Response response = await repo.getRecommededProductList();
  //   if(response.statusCode == 200){
  //     _popularProductList = [];
  //     _popularProductList.addAll(Product.fromJson(response.body).products);
  //     _loaded = true;
  //     update();
  //   }else{
  //
  //   }
  // }

  int _quantity = 0;
  int get quantity => _quantity;
  int _cartItems = 0;
  int get cartItems => _cartItems + _quantity;

  void setQuantity(bool isIncreament){
    if(isIncreament){
      _quantity = checkQuantity(_quantity + 1);
    }else{
      _quantity = checkQuantity(_quantity - 1);
    }
    update();
  }

  int checkQuantity(int quantity){
    if((_cartItems + quantity) < 0){
      Get.snackbar(
          'item Count', 'You can not decrease more! ',
          backgroundColor: AppColors.mainColor, colorText: Colors.white);
      if(_cartItems > 0){
        _quantity = -_cartItems;
        return _quantity;
      }
      return 0;
    }else if((_cartItems + quantity)>20){
      Get.snackbar(
          'item Count', 'You can not add more! ',
          backgroundColor: AppColors.mainColor, colorText: Colors.white);
      return 20;
    }else{
      return quantity;
    }
  }


  // initial data when app load
  void initData(ProductModel productModel,CartController cartController){
    _quantity = 0;
    _cartItems = 0;
    _cartController = cartController;
    //get from storage
    var exist = false;
    exist = _cartController.existInCart(productModel);
    if(exist){
      _cartItems = _cartController.getQuantity(productModel);
    }
  }


  // add new item to map
  void addItem(ProductModel productModel){
    _cartController.addItem(productModel, _quantity);
    _quantity = 0;
    _cartItems = _cartController.getQuantity(productModel);
    update();
  }


  // total quantity for cart icon
  int get totalItem{
    return _cartController.totalItems;
  }


  // cart list for loading data
  List<CartModel>? get getCartItems{
    return _cartController.getCartItem;
  }
}