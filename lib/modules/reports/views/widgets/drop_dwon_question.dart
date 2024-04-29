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

class _DropDwonQuestionWidgetState extends State<DropDwonQuestionWidget> {
  QuestionOptionsModel? _selectedOption;
  @override
  void initState() {
    for (var o in widget.questionOptions) {
      print(o.toMap());
      if (o.defaultValue == '1') {
        _selectedOption = o;
      }
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final options = widget.questionOptions;
    return Column(
      children: [
        ListTile(title: Text(widget.question.qTitle)),
        DropdownButton<QuestionOptionsModel>(
          value: _selectedOption,
          onChanged: (newValue) {
            setState(() {
              _selectedOption = newValue!;
            });
          },
          items: options.map<DropdownMenuItem<QuestionOptionsModel>>(
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
}
