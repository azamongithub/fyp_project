import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class DeleteAccountScreen extends StatefulWidget {
  @override
  _DeleteAccountScreenState createState() => _DeleteAccountScreenState();
}

class _DeleteAccountScreenState extends State<DeleteAccountScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  bool _isDeleting = false;

  void _deleteAccount() async {
    setState(() {
      _isDeleting = true;
    });

    try {
      // Get the current user
      final User? user = _auth.currentUser;

      if (user != null) {
        final userId = user.uid;

        // Delete user document
        await FirebaseFirestore.instance.collection('users').doc(userId).delete();
        // Delete additional user details document if exists
        await FirebaseFirestore.instance.collection('UserProfileCollection').doc(userId).delete();
        // You can delete additional subcollections if needed
        // await FirebaseFirestore.instance.collection('users').doc(userId).collection('subcollection').get().then((snapshot) {
        //   for (DocumentSnapshot ds in snapshot.docs) {
        //     ds.reference.delete();
        //   }
        // });

        // Delete the user's authentication account
        await user.delete();

        // Account deletion successful
        showDialog(
          context: context,
          builder: (_) => AlertDialog(
            title: Text('Account Deleted'),
            content: Text('Your account has been successfully deleted.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  // Navigate to the login screen or home screen after account deletion
                },
                child: Text('OK'),
              ),
            ],
          ),
        );
      } else {
        // User is not logged in
        showDialog(
          context: context,
          builder: (_) => AlertDialog(
            title: Text('Error'),
            content: Text('No user found. Please log in and try again.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('OK'),
              ),
            ],
          ),
        );
      }
    } catch (e) {
      // Handle error
      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: Text('Error'),
          content: Text('An error occurred while deleting your account. Please try again later.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('OK'),
            ),
          ],
        ),
      );
    } finally {
      setState(() {
        _isDeleting = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Delete Account'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Are you sure you want to delete your account?',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _isDeleting ? null : _deleteAccount,
              child: _isDeleting ? CircularProgressIndicator() : Text('Delete Account'),
            ),
          ],
        ),
      ),
    );
  }
}
