import 'dart:math';

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const Home());
  }
}

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('pull to edit'),
        ),
        body: const PullToEdit());
  }
}

class PullToEdit extends StatefulWidget {
  const PullToEdit({super.key});

  @override
  State<PullToEdit> createState() => _PullToEditState();
}

class _PullToEditState extends State<PullToEdit> {
  late ScrollController _controller;
  double negativeOffset = 0;
  @override
  void initState() {
    _controller = ScrollController()
      ..addListener(() {
        setState(() {
          negativeOffset = min(_controller.offset, 0).abs().toDouble();
        });
      });

    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: negativeOffset,
          width: MediaQuery.of(context).size.width,
          color: Colors.amber,
          child: AnimatedOpacity(
            opacity: negativeOffset > 150 ? 1 : 0,
            duration: const Duration(milliseconds: 100),
            child: const Icon(Icons.edit),
          ),
        ),
        ListView.builder(
          itemBuilder: (context, index) {
            return SizedBox(
              height: 100,
              child: Center(
                child: Text('item$index'),
              ),
            );
          },
          controller: _controller,
        ),
      ],
    );
  }
}
