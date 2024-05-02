// ignore_for_file: must_be_immutable

import 'dart:developer';
import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
//import firestore
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/widgets.dart';
import 'package:image_picker/image_picker.dart';

class ProductDetails extends StatefulWidget {
  //get docid
   String docid;
   ProductDetails( {super.key, required this.docid});

  @override
  State<ProductDetails> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {

final ImagePicker imagePicker = ImagePicker();
final List<XFile> _imageFileList = [];

Future<List<XFile>> selectimage()async{
  //log(_imageFileList.toString());
  final List<XFile>? selectedimages = await imagePicker.pickMultiImage();
  if (selectedimages!.isNotEmpty) {
    _imageFileList.clear();
    _imageFileList.addAll(selectedimages);
    
  }
  return selectedimages;


  
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
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 5),
                       child: SizedBox(
                        width: 150,
                        height: 150,
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
                          
                                SizedBox(width: 5,),
                                SizedBox(
                                  width: MediaQuery.of(context).size.width,
                                  child: SingleChildScrollView(
                                    scrollDirection: Axis.horizontal,
                                    child: Row(
                                      children: [
                                        FutureBuilder<DocumentSnapshot>(
                                          future: FirebaseFirestore.instance.collection('product').doc(widget.docid).get(),
                                          builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
                                            if (snapshot.hasError) {
                                              return Text("Error: ${snapshot.error}");
                                            }

                                            if (snapshot.connectionState == ConnectionState.done) {
                                              Map<String, dynamic>? data = snapshot.data?.data() as Map<String, dynamic>?;
                                              log(data.toString());
                                              if (data != null && data.containsKey('images')) {
                                                List<dynamic> images = data['images'];
                                                log(images.toString());
                                                return Container(
                                                  height: 150,
                                                  width: MediaQuery.of(context).size.width, // Set the width to the screen width
                                                  child: ListView.separated(
                                                    scrollDirection: Axis.horizontal,
                                                    itemCount: images.length,
                                                    itemBuilder: (context, index) {
                                                      return FadeInImage.assetNetwork(
                                                        placeholder: 'assets/loading.gif', // Replace with your own loading image
                                                        image: images[index],
                                                        imageErrorBuilder: (context, error, stackTrace) {
                                                          print('Error loading image: $error'); // Print the error to the console
                                                          return Image.asset('assets/error.png'); // Replace with your own error image
                                                        },
                                                      );
                                                    },
                                                    separatorBuilder: (context, index) {
                                                      return SizedBox(width: 10); // Add a 10 pixel wide space between items
                                                    },
                                                  ),
                                                );
                                              } else {
                                                return Text('Field "images" does not exist');
                                              }
                                            }

                                            return CircularProgressIndicator(); // Show a loading spinner while waiting for the data
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 22,vertical: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
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
                        Flexible(
                          child: Text(
                            'Detail: ${product?['detail']}',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w400,
                              height: 0,
                            ),
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

  Row(
    children: [
      Flexible(
        child: GestureDetector(
          child: Container(
            height: 50,width: 150,
            padding: EdgeInsets.symmetric(horizontal: 25),
            margin:  const EdgeInsets.symmetric(horizontal: 25),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              ),
            child:  const Center(
              child: Text(
                'Add Images',
                style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 20
                ),
              ),
            ),
          ),
          onTap: () async {
            List<String> imageUrls = []; // List to store the download URLs
          
            // Ensure selectimage() returns a non-null List<XFile>
            List<XFile> images = await selectimage() ?? [];
          
            for (var imageFile in images) {
              String fileName = DateTime.now().millisecondsSinceEpoch.toString() + '.jpg'; // Generate a unique file name with .jpg extension
          
              // Upload the image to Firebase Storage
              Reference ref = FirebaseStorage.instance.ref().child('upload').child(fileName);
              UploadTask uploadTask = ref.putFile(File(imageFile.path));
              TaskSnapshot taskSnapshot = await uploadTask;
          
              // Get the download URL and add it to the list
              String downloadUrl = await taskSnapshot.ref.getDownloadURL();
              imageUrls.add(downloadUrl);
            }
          
            // Store the download URLs in the 'images' field of the document
            FirebaseFirestore.instance.collection('product').doc(widget.docid).update({
              'images': FieldValue.arrayUnion(imageUrls),
            });
          }
          ),
      ),
      //SizedBox(height: 15,),
      //gesture detector to delete doc
      Flexible(
        child: GestureDetector(
          child: Container(
            height: 50,width: 150,
            padding: EdgeInsets.symmetric(horizontal: 25),
            margin:  const EdgeInsets.symmetric(horizontal: 25),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              ),
            child:  const Center(
              child: Text(
                'Delete',
                style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 20
                ),
              ),
            ),
          ),
          onTap:() {
            FirebaseFirestore.instance.collection('product').doc(widget.docid).delete();
            Navigator.pop(context);
          },
          ),
      ),
    ],
  ),
        ],
        );
    }
    ),
    ],
    
    
    ),
    ),
    ),
    );
    }
}