import 'package:animation_app/screens/burgerComp.dart';
import 'package:flutter/material.dart';

class MainBurger extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height *0.45,
      child: Stack(
        children: [
          Hero(
            tag: 'bgTag',
            child: Material(
              color: Colors.transparent,
              child: Container(
                width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height *0.45,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/geenBckground.png'),
                    fit: BoxFit.fill
                  )
                ),
              ),
            ),
          ),
    
          Center(child: Hero(
              tag: 'main_burger_tag',
              child: Image.asset('assets/images/main_burger.png')),)
    
        ],
      ),
    );
  }
}
