import 'package:animation_app/screens/burger_slices.dart';
import 'package:flutter/material.dart';

class MainBurger extends StatelessWidget {
  const MainBurger({this.bgHigh});
  final double bgHigh;
  @override
  Widget build(BuildContext context) {
    return bgHigh == null
      ? const SizedBox()
      :
    SizedBox(
      width: MediaQuery.of(context).size.width,
      height: bgHigh,
      child: Stack(
        children: [
          Hero(
            tag: 'bgTagX',
            child: Material(
              color: Colors.transparent,
              child: Container(
                width: MediaQuery.of(context).size.width,
                  height: bgHigh,
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
