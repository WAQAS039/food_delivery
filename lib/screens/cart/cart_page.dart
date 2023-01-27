import 'package:flutter/material.dart';
import 'package:food_delivery/controllers/cart_controller.dart';
import 'package:food_delivery/controllers/popluar_product_controller.dart';
import 'package:food_delivery/routes/routes_helper.dart';
import 'package:food_delivery/utils/app_colors.dart';
import 'package:food_delivery/utils/dimensions.dart';
import 'package:food_delivery/widgets/app_icon.dart';
import 'package:food_delivery/widgets/big_text.dart';
import 'package:food_delivery/widgets/small_text.dart';
import 'package:get/get.dart';

import '../../Models/cart_model.dart';
class CartPage extends StatelessWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
              left: Dimensions.width20,
              right: Dimensions.width20,
              top: Dimensions.height20*3,
              child: GetBuilder<CartController>(builder: (cartController){
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      onTap:(){
                        Get.back(result: 'refresh');                      },
                      child: AppIcon(
                        iconData: Icons.arrow_back_ios,
                        iconSize: Dimensions.iconSize24,
                        backgroundColor: AppColors.mainColor,
                      ),
                    ),
                    SizedBox(width: Dimensions.width20*5,),
                    InkWell(
                      onTap: (){
                        Get.toNamed(RoutesHelper.initRoute);
                      },
                      child: AppIcon(
                        iconData: Icons.home_outlined,
                        iconSize: Dimensions.iconSize24,
                        backgroundColor: AppColors.mainColor,
                      ),
                    ),
                    AppIcon(
                      iconData: Icons.shopping_cart,
                      iconSize: Dimensions.iconSize24,
                      backgroundColor: AppColors.mainColor,
                    ),
                  ],
                );
              })
          ),
          Positioned(
              top: Dimensions.height20*5,
              left: Dimensions.width20,
              right: Dimensions.width20,
              bottom: 0,
              child: Container(
                child: MediaQuery.removePadding(
                  context: context,
                  removeTop: true,
                  child: GetBuilder<CartController>(builder: (controller){
                    var cartList = controller.getCartItem!;
                    return ListView.builder(
                        itemCount: cartList.length,
                        itemBuilder: (context,index){
                          CartModel cartModel = cartList[index];
                          return Container(
                            margin: EdgeInsets.all(Dimensions.height10),
                            height: 100,
                            width: double.maxFinite,
                            child: Row(
                              children: [
                                InkWell(
                                  onTap:(){
                                    // var popularIndex = Get.find<PopularProductController>().list.indexOf();
                                    Get.toNamed(RoutesHelper.popularFood,arguments: [cartModel.productModel!,'cartPage']);
                                  },
                                  child: Container(
                                    height: Dimensions.height20*5,
                                    width: Dimensions.width20*5,
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(10),
                                        image: DecorationImage(
                                            image: AssetImage(
                                              controller.getCartItem![index].img!,
                                            ),
                                            fit: BoxFit.cover
                                        )
                                    ),
                                  ),
                                ),
                                SizedBox(width: Dimensions.width10,),
                                Expanded(
                                  child: Container(
                                    height: Dimensions.height20*5,
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        BigText(text: cartModel.name!),
                                        SmallText(text: cartModel.name!),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            BigText(text: '\$ ${cartModel.price!}'),
                                            Container(
                                              padding: EdgeInsets.all(Dimensions.height10),
                                              decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.circular(Dimensions.radius20),
                                                  color: Colors.white
                                              ),
                                              child: Row(
                                                children: [
                                                  InkWell(
                                                      onTap: (){
                                                        controller.addItem(cartModel.productModel!, -1);
                                                      },
                                                      child: Icon(Icons.remove, color: AppColors.signColor,)),
                                                  SizedBox(width: Dimensions.width10/2,),
                                                  BigText(text: cartModel.quantity!.toString()),
                                                  SizedBox(width: Dimensions.width10/2,),
                                                  InkWell(
                                                      onTap: (){
                                                        controller.addItem(cartModel.productModel!, 1);
                                                      },
                                                      child: Icon(Icons.add, color: AppColors.signColor,))
                                                ],
                                              ),
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                )
                              ],
                            ),
                          );
                        });
                  },),
                ),
              )),
        ],
      ),
      bottomNavigationBar: GetBuilder<CartController>(builder: (controller){
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
                    BigText(text: controller.getTotalAmount.toString()),
                  ],
                ),
              ),
              InkWell(
                onTap: (){
                  controller.addToHistory();
                },
                child: Container(
                  padding: EdgeInsets.all(Dimensions.height20),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(Dimensions.radius20),
                      color: AppColors.mainColor
                  ),
                  child: BigText(text: ' CheckOut'
                    , color: Colors.white,size: Dimensions.font16,),
                ),
              )
            ],
          ),
        );
      },),
    );
  }
}
