import 'package:flutter/material.dart';
import 'package:flutter_application_1/modules/reports/controllers/questin_cubit/question_cubit.dart';
import 'package:flutter_application_1/modules/reports/controllers/section_cubit/sections_cubit.dart';
import 'package:flutter_application_1/modules/reports/models/stage_models.dart';
import 'package:flutter_application_1/modules/reports/views/screens/question_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SectionScreen extends StatelessWidget {
  const SectionScreen({super.key, required this.stage});
  final StageModel stage;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<SectionsCubit>(
        create: (context) =>
            SectionsCubit()..fetchSectionByStageId(stageId: stage.stageID),
        child: BlocConsumer<SectionsCubit, SectionsState>(
          listener: (context, state) {},
          builder: (context, state) {
            final sectionCubit = context.read<SectionsCubit>();

            return Scaffold(
              appBar: AppBar(
                title: Text(stage.stageName),
              ),
              body: ListView.separated(
                  itemBuilder: (context, index) {
                    return state is SectionsLoadingState
                        ? const CircularProgressIndicator()
                        : TextButton(
                            onPressed: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (contet) => BlocProvider(
                                        create: (context) => QuestionCubit()
                                          ..fetchQuestionAndQutionDataBySectionId(
                                            sectionId: sectionCubit
                                                .section[index].sectionID,
                                          ),
                                        child: QuestionScreen(
                                          section: sectionCubit.section[index],
                                        ),
                                      )));
                            },
                            child:
                                Text(sectionCubit.section[index].sectionName));
                  },
                  separatorBuilder: (context, index) {
                    return const Divider();
                  },
                  itemCount: sectionCubit.section.length),
            );
          },
        ));
  }
}
