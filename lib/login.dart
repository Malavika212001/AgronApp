import 'package:agron/bottomnavbar.dart';
import 'package:agron/bottomnavbar2.dart';
import 'package:agron/buyerhomepage.dart';
import 'package:agron/components/my_textfield.dart';
import 'package:agron/farhomepage.dart';
//import 'package:agron/farhomepage.dart';
import 'package:agron/signin.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:firebase_auth/firebase_auth.dart';

class loginpage extends StatefulWidget {
  const loginpage({super.key});

  @override
  State<loginpage> createState() => _loginpageState();
}

class _loginpageState extends State<loginpage> {

  bool visible = false;
  var eyeicon = const Icon(Icons.visibility_off);
  void toggleicon() {
    setState(() {
      visible = !visible;
      if (!visible) {
        eyeicon = const Icon(Icons.visibility);
      } else {
        eyeicon = const Icon(Icons.visibility_off);
      }
    });
  }

  TextEditingController emailcontroller = TextEditingController();
  TextEditingController passwordcontroller = TextEditingController();

  bool isValid(String email) {
    //check if email is valid
    return RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(email);
  }

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
  child: SafeArea(
    child: SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(height: 100,),
          Image.asset('lib/Images/Frame 1.png',height: 150,width: 150,),
          const SizedBox(height: 25,),
          Text(
                'Agron',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 60,
                  fontFamily: 'Sedgwick Ave Display',
                  fontWeight: FontWeight.w400,
                  height: 0,
                ),
              ),
              const SizedBox(height: 25,),
             MyTextField(
              controller: emailcontroller,
              hintText: 'Email',
              obscureText: false,
             ),
             const SizedBox(height: 15,),
             MyTextField(
              controller: passwordcontroller,
              hintText: 'Password',
              obscureText: true,
             ),
             const SizedBox(height: 10,),
             Padding(
               padding: const EdgeInsets.symmetric(horizontal: 25.0),
               child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                 children: [
                   Text('Forgot Password?',style: TextStyle(color: Colors.white),),
                 ],
               ),
             ),
             const SizedBox(height: 30,),
        //      GestureDetector(
        //        child: Container(
        //                height: 50,width: 350,
        //                padding: EdgeInsets.symmetric(horizontal: 25),
        //                margin:  const EdgeInsets.symmetric(horizontal: 25),
        //                decoration: BoxDecoration(
        //                  color: Colors.white,
        //                  borderRadius: BorderRadius.circular(40),
        //                  ),
        //                child:  const Center(
        //                  child: Text(
        //                    'Sign In',
        //                     style: TextStyle(
        //                     color: Colors.black,
        //                     fontWeight: FontWeight.bold,
        //                     fontSize: 20
        //                    ),
        //                  ),
        //                ),
        //               ),
        //              onTap:() async {
        // //                Navigator.push(context, // Current context
        // // MaterialPageRoute(builder: (context) => ScreenMainPage()),
        // // );
        // try {
        //   final UserCredential user = await FirebaseAuth.instance.signInWithEmailAndPassword(
        //     email: emailcontroller.text,
        //     password: passwordcontroller.text,
        //   );
        //   // If the sign in was successful, navigate to the main screen
        //   Navigator.push(
        //     context,
        //     MaterialPageRoute(builder: (context) => ScreenMainPage()),
        //   );
        // } catch (e) {
        //   // If the sign in was not successful, show a snackbar with an error message
        //   ScaffoldMessenger.of(context).showSnackBar(
        //     SnackBar(
        //       content: Text('Username or password is wrong'),
        //     ),
        //   );
        // }
        //              }, 
        //      ),
        SizedBox(
      width: 300,height: 50,
          child: ElevatedButton(
            onPressed: () async {
                final UserCredential user = await FirebaseAuth.instance.signInWithEmailAndPassword(
            email: emailcontroller.text,
            password: passwordcontroller.text,
          );
              final firestoreInstance = FirebaseFirestore.instance;
              final firebaseUser = FirebaseAuth.instance.currentUser;
          
              if (firebaseUser != null) {
                String? email = firebaseUser.email;
          
                if (email != null) {
          DocumentSnapshot doc = await firestoreInstance.collection('Option').doc(email).get();
          String option = (doc.data() as Map<String, dynamic>)['option'] ?? '';
          
          if (option == 'farmer') {
            if (mounted) {
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => ScreenMainPage()));
            }
          } else {
            if (mounted) {
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => ScreenMainPage1()));
            }
          }
                }
              }
            },
            child: const Text('Sign In',
                            style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 20
                           ),
                         ),),
          ),
            const SizedBox(height: 10,),
           GestureDetector(
            child: Text('Don\'t have an account?',style: TextStyle(color: Colors.white),),
            onTap: () {
              Navigator.push(context, // Current context
        MaterialPageRoute(builder: (context) => SignIn(),),);
            //login with email and password
            // ignore: unused_local_variable
            
      
            },
            ), 
        ],
      ),
    ),
  ),
     ),
      );
  }
}