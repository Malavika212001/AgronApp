//import 'package:agron/bottomnavbar.dart';
import 'dart:io';

import 'package:agron/bottomnavbar.dart';
import 'package:agron/components/my_textfield.dart';
import 'package:agron/farhomepage.dart';
import 'package:agron/optionpage.dart';
//import 'package:agron/farhomepage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
//import firestore
import 'package:cloud_firestore/cloud_firestore.dart';
//import image picker
import 'package:image_picker/image_picker.dart';
//import permission handler
import 'package:permission_handler/permission_handler.dart';
//import firebase storage
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart';

class AddProduct extends StatefulWidget {
  const AddProduct({super.key});

  @override
  State<AddProduct> createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  TextEditingController namecontroller = TextEditingController();
  TextEditingController detailcontroller = TextEditingController();
  TextEditingController harvesttimecontroller = TextEditingController();
  TextEditingController pricecontroller = TextEditingController();
  TextEditingController availabilitycontroller = TextEditingController();
  TextEditingController imagecontroller = TextEditingController();
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
          //       GestureDetector(
          //         child: Image.asset('lib/Images/backbutton.png'),
          //         onTap: () {
          //           Navigator.pushReplacement(context, // Current context
          // MaterialPageRoute(builder: (context1) => ScreenMainPage()),);
          //         },
          //         )
              ],
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 25.0),
            child: Row(
              children: [
                Text(
                      'Give Product Details',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w700,
                height: 0,)),
              ],
            ),
          ),
          const SizedBox(height: 30,),
          MyTextField(controller: namecontroller, hintText: 'Name of Product', obscureText: false),
          const SizedBox(height: 10,),
          Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0,vertical: 5),
                child: SizedBox(
                  width: 300,height: 146,
                  child: TextField(
                    maxLines: 30,
                    controller: detailcontroller,
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
                    hintText: 'Product Details',
                    hintStyle:const TextStyle(color: Colors.grey)
                  ),
                  style:const TextStyle(color: Colors.white)
                  ),
                ),
              ),
              const SizedBox(height: 10,),
          MyTextField(controller: harvesttimecontroller, hintText: 'Harvest Time', obscureText: false),
          
          const SizedBox(height: 10,),
          MyTextField(controller: pricecontroller, hintText: 'Price per Kg', obscureText: false),
          const SizedBox(height: 10,),
        
          MyTextField(controller: availabilitycontroller, hintText: 'Total Availability of Product', obscureText: false),
          const SizedBox(height: 10,),
          Text('You can upload image when you click on submit button ', style: TextStyle(color: Colors.white, fontSize: 15),),
              const SizedBox(height: 15,),
              GestureDetector(
             child: Container(
                     height: 50,width: 200,
                     padding: EdgeInsets.symmetric(horizontal: 25),
                     margin:  const EdgeInsets.symmetric(horizontal: 25),
                     decoration: BoxDecoration(
                       color: Colors.white,
                       borderRadius: BorderRadius.circular(20),
                       ),
                     child:  const Center(
                       child: Text(
                         'Submit',
                          style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 20
                         ),
                       ),
                     ),
                    ),
                   onTap:() async {

                    String dwl='';
                    final status = await Permission.photos.request();

              if (status.isGranted) {
                final picker = ImagePicker();
                final pickedFile = await picker.getImage(source: ImageSource.gallery);

                if (pickedFile != null) {
                  // If the user picked an image, upload it to Firebase Storage
                  File file = File(pickedFile.path);
                  try {
                    // Upload the file to Firebase Storage under the 'uploads' directory
                    

                    await FirebaseStorage.instance.ref('uploads/${basename(file.path)}').putFile(file);

                    // Get the download URL of the uploaded file
                    

                    final downloadURL = await FirebaseStorage.instance.ref('uploads/${basename(file.path)}').getDownloadURL();
                    setState(() {
                      dwl=downloadURL;
                    });
                    // Save the download URL to a Firestore document
                   
                  } on FirebaseException catch (e) {
                    // If there's an error, print it to the console
                    print(e);
                  }
                } else {
                  // If the user didn't pick an image, show a message
                  print('No image selected.');
                }
              } else {
                print('Permission denied.');
              }
                    //add each fields into a collection called product
                    FirebaseFirestore.instance.collection('product').add({
                      'name': namecontroller.text,
                      'detail': detailcontroller.text,
                      'harvesttime': harvesttimecontroller.text,
                      'price': pricecontroller.text,
                      'availability': availabilitycontroller.text,
                      'image': dwl,
                    }).then((value){
                     Navigator.push(context, // Current context
      MaterialPageRoute(builder: (context) => ScreenMainPage()),
              );
                   });
                   },
           ),    
        ],),
      ),
    ),
      )
    ;
  }
}