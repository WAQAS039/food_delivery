import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery/controllers/location_controller.dart';
import 'package:food_delivery/screens/address/pick_address_map.dart';
import 'package:food_delivery/utils/app_colors.dart';
import 'package:food_delivery/utils/dimensions.dart';
import 'package:food_delivery/widgets/big_text.dart';
import 'package:food_delivery/widgets/text_field_widget.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class AddAddress extends StatefulWidget {
  const AddAddress({Key? key}) : super(key: key);

  @override
  State<AddAddress> createState() => _AddAddressState();
}

class _AddAddressState extends State<AddAddress> {

  TextEditingController _addressController = TextEditingController();
  TextEditingController _contactPersonController = TextEditingController();
  TextEditingController _contactPersonNumberController = TextEditingController();
  late bool _isLog;
  CameraPosition _cameraPosition = const CameraPosition(target: LatLng(34.0151,71.5249,),zoom: 15);
  LatLng _initialPosition = const LatLng(34.0151,71.5249,);

  @override
  void initState() {
    super.initState();
    if(Get.find<LocationController>().addressList.isNotEmpty){
      _cameraPosition = CameraPosition(target: LatLng(
        double.parse(Get.find<LocationController>().getAddress['latitude']),
        double.parse(Get.find<LocationController>().getAddress['longitude']),
      ));
      _initialPosition = LatLng(
        double.parse(Get.find<LocationController>().getAddress['latitude']),
        double.parse(Get.find<LocationController>().getAddress['longitude']),
      );
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Address Page',),
        backgroundColor: AppColors.mainColor,
      ),
      body: GetBuilder<LocationController>(
        builder: (locationController) {
          _addressController.text = '${locationController.placemark.street ?? ''},'
              '${locationController.placemark.subLocality ?? ''},'
              '${locationController.placemark.locality ?? ''}'
              '${locationController.placemark.country ?? ''} ';
          print('address ${_addressController.text}');
          return Column(
            children: [
              Container(
                height: 140,
                width: MediaQuery.of(context).size.width,
                // margin: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  border: Border.all(width: 2,color: Theme.of(context).primaryColor),
                ),
                child: Stack(
                  children: [
                    GoogleMap(
                      initialCameraPosition: CameraPosition(
                        target: _initialPosition,
                        zoom: 17,),
                      onTap: (latLng){
                        Get.to(()=>PickAddressMap(controller: locationController.googleController,fromAddress: true,fromSignUp: false,));
                      },
                      zoomControlsEnabled: false,
                      compassEnabled: false,
                      indoorViewEnabled: true,
                      mapToolbarEnabled: false,
                      myLocationEnabled: true,
                      onCameraIdle: (){
                        locationController.updatePosition(_cameraPosition,true);
                      },
                      onCameraMove: (position){_cameraPosition = position;},
                      onMapCreated: ((mapController) {
                        locationController.setMapController(mapController);
                      }),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 50,
                child: ListView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemCount: locationController.addressTypeList.length,
                    itemBuilder: (context,index){
                      return InkWell(
                        onTap: (){
                          locationController.setAddressType(index);
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: Dimensions.height20,vertical: Dimensions.height10),
                          margin: EdgeInsets.only(right: Dimensions.height10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: Theme.of(context).cardColor,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey[200]!,
                                spreadRadius: 1,
                                blurRadius: 5
                              ),
                            ]
                          ),
                          child: Row(
                            children: [
                              Icon(
                                index==0? Icons.home:index==1?Icons.work:Icons.location_on,
                                color: locationController.addressTypeIndex==index?AppColors.mainColor:Theme.of(context).disabledColor ,),
                            ],
                          ),
                        ),
                      );
                    }),),
              SizedBox(height: Dimensions.height20,),
              const BigText(text: 'Delivery Address'),
              SizedBox(height: Dimensions.height20,),
              TextFieldWidget(controller: _addressController, hintText: '')
            ],
          );
        },
      ),
      bottomNavigationBar: GetBuilder<LocationController>(
        builder: (locationController) {
          return ElevatedButton(onPressed: (){}, child: const Text('Save Address'));
        },
      ),
    );
  }
}
