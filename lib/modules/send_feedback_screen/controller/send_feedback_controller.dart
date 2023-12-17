import 'package:CoachBot/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SendFeedbackController extends ChangeNotifier {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController feedbackController = TextEditingController();
  final user = FirebaseAuth.instance.currentUser;
  bool isLoading = false;
  String? feedbackError;

  Future<void> saveFeedback(BuildContext context) async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      final feedbackData = {
        'id': user!.uid,
        'email': user.email,
        'feedback': feedbackController.text,
        'email': user.email,
        'date': DateTime.now(),
      };
      isLoading = true;
      notifyListeners();

      await FirebaseFirestore.instance.collection('UserFeedbacks').add(feedbackData);
      Utils.positiveToastMessage('Thanks for giving a feedback');
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }


  @override
  void dispose() {
    feedbackController.dispose();
    super.dispose();
  }

}