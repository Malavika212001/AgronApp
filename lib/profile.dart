import 'package:agron/buyerorderlist.dart';
import 'package:agron/login.dart';
import 'package:flutter/material.dart';
//import firebase_auth
import 'package:firebase_auth/firebase_auth.dart';
//import firestore
import 'package:cloud_firestore/cloud_firestore.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
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
  //create a Signout button and navigate to the login page
  child: SafeArea(
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
          SizedBox(height: 15,),
        SizedBox(
          width: 90, height: 90,
          child: Image.asset('lib/Images/user.png')),
        const SizedBox(height: 15,),
        //get name from collection UserData with docid email
        StreamBuilder(
          stream: FirebaseFirestore.instance.collection('UserData').doc(FirebaseAuth.instance.currentUser?.email).snapshots(),
          builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
            if (snapshot.hasError) {
              return const Text('Something went wrong');
            }

            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Text("Loading");
            }
            return Text(
              ' ${snapshot.data?['name']}',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w700,
                height: 0,
              ),
            );
          },
        ),
        SizedBox(height: 15,),
        //display email of the current user
        Text(
          ' ${FirebaseAuth.instance.currentUser?.email}',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w700,
            height: 0,
          ),
        ),
        const SizedBox(height: 50,),
        GestureDetector(
          child: Container(
                  height: 40,width: 150,
                  padding: EdgeInsets.symmetric(horizontal: 25),
                  margin:  const EdgeInsets.symmetric(horizontal: 25),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    ),
                  child:  const Center(
                    child: Text(
                      'Your Orders',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w700,
                        height: 0,
                      ),
                    ),
                  ),
                ),
          onTap: () async {
            //await FirebaseAuth.instance.signOut();
            Navigator.push(context, // Current context
      MaterialPageRoute(builder: (context) => BuyerOrderList(docid: '',)),
              );
          },
        ),
        SizedBox(height: 15,),
        //create a Signout button and navigate to the login page
        GestureDetector(
          child: Container(
                  height: 40,width: 150,
                  padding: EdgeInsets.symmetric(horizontal: 25),
                  margin:  const EdgeInsets.symmetric(horizontal: 25),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    ),
                  child:  const Center(
                    child: Text(
                      'Sign Out',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w700,
                        height: 0,
                      ),
                    ),
                  ),
                ),
          onTap: () async {
            await FirebaseAuth.instance.signOut();
            Navigator.push(context, // Current context
      MaterialPageRoute(builder: (context) => loginpage()),
              );
          },
        ),
      ],
    ),
  ),
  )
    );
  }
}