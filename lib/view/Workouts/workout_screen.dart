import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class WorkoutVideosList extends StatefulWidget {
  const WorkoutVideosList({Key? key}) : super(key: key);

  @override
  State<WorkoutVideosList> createState() => _WorkoutVideosListState();
}

class _WorkoutVideosListState extends State<WorkoutVideosList> {
  @override
  Widget build(BuildContext context) {



// Access the Firestore instance
    final FirebaseFirestore firestore = FirebaseFirestore.instance;

// Create a function to store the paragraph in Firestore
    Future<void> storeParagraph() async {
      // Create a reference to the document where you want to store the paragraph
      DocumentReference docRef = firestore.collection('your_collection').doc('your_document');

      // Store the paragraph in the "description" field
      await docRef.set({
      'description': '''
Equipment needed:
    1. A flat bench
    2. Two dumbbells of an appropriate weight for your fitness level

Instructions:
    1. Start by sitting on a flat bench with your 
        feet firmly planted on the floor.
        
    2. Pick up a dumbbell in each hand and 
        hold them at shoulder level, palms 
         facing forward.
    '''
      });
    }

// Call the function to store the paragraph
    storeParagraph();







    final auth = FirebaseAuth.instance;
    final videosStream =
        FirebaseFirestore.instance.collection('your_collection').snapshots();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Practice Exercises'),
      ),
      resizeToAvoidBottomInset: false,
      body: Column(
        children: [
          StreamBuilder<QuerySnapshot>(
            stream: videosStream,
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator();
              }
              if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              }
              if (snapshot.hasData) {
                return Expanded(
                  child: ListView.builder(
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            ListTile(
                              title: Text(
                                  snapshot.data!.docs[index]['title'].toString(),
                              style: TextStyle(
                                fontSize: 20,
                              ),
                              ),
                            ),
                            Text(snapshot.data!.docs[index]['description']
                                .toString(),
                            style: TextStyle(
                              fontSize: 20
                            )
                              ,),
                          ],
                        ),
                      );
                    },
                  ),
                );
              }
              return const Text('No data available');
            },
          ),
        ],
      ),
    );
  }
}
