import 'package:food_delivery/data/api/api_client.dart';
import 'package:food_delivery/utils/app_constants.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter_platform_interface/src/types/location.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocationRepo{
  ApiClient apiClient;
  SharedPreferences sharedPreferences;
  LocationRepo({required this.apiClient,required this.sharedPreferences});

  // Future<Response> getAddressFromGeocoding(LatLng latLng) async{
  //   // return await apiClient.getData('${AppConstants.GeoCodeUri}?lat=${latLng.latitude}&lng=${latLng.longitude}');
  // }
}