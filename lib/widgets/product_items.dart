import 'dart:html';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider/product.dart';
import '../screens/product_details_screen.dart';

class ProductItems extends StatefulWidget {
  @override
  _ProductItemsState createState() => _ProductItemsState();
}

class _ProductItemsState extends State<ProductItems> {


  @override
  Widget build(BuildContext context) {
    final product=Provider.of<Product>(context,listen:false);


    return GridTile(

        child: GestureDetector(
          onDoubleTap:()=> Navigator.of(context).pushNamed(ProductDetails.routeName,arguments:{
            product.id
          })
           ,
        child:Hero(tag: product.id, child:FadeInImage(
          placeholder: AssetImage('assets/images/product-placeholder.png'),
          image:NetworkImage (product.imageUrl),
          fit: BoxFit.cover,
        )) ,

        ),
       footer: GridTileBar(backgroundColor: Colors.black87,
        title: Text(product.title,textAlign: TextAlign.center),


),
      header:GridTileBar(backgroundColor: Colors.black87,
        leading: Consumer<Product>(
          builder: (ctx,product,_)=>IconButton( alignment: Alignment.centerRight,
              icon:
                     Icon(product.isFavourite?Icons.favorite:Icons.favorite_border ,
                       color: Colors.red,




                     ),


            onPressed:(){
            setState(() {
              product.isFavourite=true;

            });


          },
          ),
        ),


          ),
        );


  }
}

class ProductDetailsScreen {
  String get routeName => '/product-details';
}
