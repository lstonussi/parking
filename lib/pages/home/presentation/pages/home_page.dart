import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({
    Key? key,
    required this.name,
    required this.quantitySpace,
  }) : super(key: key);

  final String name;
  final int quantitySpace;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(name)),
      body: LayoutBuilder(
        builder: (_, contraints) => Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: (contraints.maxWidth * .1),
              ),
              child: Text(
                quantitySpace.toString(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
