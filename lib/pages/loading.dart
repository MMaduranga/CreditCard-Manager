import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:cred_manager/pages/home.dart';
import 'package:flutter/material.dart' hide BoxDecoration, BoxShadow;
import 'package:flutter_inset_box_shadow/flutter_inset_box_shadow.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';


class Loading extends StatefulWidget {
  const Loading({Key? key}) : super(key: key);

  @override
  State<Loading> createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {
  bool internet = false;
  Color appbarColor = Colors.white;
  String appbarText = "";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    var subscription = Connectivity()
        .onConnectivityChanged
        .listen((ConnectivityResult result) {
      internet = result ==ConnectivityResult.mobile || result ==ConnectivityResult.wifi;
      setState(() {
        internetCheck();
      });
    });
    setState(() {
      internetCheck();
    });
  }

  void delayLoading() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => const Home()));
  }

  void internetCheck() async {
    await Future.delayed(const Duration(seconds: 2));
    if (internet == true) {
      delayLoading();
    } else {
      appbarColor = Colors.red;
      appbarText = "No internet Connection!";
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: appbarColor,
        elevation: 0,
        title: Text(appbarText),
      ),
      body: Container(
        color: Colors.white,
        child: Center(
          child: popupContainer(
              150,
              150,
              const SpinKitDoubleBounce(
                color: Colors.white,
                size: 100.0,
              )),
        ),
      ),
    );
  }

  Widget popupContainer(double dblHeight, double dblWidth, Widget cont,
      {double radius = 100.0}) {
    return Container(
      height: dblHeight,
      width: dblWidth,
      decoration: BoxDecoration(
        boxShadow: const [
          BoxShadow(
              blurRadius: 5.0,
              offset: Offset(7, 7),
              color: Color(0xFFA7A9AF),
              inset: false),
          BoxShadow(
            blurRadius: 5,
            offset: Offset(-7, -7),
            color: Colors.white,
            inset: false,
          ),
        ],
        color: Colors.lightGreenAccent.shade700,
        borderRadius: BorderRadius.circular(radius),
      ),
      child: cont,
    );
  }
}
