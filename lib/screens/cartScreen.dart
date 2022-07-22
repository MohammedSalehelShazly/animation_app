import 'package:animation_app/providerPage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CartScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: Provider.of<ShoppingCart>(context).shoppingCartItems.length,
          itemBuilder: (context ,index)
              => Container(
                height: MediaQuery.of(context).size.height *0.2,
                width: MediaQuery.of(context).size.width*0.95,
                alignment: Alignment.topLeft,
                child: Text(
                  Provider.of<ShoppingCart>(context).shoppingCartItems[index]['price'] + ' \$',
                  style: TextStyle(fontWeight: FontWeight.bold ,shadows: [BoxShadow(blurRadius: 20 ,spreadRadius: 5)]),

                ),
                decoration: BoxDecoration(
                  image: DecorationImage(
                      image: NetworkImage(Provider.of<ShoppingCart>(context).shoppingCartItems[index]['img']),
                      fit: BoxFit.cover
                  ),
                ),
              )
      ),
    );
  }
}
