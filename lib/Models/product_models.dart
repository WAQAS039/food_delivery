import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class Product{
  int? _totalSize;
  int? _typeId;
  int? _offset;
  late List<ProductModel> _products;
  //get means the getter functions
  List<ProductModel> get products=> _products;

  Product({required totalSize, required typeId, required offset, required products}){
   _totalSize = totalSize;
   _typeId = typeId;
   _offset = offset;
   _products = products;
  }

  Product.fromJson(Map<String,dynamic> json){
    _totalSize = json['total_size'];
    _typeId = json['type_id'];
    _offset = json['offset'];
    if(json['products'] != null){
      _products = <ProductModel>[];
      for (var element in (json['products'] as List)) {
        _products.add(ProductModel.fromJson(element));
      }
    }
  }

  static Future<List<ProductModel>> getProduct(BuildContext context) async {
    Future.delayed(const Duration(seconds: 3));
    var productList = <ProductModel>[];
    var assetsBundle = DefaultAssetBundle.of(context);
    var data = await assetsBundle.loadString('assets/data/productsdata.json');
    var jsonData = json.decode(data);
    var productData = jsonData['products'];
    for(var map in productData){
      ProductModel model = ProductModel.fromJson(map);
      productList.add(model);
    }
    return productList;
  }
}

class ProductModel {
  String? id;
  String? name;
  String? description;
  int? price;
  int? stars;
  String? img;
  String? location;
  String? createdAt;
  String? updatedAt;

  int? typeId;
  ProductModel(
      {this.id,
        this.name,
        this.description,
        this.price,
        this.stars,
        this.img,
        this.location,
        this.createdAt,
        this.updatedAt,
        this.typeId});

  ProductModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    price = json['price'];
    stars = json['stars'];
    img = json['img'];
    location = json['location'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    typeId = json['type_id'];
  }

  Map<String,dynamic> toJson(){
    return {
      'id':id,
      'name':name,
      'description':description,
      'price':price,
      'stars':stars,
      'img':img,
      'location':location,
      'created_at':createdAt,
      'updated_at':updatedAt,
      'type_id':typeId
    };
  }
}