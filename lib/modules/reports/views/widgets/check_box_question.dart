import 'package:flutter/material.dart';
import 'package:flutter_application_1/modules/reports/models/question_model.dart';
import 'package:flutter_application_1/modules/reports/models/question_options_model.dart';

class CheckBoxQuestionWidget extends StatefulWidget {
  const CheckBoxQuestionWidget({
    super.key,
    required this.question,
    required this.questionOptions,
    required this.onSelected,
  });
  final QuestionModel question;
  final List<QuestionOptionsModel> questionOptions;
  final Function(dynamic quetionInfo) onSelected;

  @override
  State<CheckBoxQuestionWidget> createState() => _CheckBoxQuestionWidgetState();
}

class _CheckBoxQuestionWidgetState extends State<CheckBoxQuestionWidget>
    with AutomaticKeepAliveClientMixin {
  QuestionOptionsModel? currentValue;
  final List<QuestionOptionsModel> _selectedAnswer = [];

  @override
  void initState() {
    for (var q in widget.questionOptions) {
      if (q.defaultValue == '1') {
        currentValue = q;
        _selectedAnswer.add(q);
        widget.onSelected(
            {'question': widget.question, 'answer': _selectedAnswer});
      }
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return ListView(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      children: [
        ListTile(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(child: Text(widget.question.qTitle)),
              widget.question.required == '1'
                  ? const Align(
                      alignment: Alignment.topRight,
                      child: Text(
                        'not required',
                        style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w400,
                            color: Colors.grey),
                      ),
                    )
                  : const SizedBox(),
            ],
          ),
          subtitle: ListView.separated(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return CheckboxListTile(
                    title: Text(widget.questionOptions[index].answer ?? ''),
                    value:
                        _selectedAnswer.contains(widget.questionOptions[index]),
                    onChanged: (v) {
                      setState(() {
                        if (_selectedAnswer
                            .contains(widget.questionOptions[index])) {
                          _selectedAnswer.removeWhere((element) =>
                              element.qOID ==
                              widget.questionOptions[index].qOID);
                          widget.onSelected({
                            'question': widget.question,
                            'answer': _selectedAnswer
                          });
                        } else {
                          _selectedAnswer.add(widget.questionOptions[index]);
                          widget.onSelected({
                            'question': widget.question,
                            'answer': _selectedAnswer
                          });
                        }
                      });
                    });
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

  @override
  bool get wantKeepAlive => true;
}
