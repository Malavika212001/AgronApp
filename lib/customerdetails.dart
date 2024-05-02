import 'package:agron/components/my_textfield.dart';
import 'package:agron/payment.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
//import firestore
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/widgets.dart';
class CustomerDetails extends StatefulWidget {
  //get docid from the collection email
  String docid;
  CustomerDetails({super.key, required this.docid});
 
  @override
  State<CustomerDetails> createState() => _CustomerDetailsState();
}

class _CustomerDetailsState extends State<CustomerDetails> {
  TextEditingController namecontroller = TextEditingController();
 TextEditingController addresscontroller = TextEditingController();
 TextEditingController phonecontroller = TextEditingController();
 TextEditingController weightcontroller = TextEditingController();
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
       child: Stack(
         children:[ SingleChildScrollView(
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
                            'Customer Details',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 25,
                              fontFamily: 'Sedgwick Ave Display',
                              fontWeight: FontWeight.bold,
                              height: 0,
                            ),
                          ),
                        ],
                      ),
                    ),
                    MyTextField(controller: namecontroller , hintText: 'Full Name', obscureText: false),
                    SizedBox(height: 10,),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal:10,vertical: 5),
                      child: SizedBox(
                    width: 300,height: 146,
                    child: TextField(
                      maxLines: 30,
                      controller: addresscontroller,
                      obscureText: false,
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color:Colors.white,
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.white),
                        borderRadius: BorderRadius.circular(10)
                      ),
                      hintText: 'Address',
                      hintStyle:const TextStyle(color: Colors.grey)
                    ),
                    style:const TextStyle(color: Colors.white)
                    ),
                  ),
                    ),
                    SizedBox(height: 10,),
                    MyTextField(controller: phonecontroller, hintText: 'Phone Number', obscureText: false),
                    MyTextField(controller: weightcontroller, hintText: 'Required Weight of Product', obscureText: false)
          ],),
         ),
         Positioned(
          bottom: 10,left: 100,right: 100,
           child: SizedBox(
             child: GestureDetector(
                                            child: Container(
                                              height: 50,
                                              width: 66,
                                              decoration: BoxDecoration(
                                                color: Color(0xffF3DD19),
                                                borderRadius: BorderRadius.circular(10),
                                              ),
                                              child: Center(
                                                child: Text(
                                                  'Buy',
                                                  style: TextStyle(
                                                    color: Colors.black,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            onTap: () {
                                              //add name,address and phone number to the collection email with docid 'Address' and navigate to paymentpage()
                                              FirebaseFirestore.instance.collection(email!).doc('Address').set({
                                                'name': namecontroller.text,
                                                'address': addresscontroller.text,
                                                'phone': phonecontroller.text,
                                                  });
                                                  FirebaseFirestore.instance.collection('malu@gmail.com').doc('Address').set({
                                                  'name': namecontroller.text,
                                                  'address': addresscontroller.text,
                                                  'phone': phonecontroller.text,
                                                  });
                                                  FirebaseFirestore.instance.collection(email!).doc(widget.docid).update({
                                               'weight': weightcontroller.text,
                                                },
                                                );
                                                 FirebaseFirestore.instance.collection('malu@gmail.com').doc(widget.docid).update({
                                               'weight': weightcontroller.text,
                                                },
                                                );
                                              //save weight to collection email and doc docid
                                              Navigator.push(context, MaterialPageRoute(builder: (context) => PaymentPage()));
                                            },
                                          ),
           ),
         ),
       ])
       )
        );
  }
}