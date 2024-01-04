import 'package:url_launcher/url_launcher_string.dart';

class GoogleServices {

  GoogleServices();

  launchMapsUrl(String address) async{
    final String parsed = address.replaceAll(" ", "+");
    final url = 'https://www.google.com/maps/search/?api=1&query=$parsed';
    await launchUrlString(url);
    }
}