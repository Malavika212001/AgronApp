import 'package:cloud_firestore/cloud_firestore.dart';

class Message{
  //final String senderId;
  final String senderEmail;
  final String receiverUserEmail;
  final String message;
  final Timestamp timestamp;

  Message( {
   //required this.senderId, 
   required this.senderEmail, 
   required this.receiverUserEmail, 
   required this.message, 
   required this.timestamp, 
  });

  Map<String, dynamic> toMap(){
    return{
      //'senderId': senderId,
      'senderEmail': senderEmail,
      'receiverEmail': receiverUserEmail,
      'message': message,
      'timestamp': timestamp,
    };
  }
}