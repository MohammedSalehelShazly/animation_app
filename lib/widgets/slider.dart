import 'package:flutter/material.dart';

import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';

import '../staticVars.dart';

class SliderCatg extends StatelessWidget {
  const SliderCatg();
  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
          options: CarouselOptions(
            autoPlay: true,
            autoPlayAnimationDuration: Duration(seconds: 1),
            aspectRatio: 16/9,
            enlargeCenterPage: true,
          ),
          items: List.generate(staticVars.sliderImages.length, (index) => Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(staticVars.sliderImages[index]),
                fit: BoxFit.cover
              )
            ),
          )),
        );
  }
}



