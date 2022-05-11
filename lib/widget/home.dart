import 'package:countdown/provider/login.dart';
import 'package:flutter/material.dart';
import 'package:timer_count_down/timer_count_down.dart';
import 'package:english_words/english_words.dart';
import 'package:timer_count_down/timer_controller.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final CountdownController _controller = CountdownController(autoStart: true);

  String temp = ' ';

  bool isCounting = true;

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<LogIn>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("countdown"),
        actions: [
          IconButton(
            onPressed: () {
              provider.logout();
            },
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      body: Center(
        child: Countdown(
          controller: _controller,
          seconds: 5,
          build: (BuildContext context, double time) => Text(
              isCounting == true ? time.toString() : temp.substring(1, 6),
              style: TextStyle(fontSize: 50)),
          interval: const Duration(milliseconds: 100),
          onFinished: () {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Timer is done!'),
              ),
            );
            generateWordPairs().take(1).forEach(
              (element) {
                setState(() {
                  temp = element.asString;
                  isCounting = false;
                });
              },
            );
          },
        ),
      ),
    );
  }
}
