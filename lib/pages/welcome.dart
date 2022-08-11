import 'dart:ui';
import 'package:flutter/material.dart';

class Welcome extends StatefulWidget {
  const Welcome({Key? key}) : super(key: key);

  @override
  State<Welcome> createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> {
  // bool buttonbg = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('asset/welcome1.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Container(
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                    blurRadius: 24.0,
                    spreadRadius: 16,
                    color: Colors.black.withOpacity(0.2))
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16.0),
              child: BackdropFilter(
                filter: ImageFilter.blur(
                  sigmaX: 2.0,
                  sigmaY: 2.0,
                ),
                child: Container(
                  margin: const EdgeInsets.only(top: 55.0,bottom: 20.0,left: 20.0,right: 20.0),
                  width: double.infinity,
                  height: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(20.0),
                    border: Border.all(
                      width: 2.0,
                      color: Colors.white.withOpacity(0.3),
                    ),
                  ),
                  child: content(),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Text getTxt(String txt,
          {double fontSize = 40.0, FontWeight weight = FontWeight.w700}) =>
      Text(txt,
          style: TextStyle(
            fontFamily: 'PoppinsSemiBold',
            fontWeight: weight,
            fontSize: fontSize,
            color: Colors.white,
          ));
  Column content() =>
      Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Expanded(
          flex: 4,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              getTxt("We will Manage"),
              getTxt("Your"),
              getTxt("Credits")
            ],
          ),
        ),
        Expanded(
            flex: 3,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 45.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  getTxt("credits is not bad you should",
                      fontSize: 20.0, weight: FontWeight.w500),
                  getTxt("manage it carefully.",
                      fontSize: 22.0, weight: FontWeight.w500),
                ],
              ),
            )),
        Expanded(
          flex: 1,
          child: TextButton(
            onPressed: () {
              setState(() {});
            },
            style: ButtonStyle(
                padding: MaterialStateProperty.all<EdgeInsets>(
                    const EdgeInsets.all(20)),
                foregroundColor:
                    MaterialStateProperty.all(Colors.indigoAccent[700]),
                shape: MaterialStateProperty.all(RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0),
                  side: const BorderSide(color: Colors.white),
                ))),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: getTxt("Get Start".toUpperCase(),
                  fontSize: 25.0, weight: FontWeight.w900),
            ),
          ),
        ),
        const SizedBox(
          height: 20.0,
        ),
      ]);
}
