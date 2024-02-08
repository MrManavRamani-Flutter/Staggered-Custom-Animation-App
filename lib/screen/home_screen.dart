import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  late AnimationController animationController;

  late Animation<Offset> animationOffset;
  late Animation<double> animationWidth;
  late Animation<double> animationHeight;
  late Animation<double> animationBorderRadius;
  late Animation<Color?> animationColor;

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
      lowerBound: 0,
      upperBound: 1,
    );

    animationWidth = Tween<double>(begin: 50, end: 250).animate(
      CurvedAnimation(
        parent: animationController,
        curve: const Interval(0.0, 0.25, curve: Curves.easeInOut),
      ),
    );

    animationHeight = Tween<double>(begin: 50, end: 250).animate(
      CurvedAnimation(
        parent: animationController,
        curve: const Interval(0.25, 0.55, curve: Curves.easeInOut),
      ),
    );

    animationOffset = Tween<Offset>(
      begin: const Offset(0.5, 0.5),
      end: const Offset(0, 3),
    ).animate(
      CurvedAnimation(
        parent: animationController,
        curve: const Interval(0.25, 0.55, curve: Curves.easeInOut),
      ),
    );

    animationBorderRadius = Tween<double>(begin: 0, end: 250).animate(
      CurvedAnimation(
        parent: animationController,
        curve: const Interval(0.55, 0.80, curve: Curves.easeInOut),
      ),
    );

    animationColor = ColorTween(
            begin: Colors.greenAccent.withOpacity(0.8),
            end: Colors.pinkAccent.withOpacity(0.5))
        .animate(
      CurvedAnimation(
        parent: animationController,
        curve: const Interval(0.80, 1.0, curve: Curves.easeInOut),
      ),
    );

    animationController
        .forward()
        .then((value) => animationController.reverse());
    animationController.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment(0.8, 1),
          colors: <Color>[
            Color(0xff1f005c),
            Color(0xff5b0060),
            Color(0xff870160),
            Color(0xffac255e),
            Color(0xffca485c),
            Color(0xffe16b5c),
            Color(0xfff39060),
            Color(0xffffb56b),
          ], // Gradient from https://learnui.design/tools/gradient-generator.html
          tileMode: TileMode.mirror,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.white.withOpacity(0.2),
          elevation: 0,
          title: const Text(
            'Staggered Animation',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              InkWell(
                onTap: () {
                  animationController.reverse();
                },
                onDoubleTap: () {
                  animationController.stop();
                },
                onLongPress: () {
                  animationController.repeat();
                },
                child: Container(
                  height: animationHeight.value,
                  width: animationWidth.value,
                  alignment: Alignment.bottomCenter,
                  margin:
                      EdgeInsets.only(bottom: animationOffset.value.dy * 100),
                  decoration: BoxDecoration(
                    color: animationColor.value,
                    border: Border.all(
                        color: Colors.black.withOpacity(0.2), width: 8),
                    borderRadius:
                        BorderRadius.circular(animationBorderRadius.value),
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
