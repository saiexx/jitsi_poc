import 'dart:async';

import 'package:flutter/material.dart';
import 'package:jitsi_meet_flutter_sdk/jitsi_meet_flutter_sdk.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  final jitsiMeet = JitsiMeet();

  void join() {
    var option = JitsiMeetConferenceOptions(
      serverURL: 'https://meet.jit.si/',
      room: 'jitsi-poc-synz-d445881f-36c7-4dd8-bc69-b58ce158b91d',
      configOverrides: {
        "startWithAudioMuted": false,
        "startWithVideoMuted": false,
        "subject" : "POC",
      },
      featureFlags: {
        "unsaferoomwarning.enabled": false
      },
      userInfo: JitsiMeetUserInfo(
          displayName: "Flutter user",
          email: "user@example.com"
      ),
    );
    startTimer();
    jitsiMeet.join(option);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: FilledButton(
          onPressed: join, 
          child: const Text("Join"),
          )
      ),
    );
  }

  void startTimer() {
    // Timer(const Duration(seconds: 10), handleTimeout);
  }

  void handleTimeout() {
    jitsiMeet.hangUp();
  }
}
