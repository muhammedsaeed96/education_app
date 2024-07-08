import 'package:flutter/cupertino.dart';

class AppSizes {
  static late MediaQueryData _mediaQueryData;
  static late double screenWidth;
  static late double screenHeight;
  static double? defaultSize;
  static Orientation? orientation;

  void init(BuildContext context) {
    _mediaQueryData = MediaQuery.of(context);
    orientation = _mediaQueryData.orientation;
    screenWidth = _isLandScape()
        ? _mediaQueryData.size.height
        : _mediaQueryData.size.width;
    screenHeight = _isLandScape()
        ? _mediaQueryData.size.width
        : _mediaQueryData.size.height;
  }

  bool _isLandScape() {
    return AppSizes.orientation == Orientation.landscape;
  }

  static double length8 = getProportionateScreenHeight(8);
  static double length10 = getProportionateScreenHeight(10);
  static double length12 = getProportionateScreenHeight(12);
  static double length14 = getProportionateScreenHeight(14);
  static double length16 = getProportionateScreenHeight(16);
  static double length18 = getProportionateScreenHeight(18);
  static double length20 = getProportionateScreenHeight(20);
  static double length22 = getProportionateScreenHeight(22);
  static double length24 = getProportionateScreenHeight(24);
  static double length28 = getProportionateScreenHeight(28);
  static double length30 = getProportionateScreenHeight(30);
  static double length32 = getProportionateScreenHeight(32);
  static double length34 = getProportionateScreenHeight(34);
  static double length35 = getProportionateScreenHeight(35);
  static double length36 = getProportionateScreenHeight(36);
  static double length38 = getProportionateScreenHeight(38);
  static double length40 = getProportionateScreenHeight(40);
  static double length42 = getProportionateScreenHeight(42);
  static double length44 = getProportionateScreenHeight(44);
  static double length45 = getProportionateScreenHeight(45);
  static double length46 = getProportionateScreenHeight(46);
  static double length48 = getProportionateScreenHeight(48);
  static double length50 = getProportionateScreenHeight(50);
  static double length52 = getProportionateScreenHeight(52);
  static double length54 = getProportionateScreenHeight(54);
  static double length56 = getProportionateScreenHeight(56);
  static double length58 = getProportionateScreenHeight(58);
  static double length60 = getProportionateScreenHeight(60);
  static double length64 = getProportionateScreenHeight(64);
  static double length68 = getProportionateScreenHeight(68);
  static double length72 = getProportionateScreenHeight(72);
  static double length96 = getProportionateScreenHeight(96);
  static double length120 = getProportionateScreenHeight(120);
  static double length126 = getProportionateScreenHeight(126);
  static double length128 = getProportionateScreenHeight(128);
  static double length132 = getProportionateScreenHeight(132);
  static double length136 = getProportionateScreenHeight(136);
  static double length144 = getProportionateScreenHeight(144);
  static double length148 = getProportionateScreenHeight(148);
  static double length180 = getProportionateScreenHeight(180);
  static double length200 = getProportionateScreenHeight(200);
  static double length204 = getProportionateScreenHeight(204);

  //width
  static double w20 = getProportionateScreenWidth(20);
  static double w26 = getProportionateScreenWidth(26);
  static double w28 = getProportionateScreenWidth(28);
  static double w98 = getProportionateScreenWidth(98);
  static double w58 = getProportionateScreenWidth(58);
}

// Get the proportionate height as per screen size
double getProportionateScreenHeight(double inputHeight) {
  double screenHeight = AppSizes.screenHeight;
  // 844 is the layout height that designer used
  return (inputHeight / 844.0) * screenHeight;
}
// Get the proportionate width as per screen size
double getProportionateScreenWidth(double inputWidth) {
  double screenWidth = AppSizes.screenWidth;
  // 390 is the layout width that designer use
  return (inputWidth / 390.0) * screenWidth;
}

const gap2 = SizedBox(height: 2);
const gap4 = SizedBox(height: 4);
const gap6 = SizedBox(height: 6);
const gap8 = SizedBox(height: 8);
const gap12 = SizedBox(height: 12);
const gap16 = SizedBox(height: 16);
const gap20 = SizedBox(height: 20);
const gap24 = SizedBox(height: 24);
final gap32 = SizedBox(height: getProportionateScreenHeight(32));
final gap28 = SizedBox(height: getProportionateScreenHeight(28));
final gap40 = SizedBox(height: getProportionateScreenHeight(40));
const gapH2 = SizedBox(width: 2);
const gapH4 = SizedBox(width: 4);
const gapH6 = SizedBox(width: 6);
const gapH8 = SizedBox(width: 8);
const gapH10 = SizedBox(width: 10);
const gapH12 = SizedBox(width: 12);
const gapH16 = SizedBox(width: 16);
const gapH20 = SizedBox(width: 20);
const gapH24 = SizedBox(width: 24);

const paddingH24 = EdgeInsets.symmetric(horizontal: 24);
