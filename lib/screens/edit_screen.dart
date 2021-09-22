import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_appfp/provider/product.dart';
import 'package:shop_appfp/provider/products.dart';
import 'package:shop_appfp/screens/product_details_screen.dart';
class EditProductScreen extends StatefulWidget {
  final FirebaseApp app;

  const EditProductScreen({Key key, this.app}) : super(key: key);
  @override
  _EditProductScreenState createState() => _EditProductScreenState();
}

class _EditProductScreenState extends State<EditProductScreen> {
  final referenceDatabase= FirebaseDatabase.instance;
  Product product;
  bool _isFirst = true;
  var _args;
  var _titleController = TextEditingController();
  var _priceController = TextEditingController();
  var _descriptionController = TextEditingController();
  var _UrlController = TextEditingController();

  void didChangeDependencies() {
    if (_isFirst) {
      _args = ModalRoute.of(context).settings.arguments;
      print(_args);
      _isFirst = false;
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    var product = Provider.of<Product>(context, listen: false);
    if (_args != null) {
      //   final loadedProduct=Provider.of<Products>(context,listen: false).findById(productId);
      _titleController.text = product.title;
      _priceController.text = product.price as String;
      _descriptionController.text =product.description;
      _UrlController.text= product.imageUrl;

     Product(id:null , title: _titleController.text ,description:_descriptionController.text,imageUrl: _UrlController.text  );
Product newProduct ;

    }
    return Scaffold(
      appBar: AppBar(
        title: Text( 'Edit product'),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.save,
              color: Colors.white,
            ),
            onPressed: () {

              Provider.of<Products>(context, listen: false).updateProduct(product.id,product);

              Navigator.pop(context);

            },

          )
        ],
      ),
      body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView(
              children: [
                TextField(
                  controller: _titleController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Title',
                    helperText: product.title,
                    hoverColor: Colors.black26,
                  ),

                ),
                SizedBox(
                  height: 20,
                ),
                TextField(
                  controller: _priceController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),

                    labelText: 'Price ',

                  ),


                ),



                SizedBox(
                  height: 20,
                ),
                TextField(
                  controller: _descriptionController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                helperText: product.description,
                    labelText: 'Description',
                  ),

                ),
                SizedBox(height: 20),
                TextField(
                  controller: _UrlController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText:'Url',
                    helperText: product.imageUrl,
                  ),

                ),
                SizedBox(height: 20),

              ])),
    );

  }}
