import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Parking')),
      body: LayoutBuilder(
        builder: (_, contraints) => Column(
          children: [
            Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: (contraints.maxWidth * .1),
                ),
                child: Container()),
          ],
        ),
      ),
    );
  }
}
