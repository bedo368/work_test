import 'package:flutter/material.dart';
import 'package:flutter_application_1/modules/reports/models/question_model.dart';
import 'package:flutter_application_1/modules/reports/models/question_options_model.dart';

class DropDwonQuestionWidget extends StatefulWidget {
  const DropDwonQuestionWidget(
      {super.key, required this.question, required this.questionOptions});
  final QuestionModel question;
  final List<QuestionOptionsModel> questionOptions;
  @override
  State<DropDwonQuestionWidget> createState() => _DropDwonQuestionWidgetState();
}

class _DropDwonQuestionWidgetState extends State<DropDwonQuestionWidget>
    with AutomaticKeepAliveClientMixin {
  QuestionOptionsModel? _selectedOption;

  @override
  void initState() {
    for (var o in widget.questionOptions) {
      if (o.defaultValue == '1') {
        _selectedOption = o;
      }
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Column(
      children: [
        ListTile(
            title: Row(
          children: [
            Expanded(child: Text(widget.question.qTitle)),
            widget.question.required != '1'
                ? const Text('not required',
                    style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w400,
                        color: Colors.grey))
                : const SizedBox(),
          ],
        )),
        DropdownButton<QuestionOptionsModel>(
          value: _selectedOption,
          onChanged: (newValue) {
            setState(() {
              _selectedOption = newValue!;
              print('sure that extiontion work ');
            });
          },
          items: widget.questionOptions
              .map<DropdownMenuItem<QuestionOptionsModel>>(
                  (QuestionOptionsModel value) {
            return DropdownMenuItem<QuestionOptionsModel>(
              value: value,
              child: Text(value.answer),
            );
          }).toList(),
        ),
      ],
    );
  }

  @override
  bool get wantKeepAlive => true;
}
