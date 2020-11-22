import 'package:cloud_firestore/cloud_firestore.dart';

class Note {
  final String author;
  final String title;
  final String content;
  final Timestamp timestamp;

  Note({this.author, this.title, this.content, this.timestamp});
}

/*  

Note(
                        author: doc.data['author'],
                        title: doc.data['title'],
                        content: doc.data['content'],
                        timestamp: doc.data['timestamp'])
*/
