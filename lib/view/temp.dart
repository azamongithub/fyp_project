import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

// class YoutubeVideoPlayerScreen extends StatefulWidget {
//   const YoutubeVideoPlayerScreen({super.key});
//
//   @override
//   State<YoutubeVideoPlayerScreen> createState() => _YoutubeVideoPlayerScreenState();
// }
//
// class _YoutubeVideoPlayerScreenState extends State<YoutubeVideoPlayerScreen> {
//   final videoURL = 'https://www.youtube.com/watch?v=FAyKDaXEAgc';
//
//   late YoutubePlayerController _controller;
//
//   @override
//   void initState() {
//     final videoID = YoutubePlayer.convertUrlToId(videoURL);
//
//     _controller = YoutubePlayerController(
//         initialVideoId: videoID!,
//         flags: const YoutubePlayerFlags(
//           autoPlay: false,
//         ),
//     );
//     super.initState();
//   }
//
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('a'),
//       ),
//       body: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           YoutubePlayer(
//               controller: _controller,
//             showVideoProgressIndicator: true,
//           ),
//         ],
//       ),
//     );
//   }
// }

//
// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:youtube_player_flutter/youtube_player_flutter.dart';
//
// class YoutubeVideoPlayerScreen extends StatefulWidget {
//   @override
//   _YoutubeVideoPlayerScreenState createState() =>
//       _YoutubeVideoPlayerScreenState();
// }
//
// class _YoutubeVideoPlayerScreenState extends State<YoutubeVideoPlayerScreen> {
//   late YoutubePlayerController _controller;
//   bool _isLoading = true;
//   String _videoTitle = '';
//
//   @override
//   void initState() {
//     super.initState();
//     _fetchWorkoutData();
//   }
//
//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }
//
//   Future<void> _fetchWorkoutData() async {
//     try {
//       final DocumentSnapshot snapshot = await FirebaseFirestore.instance
//           .collection('workouts')
//           .doc('ch01')
//           .get();
//
//       final dynamic data = snapshot.data();
//
//       if (data is Map<String, dynamic>) {
//         final String videoUrl = data['video1'] ?? '';
//         _videoTitle = data['title'] ?? '';
//
//         final String? videoId = YoutubePlayer.convertUrlToId(videoUrl);
//
//         if (videoId != null) {
//           _controller = YoutubePlayerController(
//             initialVideoId: videoId,
//             flags: YoutubePlayerFlags(
//               autoPlay: true,
//               mute: false,
//               hideControls: true,
//               loop: true,
//               isLive: false,
//               enableCaption: false,
//               disableDragSeek: true,
//               forceHD: true,
//             ),
//           );
//
//           setState(() {
//             _isLoading = false;
//           });
//         } else {
//           setState(() {
//             _isLoading = false;
//           });
//           // Handle invalid YouTube video URL
//         }
//       } else {
//         setState(() {
//           _isLoading = false;
//         });
//         // Handle document data not found or invalid
//       }
//     } catch (error) {
//       setState(() {
//         _isLoading = false;
//       });
//       // Handle error fetching Firestore data
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('YouTube Video Player'),
//       ),
//       body: _isLoading
//           ? const Center(
//         child: CircularProgressIndicator(),
//       )
//           : Column(
//         crossAxisAlignment: CrossAxisAlignment.center,
//         children: [
//           SizedBox(height: 20),
//           Text(
//             _videoTitle,
//             style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//           ),
//           SizedBox(height: 20),
//           _controller != null
//               ? YoutubePlayerBuilder(
//             player: YoutubePlayer(
//               controller: _controller,
//               progressIndicatorColor: Colors.blueAccent,
//               progressColors: ProgressBarColors(
//                 playedColor: Colors.blue,
//                 handleColor: Colors.blueAccent,
//               ),
//             ),
//             builder: (context, player) {
//               return Column(
//                 children: [
//                   player,
//                   SizedBox(height: 50),
//                 ],
//               );
//             },
//           )
//               : const Text('Failed to load video'),
//         ],
//       ),
//     );
//   }
// }




import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class YoutubeVideoPlayerScreen extends StatefulWidget {
  @override
  _YoutubeVideoPlayerScreenState createState() =>
      _YoutubeVideoPlayerScreenState();
}

class _YoutubeVideoPlayerScreenState extends State<YoutubeVideoPlayerScreen> {
  late YoutubePlayerController _controller;
  bool _isLoading = true;
  String _videoTitle = '';

  @override
  void initState() {
    super.initState();
    _fetchWorkoutData();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _fetchWorkoutData() async {
    try {
      final DocumentSnapshot snapshot = await FirebaseFirestore.instance
          .collection('workouts')
          .doc('ch01')
          .get();

      final dynamic data = snapshot.data();

      if (data is Map<String, dynamic>) {
        final String videoUrl = data['video1'] ?? '';
        _videoTitle = data['title'] ?? '';

        final String? videoId = YoutubePlayer.convertUrlToId(videoUrl);

        if (videoId != null) {
          _controller = YoutubePlayerController(
            initialVideoId: videoId,
            flags: YoutubePlayerFlags(
              autoPlay: true,
              mute: false,
              hideControls: true,
              disableDragSeek: true,
              loop: true,
              isLive: false,
            ),
          );

          setState(() {
            _isLoading = false;
          });
        } else {
          setState(() {
            _isLoading = false;
          });
          // Handle invalid YouTube video URL
        }
      } else {
        setState(() {
          _isLoading = false;
        });
        // Handle document data not found or invalid
      }
    } catch (error) {
      setState(() {
        _isLoading = false;
      });
      // Handle error fetching Firestore data
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('YouTube Video Player'),
      ),
      body: _isLoading
          ? const Center(
        child: CircularProgressIndicator(),
      )
          : Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: 20),
          Text(
            _videoTitle,
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 20),
          _controller != null
              ? YoutubePlayer(
            controller: _controller,
            showVideoProgressIndicator: true,
            progressIndicatorColor: Colors.blueAccent,
            onReady: () {
              _controller.play();
            },
          )
              : const Text('Failed to load video'),
        ],
      ),
    );
  }
}
