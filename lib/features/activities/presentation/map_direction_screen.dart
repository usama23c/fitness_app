// import 'dart:async';
// import 'package:flutter/material.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:fitness_app/core/constants/app_colors.dart';
// import 'package:location/location.dart';
// import 'dart:math';
// import 'activity_completion_screen.dart';

// class MapDirectionScreen extends StatefulWidget {
//   final String activityType;
//   final double userWeight; // in kg

//   const MapDirectionScreen({
//     super.key,
//     required this.activityType,
//     this.userWeight = 70.0, // default weight
//   });

//   @override
//   State<MapDirectionScreen> createState() => _MapDirectionScreenState();
// }

// class _MapDirectionScreenState extends State<MapDirectionScreen> {
//   late GoogleMapController mapController;
//   Location location = Location();
//   LatLng? currentLocation;
//   Set<Marker> markers = {};
//   Set<Polyline> polylines = {};
//   List<LatLng> pathPoints = [];
//   double distance = 0.0; // in km
//   bool isTracking = false;
//   DateTime? startTime;
//   int bpm = 80; // starting BPM
//   Timer? bpmTimer;
//   List<int> bpmHistory = [];

//   // MET values for different activities (calories/kg/hour)
//   final Map<String, double> metValues = {
//     'Running': 8.0,
//     'Cycling': 6.0,
//     'Walking': 3.5,
//     'Swimming': 7.0,
//   };

//   @override
//   void initState() {
//     super.initState();
//     _getCurrentLocation();
//     _simulateBpmChanges();
//   }

//   @override
//   void dispose() {
//     bpmTimer?.cancel();
//     super.dispose();
//   }

//   void _simulateBpmChanges() {
//     bpmTimer = Timer.periodic(const Duration(seconds: 5), (timer) {
//       if (isTracking) {
//         setState(() {
//           // Simulate BPM changes during activity
//           bpm = 80 + Random().nextInt(60); // Random BPM between 80-140
//           bpmHistory.add(bpm);
//         });
//       }
//     });
//   }

//   Future<void> _getCurrentLocation() async {
//     try {
//       var userLocation = await location.getLocation();
//       setState(() {
//         currentLocation =
//             LatLng(userLocation.latitude!, userLocation.longitude!);
//         markers.add(Marker(
//           markerId: const MarkerId('start'),
//           position: currentLocation!,
//           icon:
//               BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
//         ));
//       });
//     } catch (e) {
//       debugPrint("Error getting location: $e");
//     }
//   }

//   void _startTracking() {
//     setState(() {
//       isTracking = true;
//       startTime = DateTime.now();
//       pathPoints.clear();
//       bpmHistory.clear();
//       if (currentLocation != null) {
//         pathPoints.add(currentLocation!);
//       }
//     });
//   }

//   void _endTracking() {
//     if (startTime == null) return;

//     final duration = DateTime.now().difference(startTime!);
//     final calories = _calculateCalories(duration.inMinutes);

//     Navigator.pushReplacement(
//       context,
//       MaterialPageRoute(
//         builder: (context) => ActivityCompletionScreen(
//           activityType: widget.activityType,
//           distance: distance,
//           duration: duration,
//           calories: calories,
//           bpmHistory: bpmHistory,
//         ),
//       ),
//     );
//   }

//   double _calculateCalories(int minutes) {
//     final met = metValues[widget.activityType] ?? 5.0;
//     // Calories = MET * weight in kg * time in hours
//     return met * widget.userWeight * (minutes / 60);
//   }

//   void _updateLocation(LatLng newLocation) {
//     if (!isTracking || currentLocation == null) return;

//     setState(() {
//       // Update current location marker
//       markers.removeWhere((m) => m.markerId.value == 'current');
//       markers.add(Marker(
//         markerId: const MarkerId('current'),
//         position: newLocation,
//         icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
//       ));

//       // Calculate distance using Haversine formula
//       final double deltaDistance = _calculateHaversineDistance(
//         currentLocation!.latitude,
//         currentLocation!.longitude,
//         newLocation.latitude,
//         newLocation.longitude,
//       );
//       distance += deltaDistance;

//       // Add to path
//       pathPoints.add(newLocation);
//       _updatePolyline();
//       currentLocation = newLocation;
//     });
//   }

//   double _calculateHaversineDistance(
//       double lat1, double lon1, double lat2, double lon2) {
//     const R = 6371.0; // Earth radius in km
//     final dLat = _toRadians(lat2 - lat1);
//     final dLon = _toRadians(lon2 - lon1);
//     final a = pow(sin(dLat / 2), 2) +
//         cos(_toRadians(lat1)) * cos(_toRadians(lat2)) * pow(sin(dLon / 2), 2);
//     final c = 2 * atan2(sqrt(a), sqrt(1 - a));
//     return R * c;
//   }

//   double _toRadians(double degree) {
//     return degree * pi / 180;
//   }

