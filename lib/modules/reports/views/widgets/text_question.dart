import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/common/widgets/custom_text_filed.dart';
import 'package:flutter_application_1/modules/reports/models/question_model.dart';
import 'package:flutter_application_1/modules/reports/models/question_options_model.dart';

class TextQuestionWidget extends StatefulWidget {
  const TextQuestionWidget({
    super.key,
    required this.question,
    required this.onSelected,
  });
  final QuestionModel question;
  final Function(dynamic quetionInfo) onSelected;

  @override
  State<TextQuestionWidget> createState() => _TextQuestionWidgetState();
}

class _TextQuestionWidgetState extends State<TextQuestionWidget>
    with AutomaticKeepAliveClientMixin {
  QuestionOptionsModel? currentValue;
  final questionController = TextEditingController();

  String textValue = '';
  @override
  void dispose() {
    questionController.dispose();
    super.dispose();
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
            subtitle: CustomTextField(
              controller: questionController,
              onChanged: (p0) {
                if (p0 == '') {
                  widget.onSelected(
                      {'question': widget.question, 'answer': null});
                  return;
                }
                textValue = questionController.text;
                widget.onSelected(
                    {'question': widget.question, 'answer': textValue});
              },
            ))
      ],
    );
  }

  @override
  bool get wantKeepAlive => true;
}
