import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

import '../../../main.dart';
import '../../constants/localfiles.dart';
import '../../routes/route_names.dart';
import '../bottom_tab/bottom_tab_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 1),
      end: const Offset(0, 0),
    ).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOut),
    );

    _fadeAnimation = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeIn),
    );


    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _route();
      }
    });

    _controller.forward();


  }

  void _route() async {
    const millisecondsToSkipSplash = 3;
    Timer(const Duration(milliseconds: millisecondsToSkipSplash), () {




        NavigationServices(context).navigateAndFinish(context,const BottomTabScreen());


    });
  }
  @override
  void dispose() {
    _controller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SlideTransition(
          position: _slideAnimation,
          child: FadeTransition(
            opacity: _fadeAnimation,
            child: SizedBox(
                height: 80,
                width: 80,
                child: Image.asset(Localfiles.appIcon)),
          ),
        ),
      ),
    );
  }
}
