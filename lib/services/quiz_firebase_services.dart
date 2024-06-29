import 'package:cloud_firestore/cloud_firestore.dart';

class QuizFirebaseServices {
  final _quizCollection = FirebaseFirestore.instance.collection("quiz");

  Stream<QuerySnapshot> getQuizQuestions() async* {
    yield* _quizCollection.snapshots();
  }

  void addQuestion(List<String> answers, int correct, String question) {
    _quizCollection
        .add({"options": answers, "question": question, "correct": correct});
  }
}
