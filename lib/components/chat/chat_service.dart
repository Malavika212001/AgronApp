import 'package:agron/model/message.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ChatService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  Stream<List<Map<String, dynamic>>> getUserSTream(){
    return _firestore.collection('UserData').snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        final user = doc.data();
        return user;
      }).toList();
    });
  }

  //Send Message
  Future<void> sendMessage(String receiverUserEmail, String message) async {
    final String currentUserEmail = FirebaseAuth.instance.currentUser!.email!;
    final Timestamp timestamp = Timestamp.now();
  
    //create message
    Message newMessage = Message(
      senderEmail: currentUserEmail, 
      receiverUserEmail: receiverUserEmail, 
      message: message, 
      timestamp: timestamp, 
    );
  
    //construct a chat room
    List<String> ids = [currentUserEmail, receiverUserEmail];
    ids.sort();
    String chatRoomId = ids.join('_');
    
    //save message to firestore
    await FirebaseFirestore.instance
      .collection('chatrooms')
      .doc(chatRoomId)
      .collection('messages')
      .add(newMessage.toMap());
  }
  //get the message
  Stream<QuerySnapshot> getMessages(String userEmail, otherUserEmail){
        List<String> ids = [userEmail, otherUserEmail];
        ids.sort();
        String chatRoomId = ids.join('_');

        return FirebaseFirestore.instance
        .collection('chatrooms')
        .doc(chatRoomId)
        .collection('messages')
        .orderBy('timestamp', descending: true)
        .snapshots();
      }
}