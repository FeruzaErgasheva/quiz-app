import 'package:cloud_firestore/cloud_firestore.dart';

class Quiz {
  String id;
  String question;
  List options;
  num correct;

  Quiz({
    required this.id,
    required this.question,
    required this.options,
    required this.correct,
  });

  factory Quiz.fromJson(QueryDocumentSnapshot query) {
    return Quiz(
      id: query.id,
      question: query['question'],
      options: query['options'],
      correct: query['correct'],
    );
  }
}
