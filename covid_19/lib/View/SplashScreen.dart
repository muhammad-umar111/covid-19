import 'dart:async';
import 'dart:math';

import 'package:covid_19/View/WorldStatesScreen.dart';
import 'package:flutter/material.dart';
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});
  static const pageName='/SplashScreen';

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>  with TickerProviderStateMixin{
  late final AnimationController _animationController;
  @override
  void initState() {
    super.initState();
    _animationController=AnimationController(
      duration: const Duration(seconds: 3),
      vsync:this);
       Timer(const Duration(seconds: 4), () {
        Navigator.pushReplacement(context,MaterialPageRoute(builder: (context) {
          return const WorldStatesScreen();
        },));
        });
  }
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
   
  }
 @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    final height=MediaQuery.sizeOf(context).height;
    return Scaffold(
      backgroundColor: Color.fromARGB(66, 99, 97, 97),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            AnimatedBuilder(animation:_animationController..repeat(), builder: (context, child) {
            return Transform.rotate(angle:_animationController.value*2*pi ,
            child:Center(child: SizedBox(
              width: 200,
              height: 200,
             child: Image.asset('assets/images/virus.png'),)),
             );
            },),
             
             SizedBox(height:height*.09 ,),
             const Align(
              alignment: Alignment.center,
              child: Text('Covid-19\nTracker App',textAlign: TextAlign.center,
              style: TextStyle(fontWeight: FontWeight.bold,
              color: Colors.white,
              fontSize: 25),),
             )
          ],
        )),
    );
  }
}