import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ketabok/home/views/home_view.dart';
import 'package:ketabok/style/my_theme.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<Offset> slideingAnimation;
  late Animation<double> fadeingAnimation;
  @override
  void initState() {
    super.initState();
    controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 2));

    slideingAnimation =
        Tween<Offset>(begin: const Offset(0, -3), end: Offset.zero)
            .animate(controller);

    fadeingAnimation = Tween<double>(begin: 0, end: 1).animate(controller);
    controller.forward();
  }

  @override
  void dispose() {
    super.dispose();

    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Center(
              child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Quran App",
            style: GoogleFonts.poppins(
              color: Colors.white,
              fontSize: 28,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(
            height: 16,
          ),
          Text(
            textAlign: TextAlign.center,
            "Learn Quran and\n Recite once everyday",
            style: GoogleFonts.poppins(
              color: MyTheme.text,
              fontSize: 18,
              fontWeight: FontWeight.normal,
            ),
          ),
          const SizedBox(
            height: 16,
          ),
          Stack(
            clipBehavior: Clip.none,
            children: [
              Container(
                height: 400,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                ),
                child: SvgPicture.asset(
                  "assets/svgs/splashContainer.svg",
                ),
              ),
              Positioned(
                  bottom: 85,
                  left: 32,
                  child: AnimatedBuilder(
                      animation: controller,
                      builder: (context, _) {
                        return FadeTransition(
                          opacity: fadeingAnimation,
                          child: SvgPicture.asset(
                            "assets/svgs/shadow.svg",
                          ),
                        );
                      })),
              Positioned(
                  bottom: 100,
                  left: 10,
                  child: AnimatedBuilder(
                      animation: controller,
                      builder: (context, _) {
                        return SlideTransition(
                            position: slideingAnimation,
                            child: SvgPicture.asset("assets/svgs/quran.svg"));
                      })),
              Positioned(
                bottom: -25,
                left: 50,
                right: 50,
                child: GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const HomeView(),
                    ));
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 40, vertical: 16),
                    decoration: BoxDecoration(
                        color: MyTheme.orangColor,
                        borderRadius: BorderRadius.circular(30)),
                    child: Center(
                      child: Text(
                        "Get Started",
                        style: GoogleFonts.poppins(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: const Color(0xff091945)),
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ],
      ))),
    );
  }
}
