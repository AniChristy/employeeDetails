
import 'package:anitask/Helper/Colors.dart';
import 'package:flutter/material.dart';
import 'dart:async';


import '../router.dart';


void main(){
  runApp(const MaterialApp(
    home: SplashPage(),
  ));
}

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body:Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Spacer(),
            Center(
              child: Icon(Icons.favorite,size: 200),
            ),
            Text('Demo',style: TextStyle(
              fontSize: 48,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),),
            SizedBox(height: 5,),
            Text('Version 1.0',style: TextStyle(color: Colors.black,
                fontSize: 18),),
            Spacer(),
            Text(
              "Powered by",
              style: TextStyle(
                  fontSize: 13,
                  color: Color(0xFF676767)
              ),
            ),
            SizedBox(
              height: 5.0,
            ),
            Text(
              "XYZ Productions",
              style: TextStyle(
                  color: Color(0xFF3c3c3c)
              ),
            ),
            SizedBox(
              height: 12.0,
            ),

          ],)
    );
  }

  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 3),
            () =>
            Navigator.pushNamedAndRemoveUntil(context, AppRoutes.homeScreen, (route) => false)

    );
  }

}
