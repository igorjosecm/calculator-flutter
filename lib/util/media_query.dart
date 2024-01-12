import 'package:flutter/material.dart';

double getButtonWidth(BuildContext context) {
  double screenWidth = MediaQuery.of(context).size.width;
  bool isLandscape =
      MediaQuery.of(context).orientation == Orientation.landscape;

  if (isLandscape) {
    return 60;
  } else {
    if (screenWidth < 380) {
      return 70;
    } else if (screenWidth < 800) {
      return 76;
    } else {
      return 90;
    }
  }
}

double getButtonHeight(BuildContext context) {
  double screenWidth = MediaQuery.of(context).size.width;
  bool isLandscape =
      MediaQuery.of(context).orientation == Orientation.landscape;

  if (isLandscape) {
    return 40;
  } else {
    if (screenWidth < 380) {
      return 70;
    } else if (screenWidth < 800) {
      return 76;
    } else {
      return 90;
    }
  }
}

double getFontSize(BuildContext context) {
  bool isLandscape =
      MediaQuery.of(context).orientation == Orientation.landscape;

  if (isLandscape) {
    return 20;
  } else {
    return 30;
  }
}
