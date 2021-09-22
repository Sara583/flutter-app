import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../screens/product_view.dart';
import '../provider/product.dart';
import '../provider/products.dart';
import '../provider/favourites.dart';
import '../widgets/fav_grid.dart';

class Favourite_Screen extends StatelessWidget {
  final FirebaseApp app;

   Favourite_Screen({Key key, this.app}) : super(key: key);
  @override
  final referenceDatabase= FirebaseDatabase.instance;
  Widget build(BuildContext context) {
    //Provider.of<Products>(context).filterProducts(status: Status.Fav);

    final product = Provider.of<Product>(context, listen: false);
    product.isFavourite=true;
    return GridTile(
      child: GestureDetector(
        child: Hero(
            tag: product.isFavourite,
            child: FadeInImage(
              placeholder: AssetImage('assets/images/product-placeholder.png'),
              image: NetworkImage(product.imageUrl),
              fit: BoxFit.cover,
            )),
      ),
      footer: GridTileBar(
        backgroundColor: Colors.black87,
        title: Text(product.title, textAlign: TextAlign.center),
      ),
      header: GridTileBar(
        backgroundColor: Colors.black87,
        leading: Consumer<Product>(
          builder: (ctx, product, _) => IconButton(
            alignment: Alignment.centerRight,
            icon: Icon(
              Icons.favorite,
              color: Colors.red,
            ),
            onPressed: () {},
          ),
        ),
      ),
    );
  }
}
