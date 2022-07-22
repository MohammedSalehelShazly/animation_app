import 'dart:math';

import 'package:animation_app/providerPage.dart';
import 'package:animation_app/staticVars.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class GridePrices extends StatelessWidget {
  String price = ((Random().nextDouble()*20) +10 ).toStringAsFixed(2);
  @override
  Widget build(BuildContext context) {
    return GridView(
      physics: NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
        childAspectRatio: 1/1,
        crossAxisSpacing: 5,
        mainAxisSpacing: 5,
        mainAxisExtent: MediaQuery.of(context).size.height*0.2,
        maxCrossAxisExtent: MediaQuery.of(context).size.height*0.35,
      ),
      children: List.generate(staticVars.burgerImgs.length+staticVars.icCreamImgs.length, (index)

        => Container(
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: NetworkImage(index<= (staticVars.burgerImgs.length-1) ?staticVars.burgerImgs[index] : staticVars.icCreamImgs[index-staticVars.burgerImgs.length] ),
                  fit: BoxFit.cover
              ),
          ),
          alignment: Alignment.topCenter,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  price + ' \$',
                  style: TextStyle(fontWeight: FontWeight.bold ,shadows: [BoxShadow(blurRadius: 20 ,spreadRadius: 5)]),
                ),

                IconButton(
                  icon: Icon(Icons.add_shopping_cart_outlined ,color: Colors.black54,),
                  tooltip: 'add to cart',
                  onPressed:(){
                    Provider.of<ShoppingCart>(context ,listen: false).addToCart({
                      'price' : price,
                      'img' : index<= (staticVars.burgerImgs.length-1) ?staticVars.burgerImgs[index] : staticVars.icCreamImgs[index-staticVars.burgerImgs.length]
                    });
                  },
                )
              ],
            ),
          )
        ),
      ),
    );
  }
}
