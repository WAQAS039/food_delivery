import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery/Models/cart_model.dart';
import 'package:food_delivery/controllers/cart_controller.dart';
import 'package:food_delivery/routes/routes_helper.dart';
import 'package:food_delivery/utils/app_colors.dart';
import 'package:food_delivery/utils/dimensions.dart';
import 'package:food_delivery/widgets/app_icon.dart';
import 'package:food_delivery/widgets/big_text.dart';
import 'package:food_delivery/widgets/small_text.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';


class CartHistory extends StatelessWidget {
  const CartHistory({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var cartHistoryList = Get.find<CartController>()
        .getCartHistoryList().reversed.toList();
    print('Cart History $cartHistoryList');
    Map<String,int> cartItemsPerOrders = Map();
    for(int i=0;i<cartHistoryList.length;i++){
      if(cartItemsPerOrders.containsKey(cartHistoryList[i].time)){
        cartItemsPerOrders.update(cartHistoryList[i].time!,(value)=>++value);
      }else{
        cartItemsPerOrders.putIfAbsent(cartHistoryList[i].time!,()=>1);
      }
    }

    List<int> cartOrderTimeToList(){
      return cartItemsPerOrders.entries.map((e)=>e.value).toList();
    }
    List<int> itemPerOrder = cartOrderTimeToList();
    print(itemPerOrder);
    var saveCounter = 0;
    return Scaffold(
      body: Column(
        children: [
          Container(
            height: 100,
            width: double.maxFinite,
            color: AppColors.mainColor,
            padding: EdgeInsets.only(top: Dimensions.height45),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                const BigText(text: "Your Cart History",color: Colors.white,),
                GestureDetector(
                    onTap: (){
                      var cartTime = cartOrderTimeToList();
                      Map<int, CartModel> moreOrder = {};
                    },
                    child: const AppIcon(iconData: CupertinoIcons.shopping_cart,))
              ],
            ),
          ),
          Expanded(
            child: Container(
              margin: EdgeInsets.only(top: Dimensions.height20,left: Dimensions.height20,right: Dimensions.height20),
              child: MediaQuery.removePadding(
                context: context,
                child: ListView(
                  children: [
                    for(int i = 0;i<itemPerOrder.length;i++)
                      Container(
                        height: 120,
                        margin: EdgeInsets.only(bottom: Dimensions.height20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ((){
                              DateTime format =DateFormat('yyyy-dd-mm HH:MM:SS').parse(cartHistoryList[saveCounter].time!);
                              var input = DateTime.parse(format.toString());
                              var outputFormat = DateFormat('MM/dd/yyyy hh:mm a');
                              var outputData = outputFormat.format(input);
                              return BigText(text: outputData);
                            }()),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Wrap(
                                  children: List.generate(itemPerOrder[i], (index){
                                    if(saveCounter<cartHistoryList.length){
                                      saveCounter++;
                                    }
                                    return index<=2?Container(
                                      height: 80,
                                      width: 75,
                                      margin: EdgeInsets.only(left: Dimensions.height10,top: Dimensions.height10),
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(Dimensions.height20),
                                          image: DecorationImage(
                                              image: AssetImage(cartHistoryList[saveCounter-1].img!),
                                              fit: BoxFit.cover
                                          )
                                      ),):Container();
                                  }),
                                ),
                                Container(
                                  height: 88,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      SmallText(text: 'Total',color: AppColors.titleColor),
                                      BigText(text: itemPerOrder[i].toString() + " items",color: AppColors.titleColor,size: Dimensions.height15,),
                                      InkWell(
                                        onTap: (){
                                          Get.toNamed(RoutesHelper.cartPage);
                                        },
                                        child: Container(
                                          padding: EdgeInsets.symmetric(horizontal: 5,vertical: 5),
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(Dimensions.height10/2),
                                            border: Border.all(color: AppColors.mainColor)
                                          ),
                                          child: SmallText(text: "One More",),
                                        ),
                                      )
                                    ],
                                  ),
                                )
                              ],
                            )
                          ],
                        ),
                      )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
