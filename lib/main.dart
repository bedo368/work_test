import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/modules/add_ticket/cubit/add_tickt_cubit.dart';
import 'package:flutter_application_1/modules/add_ticket/views/screens/add_tickt_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      scrollBehavior: const CupertinoScrollBehavior(),
      home: Scaffold(
          body: BlocProvider(
        create: (context) => AddTicktCubit()
          ..getDegreeList()
          ..getRefNomList(),
        child: const AddTicktScreen(),
      )),
    );
  }
}
