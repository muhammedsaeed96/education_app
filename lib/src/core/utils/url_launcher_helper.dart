import 'package:flutter/foundation.dart';
import 'package:url_launcher/url_launcher.dart';


enum UrlType { email, phone, facebook, instagram , general}


class UrlLauncherHelper {
  //check the url type Facebook,whatsapp,etc
  static void launchUrlByType(String val, UrlType type) async {
    switch (type) {
      case UrlType.phone:
        final whatsappUrl = Uri.parse(
          'https://api.whatsapp.com/send/?phone=$val',
        );
        _launchUrl(whatsappUrl);
        break;
      case UrlType.email:
        final emailLaunchUri = Uri(
          scheme: 'mailto',
          path: val,
          queryParameters: {'subject': 'alpha', 'body': 'alpha gym'},
        );
        _launchUrl(emailLaunchUri);
        break;
      case UrlType.facebook:
        final facebookUrl = Uri.parse(val);
        _launchUrl(facebookUrl);
        break;
      case UrlType.instagram:
        final instagramUrl = Uri.parse(val);
        _launchUrl(instagramUrl);
        break;
      case UrlType.general:
        _launchUrl(Uri.parse(val));
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
