import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_appfp/provider/product.dart';
import 'package:shop_appfp/provider/products.dart';
class AddProductScreen extends StatefulWidget {

  final FirebaseApp app;

  const AddProductScreen({Key key, this.app}) : super(key: key);

  @override
  _AddProductScreenState createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
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
    final ref =referenceDatabase.reference();
    var product = Provider.of<Product>(context, listen: false);
    if (_args != null) {
      //   final loadedProduct=Provider.of<Products>(context,listen: false).findById(productId);
      _titleController.text = product.title;
      _priceController.text = product.price as String;
      _descriptionController.text =product.description;
      _UrlController.text= product.imageUrl;

   Product(id:null , title: _titleController.text ,description:_descriptionController.text,imageUrl: _UrlController.text  );

    }
    return Scaffold(
      appBar: AppBar(
        title: Text(_args == null ? 'Add new product' : 'Edit product'),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.save,
              color: Colors.white,
            ),
            onPressed: () {
                _args == null;
                Provider.of<Products>(context, listen: false).addProduct( Product(id:null , title: _titleController.text ,description:_descriptionController.text,imageUrl: _UrlController.text));

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
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                TextField(
                  controller: _priceController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Price',
                  ),


                ),



                SizedBox(
                  height: 10,
                ),
                TextField(
                  controller: _descriptionController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),

                    labelText: 'description',
                  ),

                ),
                SizedBox(height: 10,),
                TextField(
                  controller: _UrlController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'image url',
                  ),
                ),
                SizedBox(height: 10,),

                ])),
    );

  }}
