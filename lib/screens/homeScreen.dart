import 'package:animation_app/screens/cartScreen.dart';
import 'package:animation_app/widgets/gridePrices.dart';
import 'package:animation_app/widgets/mainBrgr.dart';
import 'package:animation_app/widgets/slider.dart';
import 'package:flutter/material.dart';

import 'burgerComp.dart';

class HomeScreen extends StatelessWidget {

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
              Navigator.push(context,
                      MaterialPageRoute(builder: (context) => BurgerComp()))
                  .then((value) => pushPage = true);
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
                  MainBurger(),

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
