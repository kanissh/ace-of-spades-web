import 'package:ace_of_spades/api/models/reverse_geocoding.model.dart';

abstract class ReverseIApiRepository {
  Future<ReverseGeocodingModel> performReverseGeocoding(
    double latitude,
    double longitude,
  );
}
