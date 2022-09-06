import 'package:creditcard_manager/pages/detail.dart';
import 'package:creditcard_manager/pages/home.dart';
import 'package:creditcard_manager/pages/loading.dart';
import 'package:creditcard_manager/pages/test.dart';
import 'package:flutter/material.dart';
import 'package:creditcard_manager/pages/welcome.dart';

void main() => runApp( MaterialApp(
  home:const Loading(),
  theme: ThemeData(
    primaryColor: Colors.pinkAccent,
    accentColor:Colors.pinkAccent,
  ),
));