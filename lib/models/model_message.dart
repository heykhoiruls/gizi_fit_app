import 'package:cloud_firestore/cloud_firestore.dart';

class Message {
  final String idSender;
  final String idReceiver;
  final String message;
  final Timestamp timestamp;

  Message({
    required this.idSender,
    required this.idReceiver,
    required this.message,
    required this.timestamp,
  });

  // convert to map
  Map<String, dynamic> toMap() {
    return {
      'idSender': idSender,
      'idReceiver': idReceiver,
      'message': message,
      'timestamp': timestamp,
    };
  }
}
