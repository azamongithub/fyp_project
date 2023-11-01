import 'package:CoachBot/res/component/custom_button.dart';
import 'package:CoachBot/view_model/health/health_controller.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HealthDetails extends StatelessWidget {
  const HealthDetails({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    final userHealthStream = FirebaseFirestore.instance
        .collection('UserHealthCollection')
        .doc(user!.uid)
        .snapshots();

    return StreamBuilder<DocumentSnapshot>(
      stream: userHealthStream,
      builder: (ctx, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            // appBar: AppBar(
            //   title: const Text('Health Details'),
            // ),
            body: Center(child: CircularProgressIndicator()),
          );
        }

        if (!snapshot.hasData) {
          return const Scaffold(
            // appBar: AppBar(
            //   title: const Text('Health Details'),
            // ),
            body: Center(child: Text('No data available')),
          );
        }

        final userData = snapshot.data!.data() as Map<String, dynamic>?;

        return Scaffold(
          // appBar: AppBar(
          //   title: const Text('Health Details'),
          // ),
          body: ChangeNotifierProvider(
              create: (_) => HealthController(),
            child: Consumer<HealthController>(
              builder: (context, provider, child){
                return SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        const Text(
                          'Medical Condition:',
                          style: TextStyle(
                            fontSize: 24,
                            color: Colors.green,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          '${userData?['disease']?? ''}',
                          style: const TextStyle(
                            fontSize: 20,
                          ),
                        ),
                        const SizedBox(height: 20,),
                        // GestureDetector(
                        //   onTap: () {
                        //     provider.userHealthStatusDialogAlert(
                        //         context, userData?['disease']);
                        //   },
                        //
                        //   child: ElevatedButton(
                        //   child: Text('Update Disease'),
                        //     onPressed: () {  },
                        //   )
                        // ),
                        GestureDetector(
                          onTap: () {
                            provider.userHealthStatusDialogAlert(
                                context, userData?['disease']);
                          },
                          child: ElevatedButton(
                            child: const Text('Update Disease'),
                            onPressed: () {},
                          ),
                        ),



                      ],
                    ),
                  ),
                );
              }
            )
          )

        );
      },
    );
  }
}
