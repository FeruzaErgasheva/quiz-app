// import 'package:flutter/material.dart';

// class SelectController extends ChangeNotifier {
//   Map<int, String> _selectedOption = {};

//   Map<int, String> get selectedOption => _selectedOption;

//   void selectOption(int index, String option) {
//     _selectedOption[index] = option;
//     notifyListeners();
//   }
// }

import 'package:flutter/material.dart';

class SelectController extends ChangeNotifier {
  Map<int, String> _selectedOption = {};
  int _answerCount = 0;

  Map<int, String> get selectedOption => _selectedOption;
  int get answerCount => _answerCount;

  void selectOption(int index, String option, bool isCorrect) {
    _selectedOption[index] = option;
    if (isCorrect) {
      _answerCount += 1;
    }
    print("correct: $_answerCount");
    notifyListeners();
  }
}
