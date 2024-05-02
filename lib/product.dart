import 'package:agron/productdetails.dart';
import 'package:flutter/material.dart';
//import firestore
import 'package:cloud_firestore/cloud_firestore.dart';

class ProductPage extends StatefulWidget {
  const ProductPage({super.key});

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body:Container(
      width: double.infinity,
      height: double.infinity,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
      gradient: LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [Color(0xFF013220), Colors.black, Colors.white.withOpacity(0)],
    ),
  ),
   child: SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Column(
        children: [
           Padding(
           padding: const EdgeInsets.symmetric(horizontal: 22.0,vertical: 35),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Image.asset('lib/Images/logo message.png'),
                    Text(
                    'Agron',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 25,
                      fontFamily: 'Sedgwick Ave Display',
                      fontWeight: FontWeight.w400,
                      height: 0,
                    ),
                  ),
                  ],
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 22),
            child: Row(
              children: [
                Text(
                  'Our \n',
                style: TextStyle(
                  color: Color(0xFF8E9090),
                  fontSize: 20.99,
                  fontFamily: 'Aoboshi One',
                  fontWeight: FontWeight.w400,
                  height: 0.05,
                ),
                ),
              ],
            ),
          ),
          SizedBox(height: 20,),
           Padding(
            padding: const EdgeInsets.symmetric(horizontal: 22),
            child: Row(
              children: [
                Text(
                  'Best Products ',
                style: TextStyle(
                  color: Color(0xFF34A853),
                  fontSize: 26.08,
                  fontFamily: 'Aoboshi One',
                  fontWeight: FontWeight.w400,
                  height: 0.04,
                ),
                ),
              ],
            ),
          ),
          SizedBox(height: 20,),
          //get name,price from collection product and all doc
          StreamBuilder(
            stream: FirebaseFirestore.instance.collection('product').snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return const Text('Loading...', style: TextStyle(color: Colors.white));
              }
              return SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 22.0),
                  child: Wrap(
                    spacing: 15, // space between two adjacent widgets
                    runSpacing: 15, // space between two lines of widgets
                    children: snapshot.data!.docs.map((document) {
                      return GestureDetector(
                        child: Container(
                          width: 142,
                          height: 170.15,
                          decoration: ShapeDecoration(
                            color: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(7.39),
                            ),
                            shadows: [
                              BoxShadow(
                                color: Color(0x3FD3D1D8),
                                blurRadius: 14.77,
                                offset: Offset(7.39, 7.39),
                                spreadRadius: 0,
                              )
                            ],
                          ),
                          child: Column(
                            children: [
                              //get image from firebase storage
                              Image.network(
                                document['image'],
                                // width: 142,
                                height: 100,
                                fit: BoxFit.cover,
                              ),
                              SizedBox(height: 15,),
                              Text(
                                document['name'],
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 14,
                                  fontFamily: 'Alatsi',
                                  fontWeight: FontWeight.bold,
                                  height: 0.05,
                                ),
                              ),
                              SizedBox(height: 10,),
                              Text(
                                document['price'],
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 14,
                                  fontFamily: 'Alatsi',
                                  fontWeight: FontWeight.bold,
                                  height: 0,
                                ),
                              ),
                            ],
                          ),
                        ),
                        onTap:() {
                          //get docid
                          String docid = document.id;
                     Navigator.push(context, // Current context
      MaterialPageRoute(builder: (context) => ProductDetails(
        docid: docid,
      )),
      );
                   }, 
                      );
                    }).toList(),
                  ),
                ),
              );
            },
          )
          
          ]
      ),
      )
     ), 
     );
    
  }
}