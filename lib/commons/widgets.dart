import 'dart:async';

import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:room_finder_flutter/commons/colors.dart';

Widget text({
  required String txt,
  double size = 12,
  final Color? color = primaryWhiteColor,
  final FontWeight? fontWeight,
  final TextAlign? textAlign,
  final Color? backgroundColor,
}) {
  return Text(
    txt,
    textAlign: textAlign,
    style: TextStyle(
        backgroundColor: backgroundColor,
        color: color,
        fontSize: size,
        fontWeight: fontWeight),
  );
}

Widget customButton({
  final GestureTapCallback? onTap,
  String txt = "",
  double? wid,
  double? high = 40,
  final Color? color = primaryBlackColor,
  final double? elevation = 10,
  final BoxBorder? border,
  final Color? txtcolor = primaryWhiteColor,
}) {
  return InkWell(
    onTap: onTap,
    child: Card(
      elevation: elevation,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(45)),
      child: Container(
        height: high,
        width: wid,
        alignment: Alignment.center,
        decoration: BoxDecoration(
            border: border,
            color: color,
            borderRadius: BorderRadius.circular(45)),
        child: Text(txt, style: TextStyle(color: txtcolor)),
      ),
    ),
  );
}

Widget customButton_1({
  final GestureTapCallback? onTap,
  String txt = "",
  final Color? color = primaryBlackColor,
  final double? elevation = 10,
  final BoxBorder? border,
  final Color? txtcolor = primaryWhiteColor,
}) {
  return InkWell(
    onTap: onTap,
    child: Card(
      elevation: elevation,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Container(
        alignment: Alignment.center,
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
            border: border,
            color: color,
            borderRadius: BorderRadius.circular(15)),
        child: Text(txt, style: TextStyle(color: txtcolor)),
      ),
    ),
  );
}

PreferredSizeWidget careaAppBarWidget(BuildContext context,
    {String? titleText, Widget? actionWidget, Widget? actionWidget2}) {
  return AppBar(
    backgroundColor: context.scaffoldBackgroundColor,
    leading: IconButton(
      icon: Icon(Icons.arrow_back, color: context.iconColor),
      onPressed: () {
        Navigator.pop(context);
      },
    ),
    actions: [actionWidget ?? SizedBox(), actionWidget2 ?? SizedBox()],
    title: Text(titleText ?? "", style: boldTextStyle(size: 18)),
    elevation: 0.0,
  );
}

class MyWidget extends StatelessWidget {
  final Widget child;
  final EdgeInsets margin;
  final double height;
  final double width;

  const MyWidget(
      {super.key,
      required this.child,
      required this.margin,
      required this.height,
      required this.width});

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;
    return Container(
      width: screenWidth * width,
      height: screenHeight * height,
    );
  }
}
