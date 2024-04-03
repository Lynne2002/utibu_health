import 'package:flutter/material.dart';
import 'dart:async';

//import 'package:get_it/get_it.dart';
class SplashPage extends StatefulWidget {
  final VoidCallback onInitializationComplete;

  const SplashPage({
    required Key key,
    required this.onInitializationComplete,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _SplashPageState();
  }
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      Timer(const Duration(seconds: 10), () {
        widget.onInitializationComplete();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Medify',
      theme: ThemeData(
        scaffoldBackgroundColor: const Color.fromRGBO(0, 194, 203, 1),
        colorScheme:
            const ColorScheme.light(background: Color.fromRGBO(0, 194, 203, 1)),
      ),
      home: Builder(
        builder: (BuildContext context) {
          return Scaffold(
            body: Center(
              child: Container(
                height: 200,
                width: 200,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    fit: BoxFit.contain,
                    image: AssetImage('assets/images/Medify.png'),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
