import 'package:app_settings/app_settings.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';

class LocationService {
  Future<Placemark?> getFullLocationFromCoordinates({
    bool? permissionForce = false,
  }) async {
    try {
      PermissionStatus permissionStatus =
          await Permission.locationWhenInUse.request();
      if (permissionStatus.isGranted) {
        Position position = await Geolocator.getCurrentPosition(
          locationSettings: const LocationSettings(
            accuracy: LocationAccuracy.medium,
            distanceFilter: 10,
          ),
        );
        List<Placemark> placeMarks = await placemarkFromCoordinates(
          position.latitude,
          position.longitude,
        );
        if (placeMarks.isNotEmpty) {
          return placeMarks.first;
        }
      } else if (permissionStatus.isDenied && permissionForce!) {
        return await getFullLocationFromCoordinates(
          permissionForce: permissionForce,
        );
      } else if (permissionStatus.isPermanentlyDenied && permissionForce!) {
        await AppSettings.openAppSettings();

        return await getFullLocationFromCoordinates(
          permissionForce: permissionForce,
        );
      }
    } catch (e) {
      bool isLocationServiceEnabled =
          await Geolocator.isLocationServiceEnabled();
      if (!isLocationServiceEnabled && permissionForce!) {
        return getFullLocationFromCoordinates(permissionForce: permissionForce);
      }
      return null;
    }
    return null;
  }

  Future<Position?> getLatLong({bool? permissionForce = false}) async {
    try {
      PermissionStatus permissionStatus =
          await Permission.locationWhenInUse.request();
      if (permissionStatus.isGranted) {
        Position position = await Geolocator.getCurrentPosition(
          locationSettings: const LocationSettings(
            accuracy: LocationAccuracy.medium,
            distanceFilter: 10,
          ),
        );
        return position;
      } else if (permissionStatus.isDenied && permissionForce!) {
        return await getLatLong(permissionForce: permissionForce);
      } else if (permissionStatus.isPermanentlyDenied && permissionForce!) {
        await AppSettings.openAppSettings();

        return await getLatLong(permissionForce: permissionForce);
      }
    } catch (e) {
      bool isLocationServiceEnabled =
          await Geolocator.isLocationServiceEnabled();
      if (!isLocationServiceEnabled && permissionForce!) {
        return await getLatLong(permissionForce: permissionForce);
      }
      return null;
    }
    return null;
  }
}
