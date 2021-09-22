import 'dart:html';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';

import '../widgets/grid_details.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_appfp/provider/product.dart';
import 'package:shop_appfp/provider/products.dart';
import '../widgets/product_items.dart';

class ProductDetails extends StatefulWidget {

  final FirebaseApp app;

  ProductDetails({Key key, this.app}) : super(key: key);
  static const  routeName='/product_details_screen';

  @override
  _ProductDetailsState createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  final referenceDatabase= FirebaseDatabase.instance;
  @override
  Widget build(BuildContext context) {
    final product = Provider.of<Product>(context, listen: false);
    final productId=ModalRoute.of(context).settings.arguments as String;
    final loadedProduct=Provider.of<Products>(context,listen: false).findById(productId);
    return GridTile(
      child: GestureDetector(
        child: Hero(
            tag: product.id,
            child: FadeInImage(
              image: NetworkImage(product.imageUrl),
              fit: BoxFit.cover,
            )),
      ),
      footer: GridTileBar(
        backgroundColor: Colors.black87,
       title:Text(product.id .toString()),
        subtitle: Text(product.price .toString()),
      ),
    );
  }
}





