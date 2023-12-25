// import 'package:CoachBot/add_diseases/view/add_disease_screen.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
//
// import '../../models/all_disease_model.dart';
// import '../add_disease_controller.dart';
//
// class DiseaseDetailsScreen extends StatelessWidget {
//   final CollectionReference diseasesCollection =
//   FirebaseFirestore.instance.collection('diseases');
//
//   @override
//   Widget build(BuildContext context) {
//     var diseaseProvider = Provider.of<DiseaseProvider>(context);
//     var currentDisease = diseaseProvider.currentDisease;
//
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(currentDisease!.name),
//       ),
//       body:
//         // ... previous code ...
//
//         ElevatedButton(
//           onPressed: () {
//             // Update Firestore with new disease information
//             updateDiseaseInFirestore(currentDisease);
//           },
//           child: Text('Update Disease Info in Firestore'),
//         ),
//     );
//   }
//
//   Future<void> updateDiseaseInFirestore(Disease disease) async {
//     try {
//       await diseasesCollection.doc(disease.id).update({
//         'name': disease.name,
//         'introduction': disease.introduction,
//         'type1Description': disease.type1Description,
//         'type2Description': disease.type2Description,
//         'gestationalDescription': disease.gestationalDescription,
//         'symptoms': disease.symptoms,
//         'managementAndTreatment': disease.managementAndTreatment,
//         'thingsToAvoid': disease.thingsToAvoid,
//       });
//
//       print('Disease updated in Firestore successfully!');
//     } catch (e) {
//       print('Error updating disease in Firestore: $e');
//     }
//   }
// }
