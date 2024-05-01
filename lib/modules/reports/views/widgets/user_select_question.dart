import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/modules/reports/controllers/questin_cubit/question_cubit.dart';
import 'package:flutter_application_1/modules/reports/models/question_model.dart';
import 'package:flutter_application_1/modules/reports/models/question_options_data_model.dart';
import 'package:flutter_application_1/modules/reports/models/question_options_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserSelectQuestionWidget extends StatefulWidget {
  const UserSelectQuestionWidget({
    super.key,
    required this.question,
    required this.questionOptions,
  });
  final QuestionModel question;
  final List<QuestionOptionsModel> questionOptions;

  @override
  State<UserSelectQuestionWidget> createState() =>
      _UserSelectQuestionWidgetState();
}

class _UserSelectQuestionWidgetState extends State<UserSelectQuestionWidget>
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

  QuestionsOptionDModel? _selected;

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
          subtitle: ListView.separated(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return RadioListTile<QuestionOptionsModel>(
                  value: widget.questionOptions[index],
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('${widget.questionOptions[index].answer} '),
                      Text(_selected != null
                          ? _selected!.oID == widget.questionOptions[index].qOID
                              ? _selected!.degreeName
                              : ''
                          : '')
                    ],
                  ),
                  onChanged: (QuestionOptionsModel? value) {
                    final currentSelectQuestionOptiondata = context
                        .read<QuestionCubit>()
                        .getQuestionOptionDataByQuestionOptionId(
                            widget.questionOptions[index].qOID);

                    showCupertinoModalPopup(
                        context: context,
                        builder: (context) => CupertinoActionSheet(
                            cancelButton: TextButton(
                              onPressed: () {
                                setState(() {
                                  _selected = null;
                                  Navigator.pop(context);
                                });
                              },
                              child: const Text('Cancel'),
                            ),
                            actions: List.generate(
                              currentSelectQuestionOptiondata.length,
                              (index) => CupertinoActionSheetAction(
                                isDefaultAction:
                                    currentSelectQuestionOptiondata[index] ==
                                            _selected
                                        ? true
                                        : false,
                                onPressed: () {
                                  setState(() {
                                    currentValue = value;
                                    _selected =
                                        currentSelectQuestionOptiondata[index];
                                  });
                                  Navigator.pop(context);
                                },
                                child: Text(
                                  currentSelectQuestionOptiondata[index]
                                      .degreeName,
                                  style: const TextStyle(color: Colors.black),
                                ),
                              ),
                            )));
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
