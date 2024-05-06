import 'package:http/http.dart' as http;

const googleMapApiKey = 'AIzaSyB0c8g45YedZEBNuzeFJRxwRhYtDYOl3nk';

class LocationHelper {
  static String generateLocationPreviewImage({
    required double latitude,
    required double longitude,
  }) {
    return '';
  }

  static Future<String> getPlaceAddress({
    required double latitude,
    required double longitude,
  }) async {
    final url =
        'https://maps.googleapis.com/maps/api/geocode/json?latlng=$latitude,$longitude&key=$googleMapApiKey';
    final response = await http.get(Uri.parse(url));
    print(response.body);
    return '';
  }
}