//   void _updatePolyline() {
//     setState(() {
//       polylines = {
//         Polyline(
//           polylineId: const PolylineId('route'),
//           points: pathPoints,
//           color: AppColors.primary,
//           width: 5,
//           geodesic: true,
//         ),
//       };
//     });
//   }

//   String _formatDuration(Duration duration) {
//     String twoDigits(int n) => n.toString().padLeft(2, '0');
//     final hours = twoDigits(duration.inHours);
//     final minutes = twoDigits(duration.inMinutes.remainder(60));
//     final seconds = twoDigits(duration.inSeconds.remainder(60));
//     return '$hours:$minutes:$seconds';
//   }

//   @override
//   Widget build(BuildContext context) {
//     final currentDuration = startTime != null
//         ? DateTime.now().difference(startTime!)
//         : Duration.zero;

//     return Scaffold(
//       body: Stack(
//         children: [
//           GoogleMap(
//             initialCameraPosition: CameraPosition(
//               target: currentLocation ?? const LatLng(0, 0),
//               zoom: 15,
//             ),
//             onMapCreated: (controller) => mapController = controller,
//             markers: markers,
//             polylines: polylines,
//             myLocationEnabled: true,
//             myLocationButtonEnabled: false,
//             // onCameraMove: isTracking ? _updateLocation : null,
//           ),

//           // Back button
//           Positioned(
//             top: 40,
//             left: 10,
//             child: IconButton(
//               icon: const Icon(Icons.arrow_back, color: Colors.white),
//               onPressed: () => Navigator.pop(context),
//             ),
//           ),

//           // Tracking controls
//           Positioned(
//             bottom: 120,
//             right: 20,
//             child: Column(
//               children: [
//                 FloatingActionButton(
//                   heroTag: 'start',
//                   backgroundColor: AppColors.primary,
//                   onPressed: isTracking ? null : _startTracking,
//                   child: const Icon(Icons.play_arrow, color: Colors.white),
//                 ),
//                 const SizedBox(height: 10),
//                 FloatingActionButton(
//                   heroTag: 'stop',
//                   backgroundColor: AppColors.primary,
//                   onPressed: isTracking ? _endTracking : null,
//                   child: const Icon(Icons.stop, color: Colors.white),
//                 ),
//               ],
//             ),
//           ),

//           // Stats panel
//           Positioned(
//             bottom: 20,
//             left: 20,
//             child: Container(
//               padding: const EdgeInsets.all(12),
//               decoration: BoxDecoration(
//                 color: Colors.white,
//                 borderRadius: BorderRadius.circular(12),
//                 boxShadow: [
//                   BoxShadow(
//                     color: Colors.black12,
//                     blurRadius: 6,
//                     spreadRadius: 2,
//                   ),
//                 ],
//               ),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     widget.activityType,
//                     style: const TextStyle(
//                       fontWeight: FontWeight.bold,
//                       fontSize: 16,
//                     ),
//                   ),
//                   const SizedBox(height: 8),
//                   Text('Distance: ${distance.toStringAsFixed(2)} km'),
//                   Text('Time: ${_formatDuration(currentDuration)}'),
//                   Text('BPM: $bpm'),
//                   Text(
//                       'Calories: ${_calculateCalories(currentDuration.inMinutes).toStringAsFixed(1)} kcal'),
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:location/location.dart';

import 'package:fitness_app/core/constants/app_colors.dart';
import 'activity_completion_screen.dart';
// Optional: Uncomment if using the improved tile provider
import 'package:flutter_map_cancellable_tile_provider/flutter_map_cancellable_tile_provider.dart';

class MapDirectionScreen extends StatefulWidget {
  final String activityType;
  final double userWeight;

  const MapDirectionScreen({
    super.key,
    required this.activityType,
    this.userWeight = 70.0,
  });

  @override
  State<MapDirectionScreen> createState() => _MapDirectionScreenState();
}

class _MapDirectionScreenState extends State<MapDirectionScreen> {
  final MapController _mapController = MapController();
  final Location _location = Location();

  LatLng? currentLocation;
  List<LatLng> pathPoints = [];
  double distance = 0.0;
  bool isTracking = false;
  DateTime? startTime;
  int bpm = 80;
  Timer? bpmTimer;
  List<int> bpmHistory = [];

  final Map<String, double> metValues = {
    'Running': 8.0,
    'Cycling': 6.0,
    'Walking': 3.5,
    'Swimming': 7.0,
  };

  StreamSubscription<LocationData>? _locationSubscription;

  @override
  void initState() {
    super.initState();
    _initLocation();
    _simulateBpmChanges();
  }

  @override
  void dispose() {
    bpmTimer?.cancel();
    _locationSubscription?.cancel();
    super.dispose();
  }

