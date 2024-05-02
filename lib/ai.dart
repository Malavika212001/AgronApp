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
  //late ResponseModel _responseModel;

  @override
  void initState() {
    super.initState();
    textcontroller =TextEditingController();
  }

  @override
  void dispose() {
    textcontroller.dispose();
    super.dispose();
  }
Future<String> chatWithGpt(String message) async {
  final response = await http.post(
    Uri.parse('https://api.openai.com/v1/engines/davinci-codex/completions'),
    headers: {
      'Authorization': 'sk-proj-ujZlJv5AFQN9LfRjDb6ET3BlbkFJc9dkoXBxl3ybN0pLdQJC',
      'Content-Type': 'application/json',
    },
    body: jsonEncode({
      'prompt': message,
      'max_tokens': 60,
    }),
  );

  if (response.statusCode == 200) {
    Map<String, dynamic> data = jsonDecode(response.body);
    return data['choices'][0]['text']['content'].trim();
  } else {
    throw Exception('Failed to chat with GPT-3');
  }
}


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
                  String message = textcontroller.text;
                  String response = await chatWithGpt(message);
                  setState(() {
                    chat += 'You: $message\nAgron: $response\n\n';
                  });
                  textcontroller.clear();
                  print(response);
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

