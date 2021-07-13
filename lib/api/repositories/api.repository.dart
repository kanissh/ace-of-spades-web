import 'package:ace_of_spades/api/api.const.dart';
import 'package:ace_of_spades/api/models/forward_geocoding.model.dart';
import 'package:ace_of_spades/api/models/reverse_geocoding.model.dart';
import 'package:ace_of_spades/api/providers/api.provider.dart';
import 'package:ace_of_spades/api/repositories/forward_iapi.repository.dart';
import 'package:ace_of_spades/api/repositories/reverse_iapi.repository.dart';
import 'package:ace_of_spades/utils/config.helper.dart';

class ApiRepository implements ReverseIApiRepository, ForwardIApiRepository {
  static final ApiRepository instance = ApiRepository._();
  final ApiProvider _provider = ApiProvider(baseURL: MAPBOX_BASE_URL);

  ApiRepository._();

  @override
  Future<ReverseGeocodingModel> performReverseGeocoding(
    double latitude,
    double longitude,
  ) async {
    final apiToken = (await loadConfigFile())['mapbox_api_token'] as String;
    final result = await _provider.makeGetRequest(
      'geocoding/v5/mapbox.places/$longitude,$latitude.json',
      queryParams: {
        'types': 'region',
        'access_token': apiToken,
      },
    );

    return result != null ? ReverseGeocodingModel.fromJson(result) : ReverseGeocodingModel();
  }

  @override
  Future<ForwardGeocodingModel> performForwardGeocoding(String searchName) async {
    final apiToken = (await loadConfigFile())['mapbox_api_token'] as String;
    final result = await _provider.makeGetRequest(
      'geocoding/v5/mapbox.places/$searchName.json',
      queryParams: {
        'types': 'place',
        'access_token': apiToken,
      },
    );

    return result != null ? ForwardGeocodingModel.fromJson(result) : ForwardGeocodingModel();
  }
}
