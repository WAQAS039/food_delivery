import 'dart:convert';

import 'package:food_delivery/Models/cart_model.dart';
import 'package:food_delivery/utils/app_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CartRepo{
  final SharedPreferences sharedPreference;
  CartRepo({required this.sharedPreference});

  List<String> cart = [];
  List<String> cartHistory = [];
  void addToList(List<CartModel> cartList){
    sharedPreference.remove(AppConstants.cartList);
    sharedPreference.remove(AppConstants.cartHistoryList);
    var time = DateTime.now().toString();
    cart = [];
    cartList.forEach((element) {
      element.time = time;
      // convert the list into string using json encode
      return cart.add(jsonEncode(element));
    });
    print('encode $cart');
    sharedPreference.setStringList(AppConstants.cartList, cart);
    getCartList();
  }
  List<CartModel> getCartList(){
    List<String> cart = [];
    if(sharedPreference.containsKey(AppConstants.cartList)){
      cart = sharedPreference.getStringList(AppConstants.cartList)!;
      // print('get cart list $cart');
    }
    List<CartModel> cartList = [];
    cart.forEach((element) => cartList.add(CartModel.fromJson(jsonDecode(element))));
    return cartList;
  }

  void addToCartHistoryList(){
    if(sharedPreference.containsKey(AppConstants.cartList)){
      cartHistory = sharedPreference.getStringList(AppConstants.cartHistoryList)!;
    }
    for(int i = 0;i<cart.length;i++){
      // print(cart[i]);
      cartHistory.add(cart[i]);
      print('new item $cartHistory');
    }
    removeCart();
    sharedPreference.setStringList(AppConstants.cartHistoryList, cartHistory);
    print('length ${getCartList().length}');
  }

  List<CartModel> getCartHistoryList(){
    if(sharedPreference.containsKey(AppConstants.cartHistoryList)){
      cartHistory = [];
      cartHistory = sharedPreference.getStringList(AppConstants.cartHistoryList)!;
    }
    List<CartModel> cartHistoryList = [];
    cartHistory.forEach((element) {
      cartHistoryList.add(CartModel.fromJson(jsonDecode(element)));
    });
    return cartHistoryList;
  }
  void removeCart(){
    cart = [];
    sharedPreference.remove(AppConstants.cartList);
  }
}