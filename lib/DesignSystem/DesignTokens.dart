import 'package:flutter/material.dart';

//COLORS

colorBrandPrimary() {

  // if(globalPlanType == "MASTER"){
  //   return globalPrimaryColor;
  // } else {
    return Colors.red;
  // }
}

colorNeutralHighPure(){
  return Color(0xffFFFFFF);
}

colorNeutralHighDark(){
  return Color(0xffE4E4E4);
}

colorNeutralLowPure(){
  return Color(0xff000000);
}

//CORNER RADIUS
borderRadiusNone() {
  return BorderRadius.circular(0);
}

borderRadiusSmall() {
  return BorderRadius.circular(4);
}

borderRadiusMedium() {
  return BorderRadius.circular(8);
}

borderRadiusCircular(){
  return BorderRadius.circular(500);
}

//FONT SIZE

fontSizeXXS() {
  return 12.0;
}

fontSizeXS() {
  return 26.0;
}

fontSizeSM() {
  return 20.0;
}

fontSizeMD(){
  return 20.0;
}
fontSizeLG() {
  return 32.0;
}
