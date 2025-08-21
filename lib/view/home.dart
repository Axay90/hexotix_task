import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hexotix_task/view/card.dart';
import 'package:hexotix_task/view/products_page.dart';

import 'favourite.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    const ProductsPage(),
    const CartPage(),
  ];
  final List<String> appbarTitle = [
    "Products",
    "Cart",
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xfff6e7f2), Color(0xfff8e9f7)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Scaffold(
        extendBody: true,
        appBar: AppBar(
          title: Text(appbarTitle[_currentIndex]),
          actions: [
            IconButton(
              icon: const Icon(Icons.favorite),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const FavoritesPage()),
                );
              },
            ),
          ],
        ),
        body: _pages[_currentIndex],
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20).r,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(25).r,
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
              child: Container(
                height: 55.h,
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.4),
                  borderRadius: BorderRadius.circular(25),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            _currentIndex = 0;
                          });
                        },
                        child: Container(
                          color: Colors.transparent,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.store,
                                color: _currentIndex == 0
                                    ? Colors.white
                                    : Colors.white70,
                                size: 24,
                              ),
                              SizedBox(height: 4.h),
                              Text(
                                "Products",
                                style: TextStyle(
                                  color: _currentIndex == 0
                                      ? Colors.white
                                      : Colors.white70,
                                  fontSize: 12.sp,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            _currentIndex = 1;
                          });
                        },
                        child: Container(
                          color: Colors.transparent,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.shopping_cart,
                                color: _currentIndex == 1
                                    ? Colors.white
                                    : Colors.white70,
                                size: 24.h,
                              ),
                              SizedBox(height: 4.h),
                              Text(
                                "Cart",
                                style: TextStyle(
                                  color: _currentIndex == 1
                                      ? Colors.white
                                      : Colors.white70,
                                  fontSize: 12.sp,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
