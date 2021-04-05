import 'package:flutter/material.dart';

const double kDefaultPadding = 20.0;

const ContinuousRectangleBorder kAppBarShape = ContinuousRectangleBorder(
  borderRadius: const BorderRadius.only(
    bottomLeft: Radius.circular(10.0),
    bottomRight: Radius.circular(10.0),
  ),
);

const kButtonColor = Color(0xFF8A2222);
const kTextColor = Color(0xFFB1B1B1);
const kPrimaryColor = Color(0xFF212121);
const kBackgroundColor = Color(0xFF121212);
const kWhiteTextColor = Colors.white;

const kTextButtonStyle = TextStyle(color: kWhiteTextColor, fontSize: 20);

BoxDecoration kListTileSelected = BoxDecoration(
    color: Color(0xFF8A2222).withOpacity(0.5),
    borderRadius: BorderRadius.all(Radius.circular(16)));

TextStyle kListTileTextStyle =
    TextStyle(fontWeight: FontWeight.bold, fontSize: 20);
