import 'package:flutter/material.dart';
import 'package:flutter_application_1/modules/reports/controllers/questin_cubit/question_cubit.dart';
import 'package:flutter_application_1/modules/reports/models/section_model.dart';
import 'package:flutter_application_1/modules/reports/views/widgets/check_list_question.dart';
import 'package:flutter_application_1/modules/reports/views/widgets/select_question_by_type.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class QuestionScreen extends StatelessWidget {
  const QuestionScreen({super.key, required this.section});
  final SectionModel section;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<QuestionCubit, QuestionState>(
      listener: (context, state) {},
      builder: (context, state) {
        final questionCubit = context.read<QuestionCubit>();
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.blueAccent,
            title: Text(section.sectionName),
          ),
          body: state is QuestionLoadingState
              ? const Center(child: CircularProgressIndicator())
              : ListView.separated(
                  itemBuilder: (context, index) {
                    return selectQuestionByType(
                      question: questionCubit.questions[index],
                      qOption: questionCubit.questionOption
                          .where((element) =>
                              element.qID == questionCubit.questions[index].qID)
                          .toList(),
                    );
                  },
                  separatorBuilder: (context, index) {
                    return const Divider();
                  },
                  itemCount: questionCubit.questions.length),
        );
      },
    );
  }
}
