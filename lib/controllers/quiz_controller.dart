
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lesson_65/services/quiz_firebase_services.dart';

class QuizController extends ChangeNotifier {
  final _firebaseQuizServices = QuizFirebaseServices();

  Stream<QuerySnapshot> get list {
    return _firebaseQuizServices.getQuizQuestions();
  }

  void addQuestion(List<String> options, int correct, String question) {
    _firebaseQuizServices.addQuestion(options, correct, question);
    notifyListeners();
  }
}
