import 'package:flutter/material.dart';

class Size {
  Size._();
  static double getHeight;
  static double getWidth;
  static double scaleTxt;
  static double statusBar;
  static double padding;
}

void getSizeApp(BuildContext context) {
  Size.getHeight = MediaQuery.of(context).size.height;
  Size.getWidth = MediaQuery.of(context).size.width;
  Size.scaleTxt = MediaQuery.of(context).textScaleFactor;
  Size.statusBar = MediaQuery.of(context).padding.top;
  print("getSizeApp Width: " + Size.getWidth.toString());
  print("getSizeApp Height: " + Size.getWidth.toString());
}

class AppColor {
  AppColor._();
  // static Color backgroundColor = Color.fromRGBO(211, 220, 240, 1);

  static Color backgroundColor = Color(0xFFEBF2FA);
  // static Color whiteColor = Colors.white;
  static Color whiteColor = Colors.white;
  static Color colorClipPath2 = Color.fromRGBO(9, 92, 113, 1);
  static Color blackColor = Colors.black;
  static Color colorClipPath = Color(0xFF6184D8);
  static Color colorBlue156 = Color.fromRGBO(44, 156, 162, 1);
  static Color alerBtnColor = Color(0xff00bfa5);
  // static Color selectContainerColor =
  //     Color.fromRGBO(255, 79, 76, 1).withOpacity(0.6);
  static Color selectColor = Color(0xff556F7A);
}

const MaterialColor primarySwatch = const MaterialColor(
  0xFFFFFFFF,
  const <int, Color>{
    50: const Color(0xFF6184D8),
    100: const Color(0xFF6184D8),
    200: const Color(0xFF6184D8),
    300: const Color(0xFF6184D8),
    400: const Color(0xFF6184D8),
    500: const Color(0xFF6184D8),
    600: const Color(0xFF6184D8),
    700: const Color(0xFF6184D8),
    800: const Color(0xFF6184D8),
    900: const Color(0xFF6184D8),
  },
);

class StyleText {
  StyleText._();

  static TextStyle header24BWhite = TextStyle(
    color: Colors.white,
    fontSize: 24.0 * Size.scaleTxt,
    fontWeight: FontWeight.bold,
  );

  static TextStyle header24BWhitew400 = TextStyle(
    color: Colors.white,
    fontSize: 24.0 * Size.scaleTxt,
    fontWeight: FontWeight.w400,
  );

  static TextStyle header24Black = TextStyle(
    color: Colors.black,
    fontSize: 24.0 * Size.scaleTxt,
    fontWeight: FontWeight.bold,
  );

  static TextStyle header24Red = TextStyle(
    color: Colors.red,
    fontSize: 24.0 * Size.scaleTxt,
    fontWeight: FontWeight.bold,
  );

  static TextStyle header24GreenMixBlue = TextStyle(
    color: Color.fromRGBO(44, 156, 162, 1),
    fontSize: 24.0 * Size.scaleTxt,
    fontWeight: FontWeight.bold,
  );

  static TextStyle header24BlackW400 = TextStyle(
    color: Colors.black,
    fontSize: 24.0 * Size.scaleTxt,
    fontWeight: FontWeight.w400,
  );

  static TextStyle styleTitle = TextStyle(
      color: Color(0xff3da4ab),
      fontSize: 30.0,
      fontWeight: FontWeight.bold,
      fontFamily: 'RobotoMono');

  static TextStyle styleDescription = TextStyle(
      color: Colors.white,
      fontSize: 20.0,
      fontStyle: FontStyle.italic,
      fontWeight: FontWeight.w500,
      fontFamily: 'Raleway');

  static TextStyle header20White = TextStyle(
    color: Colors.white,
    fontSize: 20.0 * Size.scaleTxt,
    fontWeight: FontWeight.bold,
  );

  static TextStyle header20Whitew500 = TextStyle(
    color: Colors.white,
    fontSize: 20.0 * Size.scaleTxt,
    fontWeight: FontWeight.w500,
  );

