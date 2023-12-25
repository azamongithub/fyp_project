import 'dart:async';

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../../models/DiseaseDataModel.dart';

class HealthStatusController extends ChangeNotifier {
  bool isLoading = false;
  String? selectedDisease;
  // List<Disease> _diseases = [];
  // List<Disease> get diseases => _diseases;

  List<Disease> _diseases = [];
  StreamController<Disease?> _diseaseStreamController = StreamController<Disease?>();

  List<Disease> get diseases => _diseases;
  Stream<Disease?> get diseaseStream => _diseaseStreamController.stream;


  void setSelectedDisease(String value) {
    selectedDisease = value;
    notifyListeners();
  }

  void setIsLoading(bool value) {
    isLoading = value;
    notifyListeners();
  }

  Future<void> saveHealthDetails(BuildContext context) async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      final healthData = {
        'disease': selectedDisease,
      };
      await FirebaseFirestore.instance
          .collection('UserDataCollection')
          .doc(user!.uid)
          .set(healthData, SetOptions(merge: true));
    } catch (e) {
      print(e.toString());
    } finally {
      setIsLoading(false);
    }
  }




  Future<void> fetchDiseaseById(String id) async {
    try {
      final DocumentSnapshot<Map<String, dynamic>> snapshot =
      await FirebaseFirestore.instance.collection('AllDiseasesInfo').doc(id).get();

      if (snapshot.exists) {
        final Disease disease = Disease(
          id: snapshot.id,
          name: snapshot.data()!['name'],
          data: snapshot.data()!,
        );
        _diseases = [disease];
        notifyListeners();
        _diseaseStreamController.add(disease);
      }
    } catch (error) {
      print('Error fetching disease data: $error');
    }
  }

  Stream<Disease?> fetchDiseaseByIdStream(String id) async* {
    try {
      final DocumentSnapshot<Map<String, dynamic>> snapshot =
      await FirebaseFirestore.instance.collection('AllDiseasesInfo').doc(id).get();

      if (snapshot.exists) {
        final Disease disease = Disease(
          id: snapshot.id,
          name: snapshot.data()!['name'],
          data: snapshot.data()!,
        );
        _diseases = [disease];
        notifyListeners();
        yield disease;
      } else {
        print('Snapshot does not exist for ID: $id');
        yield null;
      }
    } catch (error) {
      print('Error fetching disease data: $error');
      yield null;
    }
  }


  // Stream<Disease?> fetchDiseaseByIdStream(String id) async* {
  //   try {
  //     final DocumentSnapshot<Map<String, dynamic>> snapshot =
  //     await FirebaseFirestore.instance.collection('AllDiseasesInfo').doc(id).get();
  //
  //     if (snapshot.exists) {
  //       final Disease disease = Disease(
  //         id: snapshot.id,
  //         name: snapshot.data()!['name'],
  //         data: snapshot.data()!,
  //       );
  //       _diseases = [disease];
  //
  //       notifyListeners();
  //       yield disease;
  //     } else {
  //       yield null;
  //     }
  //   } catch (error) {
  //     print('Error fetching disease data: $error');
  //     yield null;
  //   }
  // }

  void dispose() {
    _diseaseStreamController.close();
    super.dispose();
  }




  // Future<void> fetchDiseaseById(String id) async {
  //   try {
  //     final DocumentSnapshot<Map<String, dynamic>> snapshot =
  //     await FirebaseFirestore.instance.collection('AllDiseasesInfo').doc(id).get();
  //
  //     if (snapshot.exists) {
  //       final Disease disease = Disease(
  //         id: snapshot.id,
  //         name: snapshot.data()!['name'],
  //         data: snapshot.data()!,
  //       );
  //       _diseases = [disease];
  //       notifyListeners();
  //     }
  //   } catch (error) {
  //     print('Error fetching disease data: $error');
  //   }
  // }


}



