import 'package:flutter/material.dart';
import 'package:flutter_application_1/modules/reports/models/question_options_model.dart';

class CheckBoxQuestionOptionWidget extends StatefulWidget {
  const CheckBoxQuestionOptionWidget({
    super.key,
    required this.questionOptions,
    required this.onSelect,
  });
  final List<QuestionOptionsModel> questionOptions;
  final Function(List<QuestionOptionsModel> selected) onSelect;

  @override
  State<CheckBoxQuestionOptionWidget> createState() =>
      _CheckBoxQuestionOptionWidgetState();
}

class _CheckBoxQuestionOptionWidgetState
    extends State<CheckBoxQuestionOptionWidget>
    with AutomaticKeepAliveClientMixin {
  QuestionOptionsModel? currentValue;

  @override
  void initState() {
    for (var q in widget.questionOptions) {
      if (q.defaultValue == '1') {
        currentValue = q;
      }
    }

    super.initState();
  }

  final List<QuestionOptionsModel> _selectedAnswer = [];
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return ListView(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      children: [
        ListTile(
          title: const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
          ),
          subtitle: ListView.separated(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return CheckboxListTile(
                    selected: currentValue != null,
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
                        } else {
                          _selectedAnswer.add(widget.questionOptions[index]);
                        }
                        widget.onSelect(_selectedAnswer);
                      });
                      print(_selectedAnswer);
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
