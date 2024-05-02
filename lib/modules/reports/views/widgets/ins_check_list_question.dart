import 'package:flutter/material.dart';
import 'package:flutter_application_1/modules/reports/models/question_model.dart';
import 'package:flutter_application_1/modules/reports/models/question_options_model.dart';

class InsCheckListQuestionWidget extends StatefulWidget {
  const InsCheckListQuestionWidget(
      {super.key,
      required this.question,
      required this.questionOptions,
      required this.onSelected});
  final QuestionModel question;
  final List<QuestionOptionsModel> questionOptions;
  final Function(dynamic quetionInfo) onSelected;

  @override
  State<InsCheckListQuestionWidget> createState() =>
      _InsCheckListQuestionWidgetState();
}

class _InsCheckListQuestionWidgetState extends State<InsCheckListQuestionWidget>
    with AutomaticKeepAliveClientMixin {
  QuestionOptionsModel? currentValue;

  @override
  void initState() {
    for (var q in widget.questionOptions) {
      if (q.defaultValue == '1') {
        currentValue = q;
        widget
            .onSelected({'question': widget.question, 'answer': currentValue});
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
              Expanded(child: Text(widget.question.qID)),
              widget.question.required != '1'
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
                return RadioListTile<QuestionOptionsModel>(
                  value: widget.questionOptions[index],
                  title: Text(widget.questionOptions[index].answer),
                  onChanged: (QuestionOptionsModel? value) {
                    setState(() {
                      currentValue = value!;
                      widget.onSelected({
                        'question': widget.question,
                        'answer': currentValue
                      });
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

  @override
  bool get wantKeepAlive => true;
}
