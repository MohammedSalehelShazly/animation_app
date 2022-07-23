import 'package:animation_app/screens/cartScreen.dart';
import 'package:animation_app/widgets/gridePrices.dart';
import 'package:animation_app/widgets/mainBrgr.dart';
import 'package:animation_app/widgets/slider.dart';
import 'package:flutter/material.dart';

import 'burger_slices.dart';

class HomeScreen extends StatefulWidget {

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin{

  AnimationController controller;
  Animation sizeAnimation;

  void disposeFunc() {
    controller.dispose();
  }
  initStateFunc({bool upSideDown = true}) {
    Future.delayed(Duration(milliseconds: 100), () {
      controller =  AnimationController(vsync: this, duration: Duration(
          milliseconds: upSideDown ? 2000 :700));
      sizeAnimation = Tween<double>(
          begin: upSideDown
            ? bgHigh(context)*.8
            : bgHigh(context),
          end: upSideDown
            ? bgHigh(context)
            : bgHigh(context)*.8
        ).animate(controller);
      controller.addListener(() {
        setState(() {});
      });
      controller.forward();
    });
  }
  @override
  void initState() {
    initStateFunc();
  super.initState();
  
  }
  bgHigh(BuildContext context)=>
    MediaQuery.of(context).size.height *0.45;


  ScrollController homeScrollController = ScrollController();

  bool pushPage = true;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xff97D558),
        body: NotificationListener(
          onNotification: (t) {
            if(homeScrollController.offset <= -100  && pushPage==true){
              disposeFunc();
              Navigator.push(context,
                      MaterialPageRoute(builder: (context) => BurgerSlices()))
                  .then((_){
                    pushPage = true;
                    initStateFunc(upSideDown: false); 
                  });
              pushPage = false;
            }
            return null ;
          },
        
          child: SingleChildScrollView(
            controller: homeScrollController,
            physics: BouncingScrollPhysics(),
            child: Container(
              height: (MediaQuery.of(context).size.height*1.5) - MediaQuery.of(context).padding.top,
              // height: MediaQuery.of(context).size.height *2.5,
              color: Theme.of(context).scaffoldBackgroundColor,
              child: Column(
                children: [
                  MainBurger(bgHigh: sizeAnimation?.value),

                  // SliderCatg(),
                  // Expanded(child: GridePrices())
        
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
