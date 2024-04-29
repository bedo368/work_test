import 'package:flutter/material.dart';
import 'package:flutter_application_1/modules/reports/controllers/section_cubit/sections_cubit.dart';
import 'package:flutter_application_1/modules/reports/controllers/stage_cubit/stages_cubit.dart';
import 'package:flutter_application_1/modules/reports/views/screens/sections_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class StageScreen extends StatelessWidget {
  const StageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: BlocConsumer<StagesCubit, StagesState>(
      listener: (context, state) {},
      builder: (context, state) {
        final stagecubit = context.read<StagesCubit>();
        return ListView.separated(
          separatorBuilder: (context, index) {
            return const Divider(
              color: Colors.black,
            );
          },
          itemBuilder: (context, index) {
            return state is StagesLoadingState
                ? const CircularProgressIndicator()
                : TextButton(
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => SectionScreen(
                          stage: stagecubit.stages[index],
                        ),
                      ));
                    },
                    child: Text(stagecubit.stages[index].stageName));
          },
          itemCount: stagecubit.stages.length,
        );
      },
    ));
  }
}
