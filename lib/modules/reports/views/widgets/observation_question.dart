import 'package:flutter/material.dart';
import 'package:flutter_application_1/modules/reports/models/question_model.dart';
import 'package:flutter_application_1/modules/reports/models/question_options_data_model.dart';
import 'package:flutter_application_1/modules/reports/models/question_options_model.dart';
import 'package:flutter_application_1/modules/reports/views/widgets/check_box_question_option_observation.dart';
import 'package:flutter_application_1/modules/reports/views/widgets/selected_option_for_observation_question.dart';

class ObesrvationQuestionWidget extends StatefulWidget {
  const ObesrvationQuestionWidget({
    super.key,
    required this.question,
    required this.questionOptions,
    required this.onSelected,
  });
  final QuestionModel question;
  final List<QuestionOptionsModel> questionOptions;
  final Function(dynamic quetionInfo) onSelected;

  @override
  State<ObesrvationQuestionWidget> createState() =>
      _ObesrvationQuestionWidgetState();
}

class _ObesrvationQuestionWidgetState extends State<ObesrvationQuestionWidget> {
  List<QuestionsOptionDModel> currentSelectedOptionData = [];

  @override
  void initState() {
    super.initState();
  }

  List<QuestionOptionsModel> _selectedOption = [];
  @override
  Widget build(BuildContext context) {
    return ListView(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(child: Text(widget.question.qTitle)),
              Column(
                children: [
                  IconButton(
                      onPressed: () {
                        if (_selectedOption.isEmpty) {
                          showSelectOptionDialog(context);
                        } else {
                          setState(() {
                            _selectedOption = [];
                            currentSelectedOptionData = [];
                            widget.onSelected(
                                {'question': widget.question, 'answer': null});
                          });
                        }
                      },
                      icon: _selectedOption.isEmpty
                          ? const Icon(Icons.add)
                          : const Icon(Icons.cancel)),
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
              )
            ],
          ),
          _selectedOption.isNotEmpty
              ? ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    return SelectedOptionForObservationQ(
                      onSelectOptionData: (optiondata) {
                        currentSelectedOptionData.add(optiondata);

                        if (_selectedOption.length ==
                            currentSelectedOptionData.length) {
                          widget.onSelected({
                            'question': widget.question,
                            'answer': {
                              'option': _selectedOption,
                              'optionData': currentSelectedOptionData
                            }
                          });
                        }
                      },
                      option: _selectedOption[index],
                    );
                  },
                  separatorBuilder: (context, index) => Container(
                      margin: const EdgeInsets.symmetric(horizontal: 20),
                      child: const Divider()),
                  itemCount: _selectedOption.length)
              : const SizedBox(),
        ]);
  }

  Future<dynamic> showSelectOptionDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (context) => Material(
              color: Colors.white.withOpacity(0),
              child: Center(
                child: Card(
                  child: ListView(
                    shrinkWrap: true,
                    children: [
                      CheckBoxQuestionOptionWidget(
                        questionOptions: widget.questionOptions,
                        onSelect: (List<QuestionOptionsModel> selected) {
                          setState(() {
                            _selectedOption = selected;
                          });
                        },
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          SizedBox(
                            width: MediaQuery.of(context).size.width * .3,
                            child: TextButton(
                                onPressed: () {
                                  widget.onSelected({
                                    'question': widget.question,
                                    'answer': null
                                  });
                                  Navigator.of(context).pop();
                                },
                                style: ElevatedButton.styleFrom(
                                    backgroundColor:
                                        const Color.fromARGB(255, 134, 0, 67)),
                                child: const Text(
                                  'Clear',
                                  style: TextStyle(color: Colors.white),
                                )),
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * .3,
                            child: TextButton(
                                onPressed: () {
                                  setState(() {});
                                  Navigator.of(context).pop();
                                },
                                style: ElevatedButton.styleFrom(
                                    backgroundColor:
                                        const Color.fromARGB(255, 134, 0, 67)),
                                child: const Text(
                                  'Save',
                                  style: TextStyle(color: Colors.white),
                                )),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ));
  }
}
