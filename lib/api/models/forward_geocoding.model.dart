class ForwardGeocodingModel {
  double latitude;
  double longitude;
  String placeName;
  // String searchName;

  ForwardGeocodingModel({
    this.latitude = 0.0,
    this.longitude = 0.0,
    this.placeName = '',
  });

  ForwardGeocodingModel.fromJson(Map<String, dynamic> json) {
    List<dynamic> coordinates = json['features'][0]['center'];
    this.latitude = coordinates.first;
    this.longitude = coordinates.last;
    this.placeName = json['features'][0]['place_name'] as String;
  }

  @override
  String toString() {
    return '${latitude.toString()} : ${longitude.toString()} = $placeName';
  }
}
