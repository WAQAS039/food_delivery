import 'package:food_delivery/data/reposities/location_repo.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../Models/address_model.dart';

class LocationController extends GetxController implements GetxService{
  LocationRepo locationRepo;
  LocationController({required this.locationRepo});
  bool _loading = false;
  late Position _position;
  late Position _pickPosition;
  bool get loading => _loading;
  Position get position => _position;
  Position get pickPosition => _pickPosition;

  Placemark _placemark = Placemark();
  Placemark _pickPlacemar = Placemark();
  Placemark get placemark => _placemark;
  Placemark get pickPlacemar => _pickPlacemar;
  List<AddressModel> _addressList = [];
  List<AddressModel> get addressList =>_addressList;
  List<AddressModel> _allAddressList = [];
  final List<String> _addressTypeList = ['home','office','school'];
  List<String> get addressTypeList => _addressTypeList;
  int _addressTypeIndex = 0;
  int get addressTypeIndex =>_addressTypeIndex;
  late Map<String,dynamic> _getAddress;
  Map<String,dynamic> get getAddress => _getAddress;
  late GoogleMapController _googleMapController;
  GoogleMapController get googleController => _googleMapController;
  bool _isAddressUpdated = true;
  bool _changeAddress = true;
  void setMapController(GoogleMapController controller){
    _googleMapController = controller;
  }

  void updatePosition(CameraPosition cameraPosition,bool fromAddress) async{
    print('calling');
    if(_isAddressUpdated){
      _loading = true;
      update();
      try{
        if(fromAddress){
          _position = Position(
              longitude: cameraPosition.target.longitude,
              latitude: cameraPosition.target.latitude,
              timestamp: DateTime.now(),
              accuracy: 1,
              altitude: 1,
              heading: 1,
              speed: 1,
              speedAccuracy: 1);
        }else{
          _pickPosition = Position(
              longitude: cameraPosition.target.longitude,
              latitude: cameraPosition.target.latitude,
              timestamp: DateTime.now(),
              accuracy: 1,
              altitude: 1,
              heading: 1,
              speed: 1,
              speedAccuracy: 1);
        }

        if(_changeAddress){
          Placemark _address = await getAddressFromGeoCode(LatLng(cameraPosition.target.latitude, cameraPosition.target.longitude));
          fromAddress? _placemark=_address:_pickPlacemar=_address;
          print('update $_address');
        }
      }catch(e){
        print(e);
      }
    }
  }

  Future<Placemark> getAddressFromGeoCode(LatLng latLng) async {
    String address = "unknown Address";
    List<Placemark> placemarks = await placemarkFromCoordinates(latLng.latitude, latLng.longitude);
    address = '${placemarks}';
    // print('goecode ${placemarks[0].name},${placemarks[0].street},${placemarks[0].locality},${placemarks[0].country}');
    // Response response = await locationRepo.getAddressFromGeocoding(latLng);
    update();
    return placemarks[0];
  }


  void setAddressType(int index){
    _addressTypeIndex = index;
    update();
  }

  
}