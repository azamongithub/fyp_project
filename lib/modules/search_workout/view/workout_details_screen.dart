import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class WorkoutDetailsScreen extends StatefulWidget {
  final String workoutName;
  final String youtubeLink;
  final List<String> steps;
  final String time;
  final int reps;
  final String difficultyLevel;
  final List<String> equipments;
  final String instructions;

  const WorkoutDetailsScreen({
    super.key,
    required this.workoutName,
    required this.youtubeLink,
    required this.steps,
    required this.time,
    required this.reps,
    required this.difficultyLevel,
    required this.equipments,
    required this.instructions,
  });

  @override
  _WorkoutDetailsScreenState createState() => _WorkoutDetailsScreenState();
}

class _WorkoutDetailsScreenState extends State<WorkoutDetailsScreen> {
  late YoutubePlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = YoutubePlayerController(
      initialVideoId: YoutubePlayer.convertUrlToId(widget.youtubeLink) ?? '',
      flags: const YoutubePlayerFlags(
        autoPlay: true,
        mute: true,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.workoutName),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          YoutubePlayer(
            controller: _controller,
            showVideoProgressIndicator: true,
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Steps:\n ${widget.steps.join('\n ')}'),
                Text('Time: ${widget.time}'),
                Text('Reps: ${widget.reps}'),
                Text('Difficulty Level: ${widget.difficultyLevel}'),
                Text('Equipments: ${widget.equipments.join(', ')}'),
                Text('Instructions: ${widget.instructions}'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
