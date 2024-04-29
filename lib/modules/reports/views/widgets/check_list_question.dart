import 'package:flutter/material.dart';
import 'package:flutter_application_1/modules/reports/models/question_model.dart';
import 'package:flutter_application_1/modules/reports/models/question_options_model.dart';

class CheckListQuestionWidget extends StatefulWidget {
  const CheckListQuestionWidget({
    super.key,
    required this.question,
    required this.questionOptions,
  });
  final QuestionModel question;
  final List<QuestionOptionsModel> questionOptions;

  @override
  State<CheckListQuestionWidget> createState() =>
      _CheckListQuestionWidgetState();
}

class _CheckListQuestionWidgetState extends State<CheckListQuestionWidget> {
  String currentValue = '';
  @override
  @override
  Widget build(BuildContext context) {
    return ListView(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      children: [
        ListTile(
          title: Text(widget.question.qTitle),
          subtitle: ListView.separated(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return RadioListTile<String>(
                  value: widget.questionOptions[index].answer,
                  title: Text(widget.questionOptions[index].answer),
                  onChanged: (String? value) {
                    setState(() {
                      currentValue = value!;
                    });
                  },
                  groupValue: currentValue,
                );
              },
              separatorBuilder: (context, index) {
                return const SizedBox(
                  height: 10,
                );
              },
              itemCount: widget.questionOptions.length),
        )
      ],
    );
  }
}