  static TextStyle header20Black = TextStyle(
    color: Colors.black,
    fontSize: 20.0 * Size.scaleTxt,
    fontWeight: FontWeight.bold,
  );

  static TextStyle header20BlackW500 = TextStyle(
    color: Colors.black,
    fontSize: 20.0 * Size.scaleTxt,
    fontWeight: FontWeight.w500,
  );

  static TextStyle header20BlackNormal = TextStyle(
    color: Colors.black,
    fontSize: 20.0 * Size.scaleTxt,
    // fontWeight: FontWeight.w500,
  );

  static TextStyle price20Red = TextStyle(
    color: Colors.red,
    fontSize: 20.0 * Size.scaleTxt,
    fontWeight: FontWeight.w500,
  );

  static TextStyle subhead18White500 = TextStyle(
    color: Colors.white,
    fontSize: 18.0 * Size.scaleTxt,
    fontWeight: FontWeight.w500,
  );
  static TextStyle subhead18Black500 = TextStyle(
    color: Colors.black,
    fontSize: 18.0 * Size.scaleTxt,
    fontWeight: FontWeight.w500,
  );

  static TextStyle subhead18Black87w400 = TextStyle(
    color: Colors.black87,
    fontSize: 18.0 * Size.scaleTxt,
    fontWeight: FontWeight.w400,
  );
  static TextStyle subhead18Red87w400 = TextStyle(
    color: Colors.red,
    fontSize: 18.0 * Size.scaleTxt,
    fontWeight: FontWeight.w400,
  );

  static TextStyle subhead18Grey400 = TextStyle(
    color: Colors.grey,
    fontSize: 18.0 * Size.scaleTxt,
    fontWeight: FontWeight.w500,
  );

  static TextStyle subhead18GreenMixBlue = TextStyle(
    color: Color.fromRGBO(44, 156, 162, 1),
    fontSize: 18.0 * Size.scaleTxt,
    fontWeight: FontWeight.w500,
  );

  static TextStyle subhead16White500 = TextStyle(
    color: Colors.white,
    fontSize: 16.0 * Size.scaleTxt,
    fontWeight: FontWeight.w500,
  );

  static TextStyle subhead16Black500 = TextStyle(
    color: Colors.black,
    fontSize: 16.0 * Size.scaleTxt,
    fontWeight: FontWeight.w500,
  );
  static TextStyle subhead16Black = TextStyle(
    color: Colors.black,
    fontSize: 16.0 * Size.scaleTxt,
    fontWeight: FontWeight.normal,
  );

  static TextStyle subhead16Red500 = TextStyle(
    color: Colors.red,
    fontSize: 16.0 * Size.scaleTxt,
    fontWeight: FontWeight.w500,
  );

  static TextStyle subhead16GreenMixBlue = TextStyle(
    color: Color.fromRGBO(44, 156, 162, 1),
    fontSize: 16.0 * Size.scaleTxt,
    fontWeight: FontWeight.w500,
  );

  static TextStyle subhead14GreenMixBlue = TextStyle(
    color: Color.fromRGBO(44, 156, 162, 1),
    fontSize: 14.0 * Size.scaleTxt,
    fontWeight: FontWeight.w500,
  );

  static TextStyle content14WhiteNormal = TextStyle(
    color: Colors.white,
    fontSize: 14.0 * Size.scaleTxt,
    fontWeight: FontWeight.normal,
  );

  static TextStyle content14White400 = TextStyle(
    color: Colors.white,
    fontSize: 14.0 * Size.scaleTxt,
    fontWeight: FontWeight.w400,
  );

  static TextStyle content14Black400 = TextStyle(
    color: Colors.black,
    fontSize: 14.0 * Size.scaleTxt,
    fontWeight: FontWeight.w400,
  );

  static TextStyle content14Grey400 = TextStyle(
    color: Colors.grey[400],
    fontSize: 14.0 * Size.scaleTxt,
    fontWeight: FontWeight.w400,
  );

  static TextStyle content14White60w400 = TextStyle(
    color: Colors.white60,
    fontSize: 14.0 * Size.scaleTxt,
    fontWeight: FontWeight.w400,
  );
}
