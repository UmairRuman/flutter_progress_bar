import 'dart:math';

import 'package:custom_progress_bar/progressBarWidget.dart';
import 'package:flutter/material.dart';

class MainLayout extends StatefulWidget {
  const MainLayout({super.key});

  @override
  State<MainLayout> createState() => _MainLayoutState();
}

class _MainLayoutState extends State<MainLayout> {
  // If the user want to show progress bar on initState then he can set this bool true on initState
  //So there is no need to give this flag in onTap function only
  bool isClickedOnBar = false;
//User can give this onTap function as button onTap callBack
  void onTap() {
    setState(() {
      isClickedOnBar = true;
    });
  }

  @override
  void initState() {
    super.initState();
    isClickedOnBar = true;
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ///////////////////////////////////////Important Note/////////////////////////////////
          //User should make it in sepreated widget so the whole widget tree should not rebuilt
          ProgressBarWidget(
            size: const Size(200, 200),
            onTap: onTap,
            isClickedOnbar: isClickedOnBar,
            isUseGradient: false,
            activeBorders: true,
            borderColor: Colors.green,
            progressBarColor: Colors.black,
            startAngle: pi,
          ),
        ],
      ),
    );
  }
}
