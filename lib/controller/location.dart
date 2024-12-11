import 'dart:async';
import 'dart:developer';

import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';

import '../widgets/tost_message.dart';

class LocationController extends GetxController {
  final Rx<Position?> _currentPosition = Rx<Position?>(null);
  final Rx<PermissionStatus> _permissionStatus =
      Rx<PermissionStatus>(PermissionStatus.denied);
  StreamSubscription<Position>? _positionStreamSubscription;

  Position? get currentPosition => _currentPosition.value;

  set currentPosition(Position? position) {
    _currentPosition.value = position;
    log('Current Position: ${position?.latitude}, ${position?.longitude} Accurecy : ${position?.accuracy}');
  }

  PermissionStatus get permissionStatus => _permissionStatus.value;

  @override
  void onInit() {
    super.onInit();
    getCurrentPosition();
  }

  @override
  void onClose() {
    stopLocationUpdates();
    super.onClose();
  }

  /// Check if the app has the necessary location permissions and request if needed
  Future<void> checkAndRequestPermission() async {
    PermissionStatus status = await Permission.locationWhenInUse.status;

    if (status.isDenied) {
      status = await Permission.locationWhenInUse.request();
    } else if (status.isPermanentlyDenied) {
      await openAppSettings();
    }

    _permissionStatus.value = status;
  }

  /// Fetch the current location and subscribe to location updates
  Future<void> getCurrentPosition() async {
    await checkAndRequestPermission();

    if (_permissionStatus.value.isGranted) {
      await _fetchLocation();
    } else {
      showToast('Location permission denied.', position: false);
    }
  }

  Future<void> _fetchLocation() async {
    try {
      const LocationSettings locationSettings = LocationSettings(
        accuracy: LocationAccuracy.bestForNavigation,
        // distanceFilter: 10,
      );

      Position position = await Geolocator.getCurrentPosition(
        locationSettings: locationSettings,
      );

      currentPosition = position;
      showToast('Location fetched successfully', position: false);

      // Start listening to location updates
      _positionStreamSubscription =
          Geolocator.getPositionStream(locationSettings: locationSettings)
              .listen((Position? position) {
        if (position != null) {
          currentPosition = position;
        }
      });
    } catch (e) {
      log('Error fetching location: $e');
      showToast('Failed to fetch location.', position: false);
      currentPosition = null;
    }
  }

  /// Stop receiving location updates
  void stopLocationUpdates() {
    _positionStreamSubscription?.cancel();
    _positionStreamSubscription = null;
    showToast('Location updates stopped.', position: false);
  }
}
