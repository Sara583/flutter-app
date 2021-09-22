import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:shop_appfp/screens/product_main.dart';
import 'package:shop_appfp/screens/product_view.dart';
class Entry_Screen extends StatefulWidget {
  @override
  _Entry_ScreenState createState() => _Entry_ScreenState();
}

class _Entry_ScreenState extends State<Entry_Screen> {
  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    //above line for responsive app
    const colorizeColors = [
      Colors.purple,
      Colors.blue,
      Colors.yellow,
      Colors.red,
    ];

    const colorizeTextStyle = TextStyle(
      fontSize: 50.0,
      fontFamily: 'Horizon',
    );

    return Center(
      child: AnimatedTextKit(
        animatedTexts: [

          ScaleAnimatedText(
            'My Shop',
            textStyle: TextStyle(
                fontSize: 70.0,
                fontFamily: 'Lato',
                decoration: TextDecoration.none,
                color: Colors.blueGrey),
            duration: Duration(milliseconds: 2000),
          ),
        ],
        onFinished: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => Product_MainScreen()),
          );
        },

      ),
    );
  }
}
