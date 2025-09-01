// import 'dart:async';
// import 'package:flutter/material.dart';
//
// import '../../constants/localfiles.dart';
// import '../../routes/route_names.dart';
// import '../bottom_tab/bottom_tab_screen.dart';
//
//
// class SplashScreen extends StatefulWidget {
//   const SplashScreen({super.key});
//
//   @override
//   State<SplashScreen> createState() => _SplashScreenState();
// }
//
// class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {
//   late AnimationController _controller;
//   late Animation<double> _scaleAnimation;
//   late Animation<double> _fadeAnimationLogo;
//   late Animation<double> _fadeAnimationText;
//
//   @override
//   void initState() {
//     super.initState();
//
//     _controller = AnimationController(
//       vsync: this,
//       duration: const Duration(seconds: 2),
//     );
//
//     // حركة اللوجو (تكبير وتلاشي)
//     _scaleAnimation = Tween<double>(begin: 0.8, end: 1.0).animate(
//       CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic),
//     );
//     _fadeAnimationLogo = Tween<double>(begin: 0.0, end: 1.0).animate(
//       CurvedAnimation(parent: _controller, curve: const Interval(0.0, 0.7)), // يظهر في أول 70% من الوقت
//     );
//
//     // حركة النص (تلاشي متأخر)
//     _fadeAnimationText = Tween<double>(begin: 0.0, end: 1.0).animate(
//       CurvedAnimation(parent: _controller, curve: const Interval(0.5, 1.0)), // يظهر في آخر 50% من الوقت
//     );
//
//     _controller.forward();
//
//     // الانتقال للشاشة التالية بعد انتهاء الأنيميشن
//     Timer(const Duration(seconds: 3), () {
//       NavigationServices(context).navigateAndFinish(context, const BottomTabScreen());
//     });
//   }
//
//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Theme.of(context).primaryColor,
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             FadeTransition(
//               opacity: _fadeAnimationLogo,
//               child: ScaleTransition(
//                 scale: _scaleAnimation,
//                 child: SizedBox(
//                   height: 120,
//                   width: 120,
//                   child: Image.asset(Localfiles.appIcon),
//                 ),
//               ),
//             ),
//             const SizedBox(height: 24),
//             FadeTransition(
//               opacity: _fadeAnimationText,
//               child: const Text(
//                 "سي عمر",
//                 style: TextStyle(
//                   color: Colors.white,
//                   fontSize: 28,
//                   fontWeight: FontWeight.bold,
//                   letterSpacing: 1.2,
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:mr_omar/modules/login/logic/auth_cubit/auth_cubit.dart';
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
  late Animation<double> _textFadeAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1800),
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

    _textFadeAnimation = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(
      CurvedAnimation(parent: _controller, curve: const Interval(0.5, 1.0, curve: Curves.easeIn)),
    );

    _controller.forward();

    AuthCubit.get().getSettings(context: context);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF001F3F), Color(0xFF0074D9)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SlideTransition(
                position: _slideAnimation,
                child: FadeTransition(
                  opacity: _fadeAnimation,
                  child: SizedBox(
                    height: 120,
                    width: 120,
                    child: Image.asset(Localfiles.appIcon),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              FadeTransition(
                opacity: _textFadeAnimation,
                child: Text(
                  "سي عمر",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.5,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              FadeTransition(
                opacity: _textFadeAnimation,
                child: Text(
                  "تجربتك الذكية تبدأ من هنا",
                  style: TextStyle(
                    color: Colors.grey[300],
                    fontSize: 14,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
