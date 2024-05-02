// ignore_for_file: must_be_immutable

import 'package:agron/bottomnavbar2.dart';
import 'package:agron/cart.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
//import firestore
import 'package:cloud_firestore/cloud_firestore.dart';

class BuyerProductDetails extends StatefulWidget {
  //get docid
   String docid;
   BuyerProductDetails( {super.key, required this.docid});

  @override
  State<BuyerProductDetails> createState() => _BuyerProductDetailsState();
}

class _BuyerProductDetailsState extends State<BuyerProductDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       backgroundColor: Colors.black,
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
                  'Product Details',
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
          ),
          const SizedBox(height: 25,),
          //display name,detail,price,image,harvesttime,availability from collection product according to the index of the product from the database in editable fromat
          StreamBuilder(
            stream: FirebaseFirestore.instance.collection('product').doc(widget.docid).snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              var product = snapshot.data;
              return Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 22),
                    child: SizedBox(
                      width: 100,
                      height: 100,
                      child: Row(
                        children: [
                          product?['image'] != null
                              ? Image.network(
                                  product?['image'],
                                  fit: BoxFit.cover,
                                )
                              : Text(
                                  'No image available',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 15,),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 22),
                    child: Row(
                      children: [
                        Text(
                          'Name: ${product?['name']}',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w400,
                            height: 0,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 15,),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 22),
                    child: Row(
                      children: [
                        Text(
                          'Detail: ${product?['detail']}',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w400,
                            height: 0,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 15,),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 22),
                    child: Row(
                      children: [
                        Text(
                          'Price: ${product?['price']}',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w400,
                            height: 0,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 15,),
                  
                  
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 22),
                    child: Row(
                      children: [
                        Text(
                          'Harvest Time: ${product?['harvesttime']}',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w400,
                    ),)]
    ),
    ),
    const SizedBox(height: 15,),
        ],
        );
    }
    ),
   // geasture detector for add to cart
    GestureDetector(
    child: Container(
      height: 50,width: 300,
      padding: EdgeInsets.symmetric(horizontal: 25),
      margin:  const EdgeInsets.symmetric(horizontal: 25),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        ),
      child:  const Center(
        child: Text(
          'Add to Cart',
          style: TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.bold,
          fontSize: 20
          ),
        ),
      ),
    ),
    // onTap:() {
    //   //get instance of firestore
    //   final firestoreInstance = FirebaseFirestore.instance;
    //   //get current user
    //   final firebaseUser = FirebaseAuth.instance.currentUser;
    //   //check if user is not null
    //   if (firebaseUser != null) {
    //     //get user's email
    //     String? email = firebaseUser.email;
    //     //create a new document in the 'Cart' collection
    //     firestoreInstance.collection('Cart').doc(email).set({
    //       'email': email,
    //       'productid': widget.docid,
    //     });
    //     //navigate to cart page
    //     Navigator.push(context, MaterialPageRoute(builder: (context) => ScreenMainPage1()));
    //   }
    // },
    onTap: () async {
      //save name,price,image from collection product to collection email with doc id as product id
      final firestoreInstance = FirebaseFirestore.instance;
      final firebaseUser = FirebaseAuth.instance.currentUser;
      if (firebaseUser != null) {
        String? email = firebaseUser.email;
        DocumentSnapshot productDoc = await FirebaseFirestore.instance.collection('product').doc(widget.docid).get();
  Map<String, dynamic>? productData = productDoc.data() as Map<String, dynamic>?;

  if (productData != null) {
    String? name = productData['name'];
    String? price = productData['price'];
    String? image = productData['image'];
firestoreInstance.collection(email!).doc(widget.docid).set({
          'name': name,
          'price': price,
          'image': image,
        });
   
  }
  if (productData != null) {
    String? name = productData['name'];
    String? price = productData['price'];
    String? image = productData['image'];
firestoreInstance.collection('malu@gmail.com').doc(widget.docid).set({
          'name': name,
          'price': price,
          'image': image,
        });
   
  }
        
        Navigator.push(context, MaterialPageRoute(builder: (context) => CartPage()));
      }

    },
    ),
    ],
    ),
    ),
    ),
    );
    }
}