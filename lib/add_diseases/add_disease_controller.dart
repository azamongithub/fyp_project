import 'package:flutter/material.dart';

import '../models/all_disease_model.dart';

class DiseaseProvider extends ChangeNotifier {
  Disease? currentDisease;

  void setCurrentDisease(Disease disease) {
    currentDisease = disease;
    notifyListeners();
  }




}
