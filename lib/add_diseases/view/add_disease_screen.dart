import 'package:CoachBot/common_components/disease_text_field.dart';
import 'package:CoachBot/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DynamicField {
  String name;
  String value;
  DynamicField({required this.name, required this.value});
}

class DiseaseForm extends StatefulWidget {
  @override
  _DiseaseFormState createState() => _DiseaseFormState();
}

class _DiseaseFormState extends State<DiseaseForm> {
  List<DynamicField> dynamicFields = [];
  TextEditingController _nameController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();
  final _formKey = GlobalKey<FormState>(); // Add a GlobalKey for the form

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Disease'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.sp),
        child: Form(
          key: _formKey, // Assign the key to the form
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              DiseaseTextField(
                labelText: 'Disease Name',
                myController: _nameController,
                onValidator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the disease name';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20.h),
              DiseaseTextField(
                labelText: 'Description',
                myController: _descriptionController,
                onValidator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the description';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20.h),
              Column(
                children: dynamicFields.asMap().entries.map((entry) {
                  DynamicField field = entry.value;
                  return Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(right: 110.w),
                        child: DiseaseTextField(
                          labelText: 'Field Name',
                          onChange: (value) {
                            field.name = value;
                          },
                          onValidator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter this field name';
                            }
                            return null;
                          },
                        ),
                      ),
                      SizedBox(height: 20.h),
                      DiseaseTextField(
                        labelText: 'Field Value',
                        onChange: (value) {
                          field.value = value;
                        },
                        onValidator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter this field value';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 30.h),
                    ],
                  );
                }).toList(),
              ),
              SizedBox(height: 10.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        _addDynamicField();
                      } else {
                        return Utils.negativeToastMessage(
                            'Please enter empty fields first');
                      }
                    },
                    child: Text('Add New Field'),
                  ),
                  SizedBox(width: 10.w),
                  ElevatedButton(
                    onPressed: () {
                      _removeDynamicField();
                      // if(dynamicFields.first.value.isEmpty){
                      //
                      // }
                      // else if (dynamicFields.first.value.isNotEmpty){
                      //   Utils.negativeToastMessage('Filled fields cannot be deleted');
                      // }
                      // else if (dynamicFields.length==0){
                      //   print('xyzxyz');
                      //   Utils.negativeToastMessage('No fields to delete');
                      // }
                      // else {
                      //   Utils.negativeToastMessage('Something went wrong');
                      // }
                    },
                    child: Text('Remove Last Field'),
                  ),
                ],
              ),
              SizedBox(height: 10),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState?.validate() ?? false) {
                    // Only proceed if the form is valid
                    _submitForm();
                  }
                },
                child: Text('Upload Disease to Firebase'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _addDynamicField() {
    setState(() {
      dynamicFields.add(DynamicField(name: '', value: ''));
    });
  }

  void _removeDynamicField() {
    setState(() {
      dynamicFields.removeLast();
    });
  }

  void _submitForm() {
    Map<String, dynamic> diseaseData = {
      'name': _nameController.text,
      'description': _descriptionController.text,
      'date': DateTime.now(),
    };

    for (var field in dynamicFields) {
      if (field.name.isNotEmpty) {
        if (field.value.contains('&')) {
          List<String> values =
              field.value.split('&').map((s) => s.trim()).toList();
          diseaseData[field.name.toLowerCase()] = values;
        } else {
          diseaseData[field.name.toLowerCase()] = field.value;
        }
      }
    }

    String diseaseId = _nameController.text;
    FirebaseFirestore.instance
        .collection('AllDiseasesInfo')
        .doc(diseaseId)
        .set(diseaseData)
        .then((value) {
      Utils.positiveToastMessage('$diseaseId Successfully Uploaded to Firestore');
      print('$diseaseId Successfully Uploaded to Firestore');
    }).catchError((error) {
      Utils.negativeToastMessage('Error adding disease to Firestore');
      print('Error adding disease to Firestore: $error');
    });
  }
}
