import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

class ShoppingCart with ChangeNotifier {

  List<Map> shoppingCartItems = [];
  addToCart(Map<String ,dynamic> newItem){
    shoppingCartItems.add(newItem);
    notifyListeners();
  }

}