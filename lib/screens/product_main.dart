import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:shop_appfp/screens/product_view.dart';
import '../widgets/products_grid.dart';

class Product_MainScreen extends StatefulWidget {
  final FirebaseApp app;

  const Product_MainScreen({Key key, this.app}) : super(key: key);

  @override
  _Product_MainScreenState createState() => _Product_MainScreenState();
}

class _Product_MainScreenState extends State<Product_MainScreen> {
  final referenceDatabase= FirebaseDatabase.instance;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            title: Text('My Shop'),
          ),
          body: Center(
            child:
           TextButton(
                style: TextButton.styleFrom(
                  padding: const EdgeInsets.all(16.0),
                  primary: Colors.blue,
                  textStyle: const TextStyle(fontSize: 100),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) =>Product_ViewScreen()),
                  );

                },
                child: const Text('Go To Shop'),

            ),
          ),
          ),
    );
  }
}
