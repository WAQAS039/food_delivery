class AddressModel{
  late int? _id;
  late String _addressType;
  late String? _contactPerson;
  late String? _contactPersonNumber;
  late String _address;
  late String _latitude;
  late String _longitude;

  String? get addressType => _addressType;
  String? get address => _address;
  String? get contactPerson => _contactPersonNumber;
  String? get contactPersonNumber => _contactPersonNumber;
  String? get latitude => _latitude;
  String? get longitude => _longitude;

  AddressModel({
    id,
    required addressType,
    contactPerson,
    contactPersonNumber,
    address,
    latitude,
    longitude}){
    _id = id;
    _addressType = addressType;
    _contactPerson = contactPerson;
    _contactPersonNumber = _contactPersonNumber;
    _address = address;
    _latitude = latitude;
    _longitude = longitude;
  }

  AddressModel.fromJson(Map<String,dynamic> json){
    _id = json['id'];
    _addressType = json['addressType'] ?? "";
    _contactPerson = json['contactPerson'] ?? "";
    _contactPersonNumber = json['contactPersonNumber'] ?? "";
    _address = json['address'];
    _latitude = json['latitude'];
    _longitude = json['longitude'];
  }

  Map toJson(){
    return {
      'id':_id,
      'addressType':_addressType,
      'contactPerson':_contactPerson,
      'contactPersonNumber':_contactPersonNumber,
      'address':_address,
      'latitude':_latitude,
      'longitude':_longitude
    };
  }
}