import 'package:food_delivery/Models/product_models.dart';
import 'package:food_delivery/data/reposities/popular_product_repo.dart';
import 'package:get/get.dart';

class RecommendedProductController extends GetxController{
  final PopularProductRepo repo;
  RecommendedProductController({required this.repo});
  List<dynamic> _recommendedProductList = [];
  List<dynamic> get recommendedProductList => _recommendedProductList;

  bool _loaded = false;
  bool get isLoaded=> _loaded;
  Future<void> getRecommendedProductList() async {
    Response response = await repo.getRecommededProductList();
    if(response.statusCode == 200){
      _recommendedProductList = [];
      // popularProductList.addAll(Product.fromJson(response.body).products);
      _loaded = true;
      update();
    }else{

    }
  }
}