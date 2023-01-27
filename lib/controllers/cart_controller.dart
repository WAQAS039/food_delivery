import 'package:flutter/material.dart';
import 'package:food_delivery/Models/product_models.dart';
import 'package:food_delivery/data/reposities/cart_repo.dart';
import 'package:get/get.dart';

import '../Models/cart_model.dart';
import '../utils/app_colors.dart';

class CartController extends GetxController{
  final CartRepo cartRepo;
  CartController({required this.cartRepo});

  Map<int,CartModel>? _items = {};
  Map<int,CartModel>? get items => _items;
  // from shared preference
  List<CartModel> storageItem = [];
  void addItem(ProductModel productModel, int quantity){
    int singleItemTotalQuantity = 0;
    if(_items!.containsKey(int.parse(productModel.id!))){
      _items!.update(int.parse(productModel.id!), (value) {
        singleItemTotalQuantity = value.quantity! + quantity;
        return CartModel(
            id: value.id,
            name: value.name,
            price: value.price,
            img: value.img,
            quantity: value.quantity! + quantity,
            isExist: true,
            time: DateTime.now().toString(),
            productModel: productModel
        );
      });
      if(singleItemTotalQuantity <= 0){
        _items!.remove(int.parse(productModel.id!));
      }
    }else{
      if(quantity > 0){
        _items!.putIfAbsent(int.parse(productModel.id!), () {
          return CartModel(
              id: int.parse(productModel.id!),
              name: productModel.name,
              price: productModel.price,
              img: productModel.img,
              quantity: quantity,
              isExist: true,
              time: DateTime.now().toString(),
              productModel: productModel
          );
        }
        );
      }else{
        Get.snackbar(
            'item Count', 'You should add at least one item ',
            backgroundColor: AppColors.mainColor, colorText: Colors.white);
      }
    }
    cartRepo.addToList(getCartItem!);
    update();
  }

  bool existInCart(ProductModel productModel){
    if(productModel.id != null){
      if(_items!.containsKey(int.parse(productModel.id!))){
        return true;
      }
    }
    return false;
  }


  // get quantity of a single item
  int getQuantity(ProductModel productModel){
    var quantity = 0;
    if(_items!.containsKey(int.parse(productModel.id!))){
      _items!.forEach((key, value) {
        if(key == int.parse(productModel.id!)){
          quantity = value.quantity!;
        }
      });
    }
    return quantity;
  }


  // get all quantiy for the cart
  int get totalItems{
    int totalQuantity = 0;
    _items!.forEach((key, value) {
      totalQuantity += value.quantity!;
    });
    return totalQuantity;
  }


  // get items list from the map
  List<CartModel>? get getCartItem{
    return items!.entries.map((e) => e.value).toList();
  }


  // total prize
  int get getTotalAmount{
    var totalPrice = 0;
    _items!.forEach((key, value) {
      totalPrice += value.quantity! * value.price!;
    });
    return totalPrice;
  }


  // storage work with shared preference
  List<CartModel> getCartData(){
    setCart = cartRepo.getCartList();
    return storageItem;
  }

  set setCart(List<CartModel> items){
    storageItem = items;

    // if the user kill the app than after restart the already added will be added to map again
    for(int i = 0;i<storageItem.length;i++){
      _items!.putIfAbsent(int.parse(storageItem[i].productModel!.id!), () => storageItem[i]);
    }
  }

  void addToHistory(){
    cartRepo.addToCartHistoryList();
    clear();
  }
  void clear(){
    _items = {};
    update();
  }

  List<CartModel> getCartHistoryList(){
    return cartRepo.getCartHistoryList();
  }
}