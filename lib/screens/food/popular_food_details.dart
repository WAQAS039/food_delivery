import 'package:flutter/material.dart';
import 'package:food_delivery/Models/product_models.dart';
import 'package:food_delivery/controllers/cart_controller.dart';
import 'package:food_delivery/routes/routes_helper.dart';
import 'package:food_delivery/screens/cart/cart_page.dart';
import 'package:food_delivery/utils/dimensions.dart';
import 'package:food_delivery/widgets/app_icon.dart';
import 'package:food_delivery/widgets/column_widget.dart';
import 'package:food_delivery/widgets/expandable_text.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../controllers/popluar_product_controller.dart';
import '../../utils/app_colors.dart';
import '../../widgets/big_text.dart';
import '../../widgets/icon_and_text.dart';
import '../../widgets/small_text.dart';

class PopularFoodDetails extends StatefulWidget {
  const PopularFoodDetails({Key? key}) : super(key: key);

  @override
  State<PopularFoodDetails> createState() => _PopularFoodDetailsState();
}

class _PopularFoodDetailsState extends State<PopularFoodDetails> {
  static var argumentsData = Get.arguments;
  var product = argumentsData[0] as ProductModel;
  // var pageName = argumentsData[1];
  @override
  void initState() {
    super.initState();
    Get.find<PopularProductController>().initData(product,Get.find<CartController>());
  }
  @override
  Widget build(BuildContext context) {
    Product.getProduct(context);
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          // background image
          Positioned(
            left: 0,
            right: 0,
            child: Container(
              height: Dimensions.popularFoodContainer,
              width: double.maxFinite,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage(product.img as String),
                      fit: BoxFit.cover
                  )
              ),
            ),
          ),
          // icon widget
          Positioned(
              top: Dimensions.height45,
              left: Dimensions.width20,
              right: Dimensions.width20,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                      onTap: () {
                        Get.back();
                      },
                      child: AppIcon(iconData: Icons.arrow_back_ios)),
                  InkWell(
                    onTap: () async{
                      if(Get.find<PopularProductController>().totalItem >= 1 ){
                        String result = await Get.toNamed(RoutesHelper.cartPage);
                        if(result == 'refresh'){
                          print('cakked');
                          Get.find<PopularProductController>().initData(product,Get.find<CartController>());
                          setState(() {});
                        }
                      }
                    },
                    child: GetBuilder<PopularProductController>(builder: (controller){
                      return Stack(
                        children: [
                          AppIcon(iconData: Icons.shopping_cart),
                          Get.find<PopularProductController>().totalItem>=1 ?
                          Positioned(
                              right:0,
                              top:0,
                              child: AppIcon(iconData: Icons.circle, backgroundColor: AppColors.mainColor,size: 20,iconColor: Colors.transparent,)) : Container(),
                          Get.find<PopularProductController>().totalItem>=1 ?
                          Positioned(
                              right:5,
                              top:5,
                              child: BigText(text: controller.totalItem.toString(),color: Colors.white,size: 12,)) : Container()
                        ],
                      );
                    }),
                  )
                ],
              )
          ),
          // intro
          Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              top: Dimensions.popularFoodContainer - 20,
              child: Container(
                padding: EdgeInsets.only(left: Dimensions.width20,
                    right: Dimensions.width20,
                    top: Dimensions.height20),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(Dimensions.height20),
                        topLeft: Radius.circular(Dimensions.height20)),
                    color: Colors.white
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppColumn(text: product.name as String ,),
                    SizedBox(height: Dimensions.height20,),
                    BigText(text: product.description as String),
                    SizedBox(height: Dimensions.height20,),
                    Expanded(child: SingleChildScrollView(
                        child: ExpandableTextWidget(
                            text: product.description!))),

                  ],
                ),
              )
          ),
          // expandable text
        ],
      ),
      bottomNavigationBar: GetBuilder<PopularProductController>(builder: (pop){
        return Container(
          height: Dimensions.pageViewTextContainer,
          padding: EdgeInsets.only(top: Dimensions.height30,bottom: Dimensions.height30,left: Dimensions.width20,right: Dimensions.width20),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.only(topLeft: Radius.circular(Dimensions.radius20 * 2), topRight: Radius.circular(Dimensions.radius20 * 2)),
              color: AppColors.buttonBackgroundColor
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: EdgeInsets.all(Dimensions.height20),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(Dimensions.radius20),
                    color: Colors.white
                ),
                child: Row(
                  children: [
                    InkWell(
                        onTap: (){
                          pop.setQuantity(false);
                        },
                        child: Icon(Icons.remove, color: AppColors.signColor,)),
                    SizedBox(width: Dimensions.width10/2,),
                    BigText(text: pop.cartItems.toString()),
                    SizedBox(width: Dimensions.width10/2,),
                    InkWell(
                        onTap: (){
                          pop.setQuantity(true);
                        },
                        child: Icon(Icons.add, color: AppColors.signColor,))
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.all(Dimensions.height20),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(Dimensions.radius20),
                    color: AppColors.mainColor
                ),
                child: InkWell(
                    onTap: (){
                      pop.addItem(product);
                    },
                    child: BigText(text: '\$ ${product.price} | Added to Cart ', color: Colors.white,size: Dimensions.font16,)),
              )
            ],
          ),
        );
      },),
    );
  }
}
