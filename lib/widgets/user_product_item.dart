import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_appfp/provider/product.dart';
import 'package:shop_appfp/provider/products.dart';
import 'package:shop_appfp/screens/edit_screen.dart';

class UserProductItem extends StatelessWidget {
  final String id;
  final String title;
  final String imageUrl;

  UserProductItem(this.id, this.title, this.imageUrl);

  @override
  final referenceDatabase= FirebaseDatabase.instance;
  Widget build(BuildContext context) {

    final product=Provider.of<Product>(context,listen:false);
    return ListTile(
      title: Text(title.toString()),
      leading: CircleAvatar(
        backgroundImage: NetworkImage(imageUrl),

      ),
      trailing: Container(
        width: 100,
        child: Row(
          children: [
            IconButton(icon: Icon(Icons.edit), onPressed: () {
                    Navigator.push(
                                  context,
                     MaterialPageRoute(builder: (context) => EditProductScreen()),);
              //Navigator.of(context).pushNamed('/edit-screen',arguments:{
              //product.title,
             // product.price,
             // product.imageUrl,
             // product.description,

            }),

            IconButton(icon: Icon(Icons.delete),color:Colors.red , onPressed: ()
            async{

              await Provider.of<Products>(context,listen: false).removeProd(id);
            },),
          ],
        ),
      ),
    );
  }
}
