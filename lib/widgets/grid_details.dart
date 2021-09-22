import 'package:flutter/material.dart';
import 'package:shop_appfp/provider/products.dart';
import 'package:provider/provider.dart';
import 'package:shop_appfp/screens/product_details_screen.dart';
import 'package:shop_appfp/widgets/product_items.dart';
import '../screens/product_view.dart';
import '../screens/product_view.dart';
class GridDetails extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    final productData=Provider.of<Products>(context);
    final products=productData.products;

    return GridView.builder(
      padding: EdgeInsets.all(6.00),
      itemCount:products.length,
      itemBuilder:(ctx,i)=>ChangeNotifierProvider.
      value(
        child:ProductDetails(),
        value:products[i],

      ),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(

        crossAxisCount: 2,
        childAspectRatio: 3/2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),);
  }
}
