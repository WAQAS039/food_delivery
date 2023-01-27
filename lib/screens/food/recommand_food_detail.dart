import 'package:flutter/material.dart';
import 'package:food_delivery/Models/product_models.dart';
import 'package:food_delivery/data/reposities/cart_repo.dart';
import 'package:food_delivery/data/reposities/popular_product_repo.dart';
import 'package:food_delivery/routes/routes_helper.dart';
import 'package:food_delivery/utils/app_colors.dart';
import 'package:food_delivery/utils/dimensions.dart';
import 'package:food_delivery/widgets/app_icon.dart';
import 'package:food_delivery/widgets/big_text.dart';
import 'package:food_delivery/widgets/expandable_text.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../controllers/cart_controller.dart';
import '../../controllers/popluar_product_controller.dart';

class RecommendFoodDetail extends StatelessWidget {
  const RecommendFoodDetail({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ProductModel model = Get.arguments;
    Get.find<PopularProductController>().initData(model,Get.find<CartController>());
    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            automaticallyImplyLeading: false,
            toolbarHeight: 70,
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                    onTap: (){
                      Get.back();
                    },
                    child: AppIcon(iconData: Icons.clear)),
                GetBuilder<PopularProductController>(builder: (controller){
                  return InkWell(
                    onTap: (){
                      if(controller.totalItem >= 1 ){
                        Get.toNamed(RoutesHelper.cartPage);
                      }
                    },
                    child: Stack(
                      children: [
                        AppIcon(iconData: Icons.shopping_cart),
                        controller.totalItem>=1 ?
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
                    ),
                  );
                })
              ],
            ),
            bottom: PreferredSize(
              preferredSize: Size.fromHeight(20),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(Dimensions.radius20),topRight: Radius.circular(Dimensions.radius20))
                ),
                width: double.maxFinite,
                padding: EdgeInsets.only(top: 5,bottom: 10),
                child: Center(child: BigText(text: model.name as String,size: Dimensions.font26,)),
              ),
            ),
            pinned: true,
            backgroundColor: Colors.amber,
            expandedHeight: 300,
            flexibleSpace: FlexibleSpaceBar(
              background: Image.asset(model.img as String,
                width: double.maxFinite,
                fit: BoxFit.cover,),
            ),
          ),
          SliverToBoxAdapter(
            child:  Container(
                margin: EdgeInsets.only(left: Dimensions.width20,right: Dimensions.width20),
                child: ExpandableTextWidget(text: model.description as String),))
        ],
      ),
      bottomNavigationBar: GetBuilder<PopularProductController>(builder: (controller){
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: EdgeInsets.only(left: Dimensions.width20 * 2.5, right: Dimensions.width20 * 2.5 , top: Dimensions.height10 , bottom: Dimensions.height10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                      onTap:(){
                        controller.setQuantity(false);
                      },
                      child: AppIcon(iconData: Icons.remove ,backgroundColor: AppColors.mainColor,iconColor: Colors.white, iconSize: Dimensions.iconSize24,)),
                  BigText(text: ('\$ ${model.price}  X  ${controller.cartItems}') , color: AppColors.mainBackColor, size: Dimensions.font26,),
                  InkWell(
                      onTap: (){
                        controller.setQuantity(true);
                      },
                      child: AppIcon(iconData: Icons.add,backgroundColor: AppColors.mainColor,iconColor: Colors.white, iconSize: Dimensions.iconSize24))
                ],
              ),
            ),
            Container(
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
                        borderRadius: BorderRadius.circular(Dimensions.radius30),
                        color: Colors.white
                    ),
                    child: Icon(Icons.favorite,color: AppColors.mainColor,),
                  ),
                  InkWell(
                    onTap: (){
                      controller.addItem(model);
                    },
                    child: Container(
                      padding: EdgeInsets.all(Dimensions.height20),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(Dimensions.radius20),
                          color: AppColors.mainColor
                      ),
                      child: BigText(text: '\$ ${model.price} | Added to Cart ', color: Colors.white,),
                    ),
                  )
                ],
              ),
            )
          ],
        );
      },),
    );
  }
}
