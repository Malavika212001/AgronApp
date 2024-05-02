import 'package:agron/components/chat/chat_service.dart';
import 'package:agron/components/chat_bubble.dart';
import 'package:agron/components/my_textfield.dart';
import 'package:agron/model/message.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ChatPage extends StatefulWidget {
  final String recevierUserEmail;
  //final String recevierUserId;
  const ChatPage({super.key,  required this.recevierUserEmail, });

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
final TextEditingController _messageController = TextEditingController();

final ChatService _chatService = ChatService();

//for textfield focus
FocusNode myFocusNode = FocusNode();

@override
void initState(){
  super.initState();

  //add listener to focus node
  myFocusNode.addListener(() {
    if(myFocusNode.hasFocus){
      Future.delayed(const Duration(milliseconds: 500),() => scrollDown(),);
    }
  });

  Future.delayed(const Duration(milliseconds: 500),() => scrollDown(),);
}

@override
  void dispose() {
    myFocusNode.dispose();
    _messageController.dispose();
    super.dispose();
  }

  //scroll controller
  final ScrollController _scrollController = ScrollController();
  void scrollDown(){
    _scrollController.animateTo(
      _scrollController.position.maxScrollExtent, 
      duration: const Duration(seconds: 1), 
      curve: Curves.fastOutSlowIn,);
  }

void sendMessage()async{
  if(_messageController.text.isNotEmpty){
    await _chatService.sendMessage(widget.recevierUserEmail, _messageController.text);
    _messageController.clear();
  }
  scrollDown();
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        title: Text(widget.recevierUserEmail),
      ),
      body: Container(
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
        child: Column(
          children: [
            //display messages
             Expanded(
              child: _buildMessageList()
              ),

            //message input
            _buildMessageInput(),
        ],
        ),
      ),
    );
  }

  //build message list
  Widget _buildMessageList(){
    String senderEmail = FirebaseAuth.instance.currentUser!.email!;
    return StreamBuilder(
      stream: _chatService.getMessages(widget.recevierUserEmail, senderEmail),
      builder: (context, snapshot) {
        if(snapshot.hasError){
          return Text('Error: ${snapshot.error}');
        }
        if(snapshot.connectionState == ConnectionState.waiting){
          return const Text('Loading...');
        }
        return ListView(
          controller: _scrollController,
          reverse: true,
          children: snapshot.data!.docs.map<Widget>((doc) => _buildMessageItem(doc)).toList(),
        );
      },
      );
  }

  //build message item
  Widget _buildMessageItem(DocumentSnapshot doc){
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;

    bool isCurrentUser = data['senderEmail'] == FirebaseAuth.instance.currentUser!.email!;

    var alignment = isCurrentUser ? Alignment.centerRight : Alignment.centerLeft;

    return Container(
      alignment: alignment,
      child: Column(
        crossAxisAlignment: isCurrentUser ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          ChatBubble(message: data['message'], isCurrentUser: isCurrentUser),
        ],
      ));
  }

  //build message input
  Widget _buildMessageInput(){
    return Padding(
      padding: const EdgeInsets.only(bottom: 20.0),
      child: Row(
        children: [
           Positioned(
              left: 0,
              right: 0,
              bottom: 0,
             child: MyTextField(
                controller: _messageController,
                hintText: 'Type a message...',
                obscureText: false,
                focusNode: myFocusNode,
              ),
           ),
      
            Flexible(
              child: Container(
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 4, 246, 12),
                  shape: BoxShape.circle,
                ),
                child: IconButton(onPressed: sendMessage, icon: Icon(Icons.send))),
            ),
        ],
      ),
    );
  }
}