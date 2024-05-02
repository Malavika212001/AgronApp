import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
//import firestore
import 'package:cloud_firestore/cloud_firestore.dart';

class OrderPage extends StatefulWidget {
  const OrderPage({super.key});

  @override
  State<OrderPage> createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  final firestoreInstance = FirebaseFirestore.instance;
  final firebaseUser = FirebaseAuth.instance.currentUser;
String? email;

void someMethod() {
  email = firebaseUser?.email;
}
  @override
  Widget build(BuildContext context) {
    someMethod();
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
  child: SafeArea(
    child: Column(
      children: [
        Padding(
           padding: const EdgeInsets.symmetric(horizontal: 22.0,vertical: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Image.asset('lib/Images/logo message.png'),
                    SizedBox(width: 10,),
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
          StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection('malu@gmail.com')
                        .snapshots(),
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                      return Column(
                        children: snapshot.data!.docs.map<Widget>((document) {
                          // Check if docid is not 'Address'
                          if (document.id.toString() != 'Address') {
                            return Column(
                              children: [
                                Container(
                                  width: 304,
                                  height: 87,
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
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 22),
                                    child: Row(
                                      children: [
                                        Image.network(
                                          document['image'],
                                          height: 100,
                                          width: 100,
                                        ),
                                        SizedBox(width: 10,),
                                        Column(
                                          children: [
                                            SizedBox(height: 15,),
                                            Text(
                                              document['name'],
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 18,
                                                fontFamily: 'Sedgwick Ave Display',
                                                fontWeight: FontWeight.bold,
                                                height: 0,
                                              ),
                                            ),
                                            SizedBox(height: 10,),
                                            Text(
                                  document['weight'],
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 20,
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                            // Text(
                                            //   document['price'],
                                            //   style: TextStyle(
                                            //     color: Colors.black,
                                            //     fontSize: 18,
                                            //     fontFamily: 'Sedgwick Ave Display',
                                            //     fontWeight: FontWeight.bold,
                                            //     height: 0,
                                            //   ),
                                            // ),
                                          ],
                                        ),
                                        //gesture detector for a buy button
                                        SizedBox(width: 20,),
                                        // GestureDetector(
                                        //   child: Container(
                                        //     height: 50,
                                        //     width: 66,
                                        //     decoration: BoxDecoration(
                                        //       color: Color(0xffF3DD19),
                                        //       borderRadius: BorderRadius.circular(10),
                                        //     ),
                                        //     child: Center(
                                        //       child: Text(
                                        //         'Buy',
                                        //         style: TextStyle(
                                        //           color: Colors.black,
                                        //           fontWeight: FontWeight.bold,
                                        //         ),
                                        //       ),
                                        //     ),
                                        //   ),
                                        //   // onTap: () {
                                        //   //   Navigator.push(
                                        //   //     context,
                                        //   //     MaterialPageRoute(
                                        //   //       builder: (context) => CustomerDetails(docid: document.id,),
                                        //   //     ),
                                        //   //   );
                                        //   // },
                                        // ),
                                         Container(
                                            height: 50,
                                            width: 66,
                                            decoration: BoxDecoration(
                                              color: Color(0xffF3DD19),
                                              borderRadius: BorderRadius.circular(10),
                                            ),
                                            child: Padding(
                                              padding: const EdgeInsets.symmetric(horizontal: 4),
                                              child: Center(
                                                child: Text(
                                                  'Complete Order',
                                                  style: TextStyle(
                                                    color: Colors.black,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                      ],
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 25,
                                ),
                                //display weight from the collection email with doc docid
                                
                              ],
                            );
                          } else {
                            return Container(); // Return an empty container if docid is 'Address'
                          }
                          
                          
                        }).toList(),
                      );
                    },
                  ),
          ]
    ),
    ),
      ),
    );
  }
}