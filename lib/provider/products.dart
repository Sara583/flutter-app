import 'dart:convert';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import './product.dart';
import 'package:firebase_database/firebase_database.dart';

import '../screens/favourite_screen.dart';

enum Status { Fav, notFav }

class Products with ChangeNotifier {
  List<Product> filterProducts({Status status}) {
    return _products.where((element) => element.status == status).toList();
  }

  List<Product> _products = [
    Product(
      id: '1',
      title: 'Product 1',
      price: 150,
      description: 'Any Description',
      imageUrl:
      'https://media.istockphoto.com/photos/running-shoes-picture-id1249496770?b=1&k=6&m=1249496770&s=170667a&w=0&h=9uttCAghGWpQC9aNxH7B50vsahNUHFL49IpI7J0Mxug=',
      isFavourite: false,
    ),
    Product(
      id: '2',
      title: 'Product 2',
      price: 100,
      description: 'Any Description',
      imageUrl:
      'https://media.istockphoto.com/photos/running-shoes-picture-id1249496770?b=1&k=6&m=1249496770&s=170667a&w=0&h=9uttCAghGWpQC9aNxH7B50vsahNUHFL49IpI7J0Mxug=',
      isFavourite:false,
    ),
    Product(
      id: '3',
      title: 'Product 3',
      price: 150,
      description: 'Any Description',
      imageUrl:
          'https://media.istockphoto.com/photos/running-shoes-picture-id1249496770?b=1&k=6&m=1249496770&s=170667a&w=0&h=9uttCAghGWpQC9aNxH7B50vsahNUHFL49IpI7J0Mxug=',
      isFavourite: true,
    ),
  ];

  get isFavourite => null;

  getData(List<Product> products) {
    _products = products;
    notifyListeners();
  }

  List<Product> get products {
    return [..._products];
  }

  Product findById(String id) =>
      _products.firstWhere((element) => element.id == id);

  List<Product> get favouriteProducts {
    return _products.where((prodItem) => prodItem.isFavourite).toList();
  }

  Future<void> getProducts([bool filterByUser = false]) async {
    final filteredData = filterByUser ? 'orderBy"id"' : '';

    var url =
        'https://myshop-865cd-default-rtdb.firebaseio.com/products.json?filteredData';
    try {
      final res = await http.get(url);
      final extractedData = jsonDecode(res.body) as Map<String, dynamic>;
      if (extractedData == null) {
        return;
      }
      url = 'https://myshop-865cd-default-rtdb.firebaseio.com/favourites.json?';
      final favRes = await http.get(url);
      final favData = jsonDecode(favRes.body);
      //intializing list .. if null no problem
      List<Product> loadedProducts = [];
      extractedData.forEach((prodId, prodData) {
        loadedProducts.add(Product(
          id: prodId,
          title: prodData['title'],
          price: prodData['price'],
          description: prodData['description'],
          imageUrl: prodData['imageUrl'],
          isFavourite: favData == null ? false : [prodId] ?? false,
        ));
      });
      _products = loadedProducts;
      notifyListeners();
    } catch (e) {
      throw (e);
    }

    Future<void> changeStatus(String id, Status status) async {
      var dbRef = FirebaseDatabase().reference().child('product').child(id);
      dbRef.update({
        'status': convertFromStatus(status),
      });
      notifyListeners();
    }
  }

  String convertFromStatus(Status status) {
    if (status == Status.Fav) {
      return 'Favourite Item';
    }

    Status convertToStatus(String status) {
      if (status == 'Fav') {
        return Status.Fav;
      } else if (status == 'notFav') {
        return Status.notFav;
      } else {
        return null;
      }
    }
  }


  Future<void> addProduct(Product product) async {
    final url =
      'https://myshop-865cd-default-rtdb.firebaseio.com/products.json?';
    try {
     final res = await http.post(url,
      body: json.encode({

       'title': product.title,

      'description': product.description,
       'price': product.price,
      'imageUrl': product.imageUrl,
        }));
   final newProduct = Product(
     id: json.decode(res.body)['name'],
      title: product.title,
       description: product.description,
       imageUrl: product.imageUrl,
      price: product.price);
       _products.add(newProduct);
   notifyListeners();
 } catch (e) {
   throw (e);
   }
 }

  Future<void> updateProduct(String id, Product newProduct) async {
    final prodIndex = _products.indexWhere((prod) => prod.id == id);
    final url =
        'https://myshop-865cd-default-rtdb.firebaseio.com/products/$id.json?filteredData';
    await http.patch(url,
        body: json.encode({
          'title': newProduct.title,
          'description': newProduct.description,
          'price': newProduct.price,
          'imageUrl': newProduct.imageUrl,
        }));
    _products[prodIndex] = newProduct;
    notifyListeners();
  }

 // Future<void> removeProd(String id) async {
 //   var dbRef = FirebaseDatabase().reference().child('products').child(id);
 //   await dbRef.remove();

 //   notifyListeners();
 // }
  Future<void>removeProd(String id) async{
    final url='https://myshop-865cd-default-rtdb.firebaseio.com/products/$id.json?';
    final exisitedProdIndex=_products.indexWhere((prod) => prod.id==id);
    var  exisitedProd=_products[exisitedProdIndex];
    _products.removeAt(exisitedProdIndex);
    notifyListeners();
    final res= await http.delete(url);
  }
}
