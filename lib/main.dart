import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/modules/reports/api/server/fetch_all_api/fetch_all.dart';
import 'package:flutter_application_1/modules/reports/controllers/stage_cubit/stages_cubit.dart';
import 'package:flutter_application_1/modules/reports/views/screens/stage_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await FetchAllAndStoreInLocalStorage.init();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        scrollBehavior: const CupertinoScrollBehavior(),
        home: BlocProvider(
          create: (context) => StagesCubit()..getStagesFromLocalStorage(),
          child: const StageScreen(),
        ));
  }
}
