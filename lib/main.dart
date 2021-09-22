import 'dart:convert';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'dart:io';

import 'package:flutter/foundation.dart';
//providers import
import 'package:provider/provider.dart';
import './provider/favourites.dart';
import './provider/product.dart';
import './provider/products.dart';
//screens import

import './screens/product_view.dart';
import './screens/product_main.dart';
import './screens/entry_screen.dart';
//http import
import 'package:http/http.dart' as http;

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: FavouriteNotifier()),
        ChangeNotifierProvider.value(value: Product()),
        ChangeNotifierProvider.value(value: Products()),
      ],
      child: MaterialApp(
        theme: ThemeData(
          fontFamily: 'Lato',
        ),
        //home: Product_ViewScreen(),
        routes: {
          '/': (_) => Entry_Screen(),
        },
      ),
    );
  }
}
