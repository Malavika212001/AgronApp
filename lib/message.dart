import 'package:agron/chatpage.dart';
import 'package:agron/components/user_tile.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
//import firebase_auth
import 'package:firebase_auth/firebase_auth.dart';
import 'package:agron/components/chat/chat_service.dart';

class MessagePage extends StatefulWidget {
   const MessagePage({super.key});

  @override
  State<MessagePage> createState() => _MessagePageState();
}

class _MessagePageState extends State<MessagePage> {
  final ChatService _chatService = ChatService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Messages', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.black.withOpacity(0.7),
    ),
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
    padding: const EdgeInsets.symmetric(vertical: 5),
        child: _buildUserList(),
        ),
        );
  }

  Widget _buildUserList() {
    return StreamBuilder(
      stream: _chatService.getUserSTream(), 
    builder: (context, snapshot) {
      if(snapshot.hasError){
        return Text('Error: ${snapshot.error}');
      }
      if(snapshot.connectionState == ConnectionState.waiting){
        return const Text('Loading...');
      }
      return ListView(
        children: snapshot.data!.map<Widget>((userData) => _buildUserItem(userData, context)).toList(),
      );
    },
    );
  }

  Widget _buildUserItem(Map<String, dynamic> userData, BuildContext context) {
    if(userData['email'] != FirebaseAuth.instance.currentUser!.email!){
      return UserTile(
      text: userData['name'],
      text1: userData['option'],
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => ChatPage(
              recevierUserEmail: userData['email'], 
              //recevierUserId: userData['uid'],
              ),
          ),
        );
      },
    );
    }else{
      return Container();
    }
  }
}