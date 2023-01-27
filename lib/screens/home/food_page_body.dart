import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery/Models/product_models.dart';
import 'package:food_delivery/routes/routes_helper.dart';
import 'package:food_delivery/utils/app_colors.dart';
import 'package:food_delivery/utils/dimensions.dart';
import 'package:food_delivery/widgets/big_text.dart';
import 'package:food_delivery/widgets/column_widget.dart';
import 'package:food_delivery/widgets/icon_and_text.dart';
import 'package:food_delivery/widgets/small_text.dart';
import 'package:get/get.dart';

class FoodPageBody extends StatefulWidget {
  const FoodPageBody({Key? key}) : super(key: key);

  @override
  State<FoodPageBody> createState() => _FoodPageBodyState();
}

class _FoodPageBodyState extends State<FoodPageBody> {
  var pageController = PageController(viewportFraction: 0.85);
  var currentPageValue = 0.0;
  var scaleFactor = 0.8;
  var height = Dimensions.pageViewContainer;

  @override
  void initState() {
    super.initState();
    pageController.addListener(() {
     setState(() {
       currentPageValue =  pageController.page!;
     });
    });
  }

  @override
  void dispose() {
    super.dispose();
    pageController.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Product.getProduct(context),
      builder: (context,snap){
        if(snap.hasData) {
          return Column(
            children: [
              // Slider Section
              Container(
                  height: Dimensions.pageView,
                  child: PageView.builder(
                    controller: pageController,
                    itemCount: snap.data!.length ?? 1,
                    itemBuilder: (context, index) {
                      return _buildPageItem(index, snap.data![index]);
                    },),
              ),
              // Dots
              DotsIndicator(
                dotsCount: snap.data!.length ?? 1,
                position: currentPageValue,
                decorator: DotsDecorator(
                  activeColor: AppColors.mainColor,
                  size: const Size.square(9.0),
                  activeSize: const Size(18.0, 9.0),
                  activeShape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5.0)),
                ),),
              // Popular Text
              SizedBox(height: Dimensions.height30,),
              Container(
                margin: EdgeInsets.only(left: Dimensions.width30),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    BigText(text: "Recommended"),
                    SizedBox(width: Dimensions.width10,),
                    Container(
                      margin: EdgeInsets.only(bottom: 3),
                      child: BigText(text: '.', color: Colors.black26,),
                    ),
                    SizedBox(width: Dimensions.width10,),
                    Container(
                      margin: EdgeInsets.only(bottom: 2),
                      child: SmallText(
                        text: 'Food pairing', color: Colors.black26,),
                    ),
                  ],
                ),
              ),
              // list of food and images
              ListView.builder(
                  itemCount: snap.data!.length,
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: (){
                        Get.toNamed(RoutesHelper.getRecommendFood(), arguments: snap.data![index]);
                      },
                      child: Container(
                        margin: EdgeInsets.only(left: Dimensions.width20,
                            right: Dimensions.width20,
                            bottom: Dimensions.height10),
                        child: Row(
                          children: [
                            Container(
                              height: Dimensions.listviewImageSize,
                              width: Dimensions.listviewImageSize,
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: AssetImage(
                                          snap.data![index].img as String),
                                      fit: BoxFit.cover
                                  ),
                                  borderRadius: BorderRadius.circular(
                                      Dimensions.radius20)
                              ),
                            ),
                            Expanded(
                              child: Container(
                                height: Dimensions.listviewTextContainer,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                      topRight: Radius.circular(
                                          Dimensions.radius20),
                                      bottomRight: Radius.circular(
                                          Dimensions.radius20)),
                                  color: Colors.white,
                                ),
                                child: Padding(
                                  padding: EdgeInsets.only(
                                      left: Dimensions.width10,
                                      right: Dimensions.width10),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment
                                        .start,
                                    mainAxisAlignment: MainAxisAlignment
                                        .center,
                                    children: [
                                      BigText(
                                          text: snap.data![index].name as String),
                                      SizedBox(
                                        height: Dimensions.height10,),
                                      SmallText(
                                          text: 'with chinese characterists'),
                                      SizedBox(
                                        height: Dimensions.height10,),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment
                                            .spaceBetween,
                                        children: const[
                                          IconAndText(
                                              iconData: Icons.circle_sharp,
                                              text: 'Normal',
                                              iconColor: AppColors
                                                  .iconColor1),
                                          IconAndText(
                                              iconData: Icons.location_on,
                                              text: '1.7Km',
                                              iconColor: AppColors
                                                  .mainColor),
                                          IconAndText(
                                              iconData: Icons
                                                  .watch_later_outlined,
                                              text: '32min',
                                              iconColor: AppColors
                                                  .iconColor2),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }),
            ],
          );
        }else{
          return Center(child: CircularProgressIndicator(),);
        }
      },
    );
  }
  Widget _buildPageItem(int position , ProductModel model){
    Matrix4 matrix4 = Matrix4.identity();
    if(position == currentPageValue.floor()){
      var currScale = 1-(currentPageValue - position) * (1 - scaleFactor);
      var currTrans = height * (1-currScale)/2;
      matrix4 = Matrix4.diagonal3Values(1, currScale, 1)..setTranslationRaw(0, currTrans, 0);
    }else if(position == currentPageValue.floor() + 1){
      var currScale = scaleFactor+(currentPageValue - position + 1) * (1 - scaleFactor);
      var currTrans = height * (1-currScale)/2;
      matrix4 = Matrix4.diagonal3Values(1, currScale, 1);
      matrix4 = Matrix4.diagonal3Values(1, currScale, 1)..setTranslationRaw(0, currTrans, 0);
    }else if(position == currentPageValue.floor() - 1){
      var currScale = 1-(currentPageValue - position) * (1 - scaleFactor);
      var currTrans = height * (1-currScale)/2;
      matrix4 = Matrix4.diagonal3Values(1, currScale, 1);
      matrix4 = Matrix4.diagonal3Values(1, currScale, 1)..setTranslationRaw(0, currTrans, 0);
    }else{
      var currScale = 0.8;
      matrix4 = Matrix4.diagonal3Values(1, currScale, 1)..setTranslationRaw(0, height * (1-currScale)/2, 1);
    }
    return Transform(
      transform: matrix4,
      child: Stack(
        children: [
          InkWell(
            onTap: (){
              Get.toNamed(RoutesHelper.getPopularFood(position), arguments: [model,'cartPage']);
              // Get.to(PopularFoodDetails(productModel: model));
            },
            child: Container(
              height: Dimensions.pageViewContainer,
              margin: EdgeInsets.only(left: Dimensions.width10,right: Dimensions.width10),
              decoration: BoxDecoration(
                  color: position.isEven ? Colors.amber : Colors.grey,
                  borderRadius: BorderRadius.circular(Dimensions.radius30),
                  image: DecorationImage(
                      image: AssetImage(model.img as String),
                      fit: BoxFit.cover
                  )
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: Dimensions.pageViewTextContainer,
              margin: EdgeInsets.only(left: Dimensions.width30,right: Dimensions.width30,bottom: Dimensions.height30),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(Dimensions.radius30),
                boxShadow: const[
                  BoxShadow(
                    color: Color(0xFFe8e8e8), offset: Offset(0, 5)
                  ),
                  BoxShadow(
                      color: Colors.white, offset: Offset(-5, 0)
                  ),
                  BoxShadow(
                      color: Colors.white, offset: Offset(5, 0)
                  ),
                ],
              ),
              child: Container(
                padding: EdgeInsets.only(top: Dimensions.height15,left: Dimensions.width15,right: Dimensions.width15),
                child: AppColumn(text: model.name as String,),
              ),
            ),
          )
        ],
      ),
    );
  }
}
