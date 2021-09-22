import 'dart:html';
import 'package:flutter/material.dart';
import 'package:shop_appfp/provider/products.dart';
import 'package:provider/provider.dart';
import 'package:shop_appfp/widgets/product_items.dart';
import '../screens/favourite_screen.dart';
class ProductsGrid extends StatelessWidget {
  final bool showFavourites;

  const ProductsGrid(this.showFavourites);
  @override
  Widget build(BuildContext context) {
    final productData=Provider.of<Products>(context);
    final products=showFavourites?productData.favouriteProducts:productData.products;

    return GridView.builder(
      padding: EdgeInsets.all(6.00),
      itemCount:products.length,
      itemBuilder:(ctx,i)=>ChangeNotifierProvider.
      value(
        child:Favourite_Screen(),
        value:products[i],

      ),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(

        crossAxisCount: 2,
        childAspectRatio: 4/2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),);
  }
}