  Future<void> _initLocation() async {
    final hasPermission = await _location.requestPermission();
    if (hasPermission != PermissionStatus.granted) return;

    final loc = await _location.getLocation();
    setState(() {
      currentLocation = LatLng(loc.latitude!, loc.longitude!);
    });

    _locationSubscription = _location.onLocationChanged.listen((locData) {
      final newLocation = LatLng(locData.latitude!, locData.longitude!);
      if (isTracking) _updateLocation(newLocation);
      setState(() {
        currentLocation = newLocation;
      });
    });
  }

  void _simulateBpmChanges() {
    bpmTimer = Timer.periodic(const Duration(seconds: 5), (_) {
      if (isTracking) {
        setState(() {
          bpm = 80 + Random().nextInt(60); // 80-140 BPM
          bpmHistory.add(bpm);
        });
      }
    });
  }

  void _startTracking() {
    if (currentLocation == null) return;
    setState(() {
      isTracking = true;
      pathPoints.clear();
      bpmHistory.clear();
      distance = 0.0;
      startTime = DateTime.now();
      pathPoints.add(currentLocation!);
    });
  }

  void _endTracking() {
    if (startTime == null) return;

    final duration = DateTime.now().difference(startTime!);
    final calories = _calculateCalories(duration.inMinutes);

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (_) => ActivityCompletionScreen(
          activityType: widget.activityType,
          distance: distance,
          duration: duration,
          calories: calories,
          bpmHistory: bpmHistory,
        ),
      ),
    );
  }

  void _updateLocation(LatLng newLocation) {
    if (!isTracking || currentLocation == null) return;

    final deltaDistance = _calculateHaversineDistance(
      currentLocation!.latitude,
      currentLocation!.longitude,
      newLocation.latitude,
      newLocation.longitude,
    );
    distance += deltaDistance;

    setState(() {
      pathPoints.add(newLocation);
      currentLocation = newLocation;
    });
  }

  double _calculateCalories(int minutes) {
    final met = metValues[widget.activityType] ?? 5.0;
    return met * widget.userWeight * (minutes / 60.0);
  }

  double _calculateHaversineDistance(
      double lat1, double lon1, double lat2, double lon2) {
    const R = 6371.0;
    final dLat = _toRadians(lat2 - lat1);
    final dLon = _toRadians(lon2 - lon1);
    final a = pow(sin(dLat / 2), 2) +
        cos(_toRadians(lat1)) * cos(_toRadians(lat2)) * pow(sin(dLon / 2), 2);
    final c = 2 * atan2(sqrt(a), sqrt(1 - a));
    return R * c;
  }

  double _toRadians(double degree) => degree * pi / 180;

  String _formatDuration(Duration d) {
    String two(int n) => n.toString().padLeft(2, '0');
    return "${two(d.inHours)}:${two(d.inMinutes % 60)}:${two(d.inSeconds % 60)}";
  }

  @override
  Widget build(BuildContext context) {
    final currentDuration = startTime != null
        ? DateTime.now().difference(startTime!)
        : Duration.zero;

    return Scaffold(
      body: Stack(
        children: [
          currentLocation == null
              ? const Center(child: CircularProgressIndicator())
              : FlutterMap(
                  mapController: _mapController,
                  options: MapOptions(
                    initialCenter: currentLocation!,
                    initialZoom: 16,
                  ),
                  children: [
                    TileLayer(
                      urlTemplate:
                          'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                      userAgentPackageName: 'com.fitness.app',
                      // Uncomment below for better web performance
                      tileProvider: CancellableNetworkTileProvider(),
                    ),
                    if (pathPoints.length >= 2)
                      PolylineLayer(
                        polylines: [
                          Polyline(
                            points: pathPoints,
                            color: AppColors.primary,
                            strokeWidth: 5.0,
                          ),
                        ],
                      ),
                  ],
                ),

          // Back Button
          Positioned(
            top: 40,
            left: 10,
            child: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.black),
              onPressed: () => Navigator.pop(context),
            ),
          ),

          // FAB Controls
          Positioned(
            bottom: 120,
            right: 20,
            child: Column(
              children: [
                FloatingActionButton(
                  heroTag: 'start',
                  backgroundColor: AppColors.primary,
                  onPressed: isTracking ? null : _startTracking,
                  child: const Icon(Icons.play_arrow),
                ),
                const SizedBox(height: 10),
                FloatingActionButton(
                  heroTag: 'stop',
                  backgroundColor: AppColors.primary,
                  onPressed: isTracking ? _endTracking : null,
                  child: const Icon(Icons.stop),
                ),
              ],
            ),
          ),

          // Stats Panel
          Positioned(
            bottom: 20,
            left: 20,
            child: Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 6,
                    spreadRadius: 2,
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(widget.activityType,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 16)),
                  const SizedBox(height: 8),
                  Text('Distance: ${distance.toStringAsFixed(2)} km'),
                  Text('Time: ${_formatDuration(currentDuration)}'),
                  Text('BPM: $bpm'),
                  Text(
                      'Calories: ${_calculateCalories(currentDuration.inMinutes).toStringAsFixed(1)} kcal'),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
