// import 'package:cloud_firestore/cloud_firestore.dart';
//
// class UserModel {
//   final String? id;
//   final String email;
//   final String password;
//   final String name;
//   final String address;
//   final String city;
//   final String age;
//   final String gender;
//   final String weight;
//   final String height;
//   final String disease;
//
//   const UserModel({
//     required this.id,
//     required this.email,
//     required this.password,
//     required this.name,
//     required this.address,
//     required this.city,
//     required this.age,
//     required this.gender,
//     required this.weight,
//     required this.height,
//     required this.disease,
//   });
//
//   factory UserModel.fromSnapshot(DocumentSnapshot snap){
//     //DocumentSnapshot<Map<String, dynamic>> document) {
//     var snapshot = snap.data() as Map<String,dynamic>;
//
//     //final data = document.data()!;
//     return UserModel(
//         id: snapshot['id'],
//         email: snapshot['email'],
//         password: 'password',
//         name: 'name',
//         address: 'address',
//         city: 'city',
//         age: 'age',
//         gender: 'gender',
//         weight: 'weight',
//         height: 'height',
//         disease: 'disease');
//   }
//
//   Map<String, dynamic> toJson() => {
//
//     "id": id,
//     "name": name,
//       "email": email,
//       "password": password,
//       "address": address,
//       "city": city,
//       "age": age,
//       "gender": gender,
//       "weight": weight,
//       "height": height,
//       "disease": disease,
//     };
//   }
//
// class ErrorModel {
//   final String emailError = 'Please enter your email';
//   final String passwordError = 'Please enter your password';
//   final String nameError = 'Please enter your name';
//   final String addressError = 'Please enter your address';
//   final String ageError = 'Please enter your age';
//   final String weightError = 'Please enter your weight';
//   final String heightError = 'Please enter your height';
// }
