import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class AiPage extends StatefulWidget {
  AiPage({Key? key}) : super(key: key);

  @override
  _AiPageState createState() => _AiPageState();
}

class _AiPageState extends State<AiPage> {
  TextEditingController textcontroller = TextEditingController();
  String chat = '';
  




@override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Color(0xFF013220),
                    Colors.black,
                    Colors.white.withOpacity(0.0)
                  ],
                ),
              ),
              child: Stack(
                children: [
                  
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Center(
                        child: Image.asset(
                          'lib/Images/Frame 1.png',
                          width: 100,
                          height: 100,
                          // Adjust width and height according to your requirements
                        ),
                        
                      ),
                      Center(child: Text("welcome to \n \t\t\t\tAgron",style: TextStyle(color: Colors.white,fontSize: 40),)),
            
                    ],
                  ),
                   SizedBox(height: 10,),
                   
                  Text(chat, style: TextStyle(color: Colors.white)),
                ],
              ),
            ),
          ),
          TextField(
            decoration: InputDecoration(
              hintText: 'Enter text here',
              contentPadding: const EdgeInsets.all(15),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
              ),
              fillColor: Colors.transparent,
              filled: true,
              hintStyle: TextStyle(
                color: Colors.grey,
              ),
              
              suffixIcon: IconButton(
                icon: Icon(Icons.send),
                onPressed: () async {
                  //String message = textcontroller.text;
                  
                  textcontroller.clear();
                 
                },
              ),
            ),
            style: TextStyle(color: Colors.white),
          ),
        ],
      ),
    );
  }
}

