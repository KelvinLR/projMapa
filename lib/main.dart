import 'package:flutter/material.dart';
import 'package:flutter_osm_plugin/flutter_osm_plugin.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'OpenStreetMap',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'OpenStreetMap'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final mapController = MapController(initMapWithUserPosition: true);

  var markerMap = <String, String>{};

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      mapController.listenerMapSingleTapping.addListener(() async {
        var position = mapController.listenerMapSingleTapping.value;
        if (position != null) {
          await mapController.addMarker(position,
              markerIcon: const MarkerIcon(
                  icon: Icon(
                Icons.pin_drop,
                color: Colors.blue,
                size: 80,
              )));

          var key =
              'Latitude: ${position.latitude}\nLongitude: ${position.longitude}';
          markerMap[key] = markerMap.length.toString();
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: OSMFlutter(
        controller: mapController,
        mapIsLoading: const Center(
          child: CircularProgressIndicator(),
        ),
        trackMyPosition: true,
        initZoom: 12,
        minZoomLevel: 2,
        maxZoomLevel: 19,
        stepZoom: 1.0,
        androidHotReloadSupport: true,
        userLocationMarker: UserLocationMaker(
          personMarker: const MarkerIcon(
              icon: Icon(Icons.personal_injury, color: Colors.black, size: 48)),
          directionArrowMarker: const MarkerIcon(
              icon: Icon(Icons.location_on, color: Colors.black, size: 48)),
        ),
        roadConfiguration: const RoadOption(roadColor: Colors.blueGrey),
        markerOption: MarkerOption(
          defaultMarker: const MarkerIcon(
            icon: Icon(Icons.person_pin_circle, color: Colors.black, size: 48),
          ),
        ),
        onMapIsReady: (isReady) async {
          if (isReady) {
            await Future.delayed(const Duration(seconds: 1), () async {
              await mapController.currentLocation();
            });
          }
        },
        onGeoPointClicked: (geoPoint) {
          var key = '${geoPoint.latitude}_${geoPoint.longitude}';
          showModalBottomSheet(
            context: context,
            builder: (context) {
              return Container(
                  constraints: BoxConstraints(minHeight: 100),
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.all(8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Expanded(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  'Posição ${markerMap[key]}',
                                  style: const TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.blue),
                                ),
                                const Divider(
                                  thickness: 1,
                                ),
                                Text(
                                  key,
                                ),
                              ],
                            ),
                          ),
                          GestureDetector(
                            onTap: () => Navigator.pop(context),
                            child: const Icon(Icons.clear),
                          ),
                        ],
                      ),
                    ),
                  ));
            },
          );
        },
      ),
    );
  }
}
