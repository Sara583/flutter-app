import 'dart:core';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import '../provider/products.dart';
  class FavouriteNotifier extends ChangeNotifier{
    List<FavouriteNotifier> _myFavourites=[];
    List<FavouriteNotifier>get myFavourites =>_myFavourites;
    void addTofav(FavouriteNotifier Product){
      _myFavourites.add(Product);
      notifyListeners();
    }
  }