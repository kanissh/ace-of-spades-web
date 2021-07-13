import 'package:ace_of_spades/api/repositories/api.repository.dart';
import 'package:ace_of_spades/utils/config.helper.dart';
import 'package:ace_of_spades/utils/location.helper.dart';
import 'package:flutter/material.dart';
import 'package:mapbox_gl/mapbox_gl.dart';
import 'package:mapbox_search/mapbox_search.dart';
import 'package:material_floating_search_bar/material_floating_search_bar.dart';

import '../constants.dart';

class MapPage extends StatefulWidget {
  @override
  _MapPageState createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  final repository = ApiRepository.instance;
  MapboxMapController mapController;

  final FloatingSearchBarController _floatingSearchBarController = FloatingSearchBarController();

  List<MapBoxPlace> queryPlaces = List();

  getPlacesList(List<MapBoxPlace> places) {
    List<Widget> results = List();
    for (var place in places) {
      results.add(
        ListTile(
          title: Text(place.placeName),
          onTap: () {
            setState(() {
              mapController.animateCamera(
                CameraUpdate.newCameraPosition(
                  CameraPosition(
                    target: LatLng(
                      place.geometry.coordinates.first,
                      place.geometry.coordinates.last,
                    ),
                    zoom: 50,
                  ),
                ),
              );
            });

            setState(() {
              mapController.addCircle(
                CircleOptions(
                  circleRadius: 10,
                  circleColor: '#000000',
                  geometry: LatLng(
                    place.geometry.coordinates.first,
                    place.geometry.coordinates.last,
                  ),
                ),
              );
            });
          },
        ),
      );
    }

    return results;
  }

  @override
  Widget build(BuildContext context) {
    final isPortrait = MediaQuery.of(context).orientation == Orientation.portrait;

    return SafeArea(
      child: Scaffold(
        body: FutureBuilder(
          future: loadConfigFile(),
          builder: (BuildContext context, AsyncSnapshot<Map<String, dynamic>> snapshot) {
            if (snapshot.hasData) {
              return Stack(
                fit: StackFit.expand,
                alignment: Alignment.bottomRight,
                children: [
                  MapboxMap(
                    cameraTargetBounds: CameraTargetBounds(
                      LatLngBounds(
                        southwest: LatLng(7.239157512248738, 80.58135242077032),
                        northeast: LatLng(7.279977791172868, 80.61140926621937),
                      ),
                    ),
                    styleString: snapshot.data['mapbox_style_string'].toString(),
                    accessToken: snapshot.data['mapbox_api_token'],
                    initialCameraPosition: CameraPosition(
                      target: LatLng(45.45, 45.45),
                    ),
                    onMapCreated: (mapController) async {
                      await mapController.animateCamera(
                        CameraUpdate.newLatLngBounds(
                          LatLngBounds(
                            southwest: LatLng(7.239157512248738, 80.58135242077032),
                            northeast: LatLng(7.279977791172868, 80.61140926621937),
                          ),
                        ),
                      );

                      final _location = LatLng(7.254212510590577, 80.5967939152037);
                      //FIXME: Remove comment, commented to temporarily disabled get location
                      //final _location = await getCurrentLocation();

                      final LatLng _defaultLocation = LatLng(7.254212510590577, 80.5967939152037);
                      bool animateCameraResult;

                      if (_location == null) {
                        animateCameraResult = await mapController.animateCamera(
                          CameraUpdate.newCameraPosition(
                            CameraPosition(target: _defaultLocation, zoom: 13),
                          ),
                        );

                        if (animateCameraResult) {
                          mapController.addCircle(
                            CircleOptions(
                              circleRadius: 10,
                              circleColor: '#000000',
                              geometry: _defaultLocation,
                            ),
                          );
                        }
                      } else {
                        animateCameraResult = await mapController.animateCamera(
                          CameraUpdate.newCameraPosition(
                            CameraPosition(target: _location, zoom: 12),
                          ),
                        );
                        if (animateCameraResult) {
                          mapController.addCircle(
                            CircleOptions(
                              circleRadius: 10,
                              circleColor: '#000000',
                              geometry: _location,
                            ),
                          );
                        }
                      }
                    },
                    onMapClick: (point, coordinates) async {
                      final result =
                          await repository.performReverseGeocoding(coordinates.latitude, coordinates.longitude);
                      print(result.toString());
                      Scaffold.of(context).showBottomSheet((context) {
                        return Wrap(children: [Text(result.toString())]);
                      });
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 0, 10, 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        /* FloatingActionButton(
                          backgroundColor: redColor,
                          mini: true,
                          child: Icon(Icons.search),
                          onPressed: () {},
                        ),
                        SizedBox(
                          height: 10,
                        ), */
                        FloatingActionButton(
                          backgroundColor: redColor,
                          mini: true,
                          child: Icon(Icons.my_location),
                          onPressed: () {},
                        ),
                      ],
                    ),
                  ),
                  FloatingSearchBar(
                    automaticallyImplyBackButton: false,
                    hint: 'Search...',
                    scrollPadding: const EdgeInsets.only(top: 16, bottom: 56),
                    transitionDuration: const Duration(milliseconds: 800),
                    transitionCurve: Curves.easeInOut,
                    physics: const BouncingScrollPhysics(),
                    axisAlignment: isPortrait ? 0.0 : -1.0,
                    openAxisAlignment: 0.0,
                    openWidth: isPortrait ? 600 : 500,
                    debounceDelay: const Duration(milliseconds: 500),
                    controller: _floatingSearchBarController,
                    /*onQueryChanged: (query) async {
                      if (query != null || query.isNotEmpty) {
                        var placesSearch = PlacesSearch(
                          apiKey: snapshot.data['mapbox_api_token'],
                          limit: 5,
                        );

                        try {
                          queryPlaces = await placesSearch.getPlaces(query);

                          print(queryPlaces.toString());
                        } on Exception catch (e) {
                          print(e.toString());
                        }
                      }
                    },*/

                    onSubmitted: (query) async {
                      if (query != null || query.isNotEmpty) {
                        var placesSearch = PlacesSearch(
                          apiKey: snapshot.data['mapbox_api_token'],
                          limit: 5,
                        );

                        try {
                          List<MapBoxPlace> queryPlacesTemp = await placesSearch.getPlaces(query);
                          setState(() {
                            queryPlaces = queryPlacesTemp;
                          });
                          await placesSearch.getPlaces(query);

                          print(queryPlaces.toString());
                        } on Exception catch (e) {
                          print(e.toString());
                        }
                      }
                    },
                    transition: ExpandingFloatingSearchBarTransition(),
                    leadingActions: [
                      FloatingSearchBarAction.back(),
                    ],
                    actions: [
                      FloatingSearchBarAction(
                        child: CircularButton(
                          icon: Icon(Icons.search),
                          onPressed: () {
                            _floatingSearchBarController.open();
                          },
                        ),
                      ),
                      FloatingSearchBarAction.icon(
                          showIfClosed: false,
                          showIfOpened: true,
                          icon: Icons.close,
                          onTap: () {
                            _floatingSearchBarController.query = '';
                          })
                    ],
                    builder: (context, transition) {
                      return ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Material(
                          color: Colors.white,
                          elevation: 4.0,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: getPlacesList(queryPlaces),
                          ),
                        ),
                      );
                    },
                  )
                ],
              );
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
      ),
    );
  }
}
/*return ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: Material(
          color: Colors.white,
          elevation: 4.0,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: Colors.accents.map((color) {
              return Container(height: 112, color: color);
            }).toList(),
          ),
        ),
      );*/
