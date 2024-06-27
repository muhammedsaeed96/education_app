import 'package:education_app/src/core/enum.dart';
import 'package:flutter/foundation.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';

class UrlLauncherHelper {
  //check the url type Facebook,whatsapp,etc
  static void launchUrlByType(String val, LinkType type) async {
    switch (type) {
      case LinkType.phone:
        try {
          launchUrlString("tel://$val");
        } catch (_) {
          debugPrint('could not found this phone');
        }
        break;
      case LinkType.whatsapp:
        final whatsappUrl = Uri.parse(

          'https://api.whatsapp.com/send/?phone=$val',
        );
        _launchUrl(whatsappUrl);
        break;
      case LinkType.link:
        final facebookUrl = Uri.parse(val);
        _launchUrl(facebookUrl);
        break;
    }
  }

  //to launch url
  static Future<void> _launchUrl(Uri uri) async {
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      debugPrint('Could not launch $uri');
    }
  }
}
