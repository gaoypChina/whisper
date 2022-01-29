// material
import 'package:flutter/material.dart';
// package
import 'package:google_fonts/google_fonts.dart';
// constants
import 'package:whisper/constants/colors.dart';

ThemeData lightThemeData(BuildContext context) {
  return ThemeData.light().copyWith(
    primaryColor: kPrimaryColor,
    highlightColor: kTertiaryColor,
    focusColor: Colors.black,
    scaffoldBackgroundColor: kBackgroundColor,
    // appBarTheme: AppBarTheme(),
    iconTheme: IconThemeData(color: kContentColorLightTheme),
    textTheme: GoogleFonts.inconsolataTextTheme(
      Theme.of(context).textTheme
    ).apply(bodyColor: kContentColorLightTheme) ,
    // or .robotoMono
    colorScheme: ColorScheme.light(
      primary: kPrimaryColor,
      secondary: kSecondaryColor,
      error: kErrorColor
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: kBackgroundColor,
      selectedItemColor: kContentColorLightTheme.withOpacity(0.7),
      unselectedItemColor: kContentColorLightTheme.withOpacity(0.32),
      selectedIconTheme: IconThemeData(color: kTertiaryColor),
      showUnselectedLabels: true,
    ),
  );
}

ThemeData darkThemeData(BuildContext context){
  return ThemeData.dark().copyWith(
    primaryColor: kTertiaryColor,
    highlightColor: kPrimaryColor,
    focusColor: Colors.white,
    scaffoldBackgroundColor: kContentColorLightTheme,
    // appBarTheme: AppBar
    appBarTheme: AppBarTheme(color: kTertiaryColor),
    iconTheme: IconThemeData(color: kContentColorDarkTheme),
    textTheme: GoogleFonts.inconsolataTextTheme(
      Theme.of(context).textTheme
    ).apply(bodyColor: kContentColorDarkTheme) ,
    // or .robotoMono
    colorScheme: ColorScheme.dark().copyWith(
      primary: kTertiaryColor,
      secondary: kQuaternaryColor,
      error: kErrorColor,
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: kContentColorLightTheme,
      selectedItemColor: Colors.white70,
      unselectedItemColor: kContentColorDarkTheme.withOpacity(0.32),
      selectedIconTheme: IconThemeData(color: kPrimaryColor),
      showUnselectedLabels: true,
    ),
  );
}