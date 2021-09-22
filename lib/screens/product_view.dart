

import 'dart:js';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_appfp/provider/favourites.dart';
import 'package:shop_appfp/screens/cart_screen.dart';
import 'package:shop_appfp/screens/favourite_screen.dart';
import '../provider/product.dart';
import '../provider/products.dart';

//Widgets import
import '../widgets/products_grid.dart';
enum Status{Favourites,All}
class Product_ViewScreen extends StatefulWidget {
  final FirebaseApp app;

  Product_ViewScreen({Key key, this.app}) : super(key: key);


  var _showFavourites=false;
var _isLoading=false;
  @override
  _Product_ViewScreenState createState() => _Product_ViewScreenState();
}

class _Product_ViewScreenState extends State<Product_ViewScreen> {
  final referenceDatabase= FirebaseDatabase.instance;
  int _currentIndex = 0;
   List<Map<String, dynamic>> _pages;
   List<Product> get products => null;


  void _changePage(int index) {
    setState(() {
      _currentIndex = index;
    });
  }
  void initState() {
    _pages = [
      {
        'title': 'Products',
        'page': ProductsGrid(false),

      },
      {'title': 'Favourites',
        'page': Favourite_Screen(),

      },

    ];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return  Scaffold(
      appBar: AppBar(
        title: Text(_pages[_currentIndex]['title']),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.card_giftcard_outlined,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => CartScreen()),);

            },
          )
        ],
      ),
      body: _pages[_currentIndex]['page'],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: _changePage,
        backgroundColor: Theme.of(context).primaryColor,
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.white,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.category_outlined),
            label: 'Products',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.star_border_outlined),
            label: 'Favourite',


          ),

        ],
      ),
    );
  }
}
