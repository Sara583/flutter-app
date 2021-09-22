import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_appfp/provider/product.dart';
import 'package:shop_appfp/provider/products.dart';
import 'package:shop_appfp/screens/add_product.dart';
import 'package:shop_appfp/widgets/user_product_item.dart';
import '../screens/edit_screen.dart';
import '../widgets/product_items.dart';

class CartScreen extends StatefulWidget {
  final FirebaseApp app;

  const CartScreen({Key key, this.app}) : super(key: key);

  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  final referenceDatabase= FirebaseDatabase.instance;
  static const routeName='/cart-screen';
  Future<void> _refreshProducts(BuildContext context) async{
    await Provider.of<Products>(context,listen: false).getProducts(true);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Products'),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.add,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AddProductScreen()),);

            },
          )
        ],
      ),
      body: FutureBuilder(
        future: _refreshProducts(context),
        builder:(BuildContext context ,AsyncSnapshot snapshot)=>snapshot.connectionState==ConnectionState.waiting?
            Center(child: CircularProgressIndicator())
        : RefreshIndicator( onRefresh :() =>_refreshProducts(context),
          child: Consumer<Products>(builder: (context,ProductsData,_)=>Padding(
            padding: EdgeInsets.symmetric(),
            child:ListView.builder(
              itemCount: ProductsData.products.length,
                itemBuilder: (_,int index)=>Column(
                  children: [
                    UserProductItem(
                        ProductsData.products[index].id,
                        ProductsData.products[index].title,
                        ProductsData.products[index].imageUrl
                    ),
                    Divider(height: 5,thickness: 2),
                  ],
                )
            ),
          ),
          ),

      ),

    ));
  }
}

