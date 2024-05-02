import 'package:agron/addproduct.dart';
import 'package:agron/optionpage.dart';
import 'package:agron/orderlist.dart';
import 'package:agron/product.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class FarHomepage extends StatefulWidget {
  const FarHomepage({super.key});

  @override
  State<FarHomepage> createState() => _FarHomepageState();
}

class _FarHomepageState extends State<FarHomepage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      backgroundColor: Colors.black,
      body:Container(
      width: double.infinity,
      height: double.infinity,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
      gradient: LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors:[Color(0xFF013220), Colors.black, Colors.white.withOpacity(0.0)],
    ),
  ),
  child: Column(
    children: [
      SizedBox(height: 50,),
        Image.asset('lib/Images/farm2.png',height: 264.0,width: 360.0,),
        const SizedBox(height: 50,),
           GestureDetector(
             child: Container(
                     height: 50,width: 350,
                     padding: EdgeInsets.symmetric(horizontal: 25),
                     margin:  const EdgeInsets.symmetric(horizontal: 25),
                     decoration: BoxDecoration(
                       color: Colors.white,
                       borderRadius: BorderRadius.circular(10),
                       ),
                     child:  const Center(
                       child: Text(
                         'Add Product',
                          style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 20
                         ),
                       ),
                     ),
                    ),
                   onTap:() {
                     Navigator.push(context, // Current context
      MaterialPageRoute(builder: (context) => AddProduct()),
      );
                   }, 
           ),
            const SizedBox(height: 40,),
           GestureDetector(
             child: Container(
                     height: 50,width: 350,
                     padding: EdgeInsets.symmetric(horizontal: 25),
                     margin:  const EdgeInsets.symmetric(horizontal: 25),
                     decoration: BoxDecoration(
                       color: Colors.white,
                       borderRadius: BorderRadius.circular(10),
                       ),
                     child:  const Center(
                       child: Text(
                         'Product List',
                          style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 20
                         ),
                       ),
                     ),
                    ),
                   onTap:() {
                     Navigator.push(context, // Current context
      MaterialPageRoute(builder: (context) => ProductPage()),
      );
                   }, 
           ),
            const SizedBox(height: 50,),
           GestureDetector(
             child: Container(
                     height: 50,width: 350,
                     padding: EdgeInsets.symmetric(horizontal: 25),
                     margin:  const EdgeInsets.symmetric(horizontal: 25),
                     decoration: BoxDecoration(
                       color: Colors.white,
                       borderRadius: BorderRadius.circular(10),
                       ),
                     child:  const Center(
                       child: Text(
                         'Order List',
                          style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 20
                         ),
                       ),
                     ),
                    ),
                   onTap:() {
                     Navigator.push(context, // Current context
      MaterialPageRoute(builder: (context) => OrderPage()),
      );
                   }, 
           ),
          
    ],
  ),
  ),
    );
  }
}