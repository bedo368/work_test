import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: ListView.separated(
        separatorBuilder: (context, index) => const SizedBox(
          height: 10,
        ),
        itemCount: 20,
        itemBuilder: (BuildContext context, int index) {
          return Container(
            height: 50,
            width: 120,
            color: Colors.amber,
          );
        },
      ),
    );
  }
}
