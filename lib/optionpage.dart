import 'package:agron/bottomnavbar.dart';
import 'package:agron/bottomnavbar2.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class OptionPage extends StatefulWidget {
  const OptionPage({super.key});

  @override
  State<OptionPage> createState() => _OptionPageState();
}

class _OptionPageState extends State<OptionPage> {
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
   child:  SafeArea(
    child: Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 35,vertical: 60),
          child: SizedBox(
          width: 360,
          height: 106,
          child: Text(
            'Select Your Option',
            textAlign: TextAlign.left,
            style: TextStyle(
              color: Colors.white,
              fontSize: 40,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w700,
              height: 0,
            ),
          ),
          ),
        ),
        const SizedBox(height: 30,),
           GestureDetector(
             child: Container(
                     height: 84,width: 300,
                     padding: EdgeInsets.symmetric(horizontal: 25),
                     margin:  const EdgeInsets.symmetric(horizontal: 25),
                     decoration: BoxDecoration(
                       color: Colors.white,
                       borderRadius: BorderRadius.circular(10),
                       ),
                     child:  const Center(
                       child: Text(
                         'Farmer',
                          style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 20
                         ),
                       ),
                     ),
                    ),
                   onTap:() async {
                    // Get instance of FirebaseFirestore and FirebaseAuth
                    final firestoreInstance = FirebaseFirestore.instance;
                    final firebaseUser = FirebaseAuth.instance.currentUser;
                  
                    if (firebaseUser != null) {
                      // Get user's email
                      String? email = firebaseUser.email;
                  
                      // Create a new document in the 'Option' collection
                      await firestoreInstance.collection('Option').doc(email).set({
                        'email': email,
                        'option': 'farmer',
                      });
                  
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => ScreenMainPage()));
                    }
                  },
           ),
           const SizedBox(height: 70,),
           GestureDetector(
             child: Container(
                     height: 84,width: 300,
                     padding: EdgeInsets.symmetric(horizontal: 25),
                     margin:  const EdgeInsets.symmetric(horizontal: 25),
                     decoration: BoxDecoration(
                       color: Colors.white,
                       borderRadius: BorderRadius.circular(10),
                       ),
                     child:  const Center(
                       child: Text(
                         'Buyer',
                          style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 20
                         ),
                       ),
                     ),
                    ),
                  onTap:() async {
                    // Get instance of FirebaseFirestore and FirebaseAuth
                    final firestoreInstance = FirebaseFirestore.instance;
                    final firebaseUser = FirebaseAuth.instance.currentUser;
                  
                    if (firebaseUser != null) {
                      // Get user's email
                      String? email = firebaseUser.email;
                  
                      // Create a new document in the 'Option' collection
                      await firestoreInstance.collection('Option').doc(email).set({
                        'email': email,
                        'option': 'buyer',
                      });
                  
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => ScreenMainPage1()));
                    }
                  },
           ),
           const SizedBox(height: 25,),
            Text('Role  you select cannot be changed after!',style: TextStyle(color: Colors.white,fontSize: 14,
      fontFamily: 'Poppins',
      fontWeight: FontWeight.bold,
      height: 0,),
      ),
        ]
    )
   )
  )
    );
  }
}