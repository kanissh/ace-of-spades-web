import 'package:ace_of_spades/api/models/forward_geocoding.model.dart';

abstract class ForwardIApiRepository {
  Future<ForwardGeocodingModel> performForwardGeocoding(String placeName);
}
