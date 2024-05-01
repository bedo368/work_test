import 'package:flutter/material.dart';
import 'package:flutter_application_1/modules/reports/controllers/questin_cubit/question_cubit.dart';
import 'package:flutter_application_1/modules/reports/models/question_options_data_model.dart';
import 'package:flutter_application_1/modules/reports/models/question_options_model.dart';
import 'package:flutter_application_1/modules/reports/views/widgets/drown_dwon_degree_transfer_to_for_observation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SelectedOptionForObservationQ extends StatefulWidget {
  const SelectedOptionForObservationQ({super.key, required this.option});

  @override
  State<SelectedOptionForObservationQ> createState() =>
      _SelectedOptionForObservationQState();

  final QuestionOptionsModel option;
}

class _SelectedOptionForObservationQState
    extends State<SelectedOptionForObservationQ> {
  late List<QuestionsOptionDModel> optionData;
  late List<QuestionsOptionDModel> degreeList;
  late List<QuestionsOptionDModel> transferToList;
  @override
  void initState() {
    optionData = context
        .read<QuestionCubit>()
        .getQuestionOptionDataByQuestionOptionId(widget.option.qOID);
    degreeList = optionData
        .where(
          (element) => element.degreeName.isNotEmpty,
        )
        .toList();

    transferToList = optionData
        .where(
          (element) => element.transferName.isNotEmpty,
        )
        .toList();
    super.initState();
  }

  QuestionsOptionDModel? slectedOptionData;
  String? type;
  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () {
          showDialog(
              context: context,
              builder: (context) => Material(
                    color: Colors.white.withOpacity(0),
                    child: Center(
                      child: Card(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 40),
                          child: ListView(
                            shrinkWrap: true,
                            children: [
                              degreeList.isNotEmpty
                                  ? DropDownDegreeTransferToButton(
                                      key: UniqueKey(),
                                      list: degreeList,
                                      type: 'Degree',
                                      selectFunc: (selected) {
                                        setState(() {
                                          slectedOptionData = selected;
                                          type = 'Degree';
                                        });
                                        Navigator.pop(context);
                                      },
                                    )
                                  : const SizedBox(),
                              transferToList.isNotEmpty
                                  ? DropDownDegreeTransferToButton(
                                      key: UniqueKey(),
                                      list: transferToList,
                                      type: 'TransferTo',
                                      selectFunc: (selected) {
                                        setState(() {
                                          slectedOptionData = selected;
                                          type = 'TransferTo';
                                        });
                                        Navigator.pop(context);
                                      },
                                    )
                                  : const SizedBox()
                            ],
                          ),
                        ),
                      ),
                    ),
                  ));
        },
        child: Container(
          padding: const EdgeInsets.all(10),
          margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('${widget.option.answer}  '),
              Text(
                ' $type : ${slectedOptionData != null ? type != null ? type == 'Degree' ? slectedOptionData!.degreeName : slectedOptionData!.transferName : '' : ''}',
                style: const TextStyle(fontSize: 12, color: Colors.grey),
              )
            ],
          ),
        ));
  }
}