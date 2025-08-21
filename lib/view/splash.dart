import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hexotix_task/view/home.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  SplashPageState createState() => SplashPageState();
}

class SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    Timer(
        Duration(seconds: 3),
        () => Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => HomePage())));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xfff6e7f2), Color(0xfff8e9f7)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.shopping_bag, size: 100, color: Color(0xFFD2B2F3)),
              SizedBox(height: 15.h),
              Text(
                "ShopEasy",
                style: TextStyle(
                  fontSize: 28.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              SizedBox(height: 5.h),
              Text(
                "Shop Smart, Live Better",
                style: TextStyle(
                  fontSize: 16.sp,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: 15.h),
              CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.black87),
              )
            ],
          ),
        ),
      ),
    );
  }
}
