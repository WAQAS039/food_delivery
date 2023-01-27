import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class PickAddressMap extends StatefulWidget {
  final GoogleMapController controller;
  final bool fromAddress;
  final bool fromSignUp;
  const PickAddressMap({Key? key,required this.controller,required this.fromAddress,required this.fromSignUp}) : super(key: key);

  @override
  State<PickAddressMap> createState() => _PickAddressMapState();
}

class _PickAddressMapState extends State<PickAddressMap> {
  LatLng _initialPosition = const LatLng(34.0151,71.5249,);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SizedBox(
            width: double.maxFinite,
            child: Stack(
              children: [
                GoogleMap(
                  initialCameraPosition: CameraPosition(
                    target: _initialPosition,
                    zoom: 17,),
                  zoomControlsEnabled: false,
                  compassEnabled: false,
                  indoorViewEnabled: true,
                  mapToolbarEnabled: false,
                  myLocationEnabled: true,
                  onCameraIdle: (){
                    // locationController.updatePosition(_cameraPosition,true);
                  },
                  onCameraMove: (position){
                    // _cameraPosition = position;
                    },
                  onMapCreated: ((mapController) {
                    // locationController.setMapController(mapController);
                  }),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
