import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_application_1/modules/reports/controllers/questin_cubit/question_cubit.dart';
import 'package:flutter_application_1/modules/reports/models/question_options_data_model.dart';
import 'package:flutter_application_1/modules/reports/models/question_options_model.dart';
import 'package:flutter_application_1/modules/reports/views/widgets/drown_dwon_degree_transfer_to_for_observation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SelectedOptionForObservationQ extends StatefulWidget {
  const SelectedOptionForObservationQ(
      {super.key,
      required this.option,
      required this.onSelectOptionData,
      required this.removeSelectedOptionData});
  final Function(QuestionsOptionDModel optionData) onSelectOptionData;
  final Function(QuestionOptionsModel option) removeSelectedOptionData;
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
          // TODO : if i want the user to be able to change the selected value without cancel the whole question
          // if (slectedOptionData != null) {
          //   return;
          // }
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
                                          widget.onSelectOptionData(
                                              slectedOptionData!);
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
                                          widget.onSelectOptionData(
                                              slectedOptionData!);
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
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(10),
                margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('${widget.option.answer}  '),
                    Text(
                      ' ${type ?? 'please answer the selected option'} : ${slectedOptionData != null ? type != null ? type == 'Degree' ? slectedOptionData!.degreeName : slectedOptionData!.transferName : '' : ''}',
                      style: const TextStyle(fontSize: 12, color: Colors.grey),
                    )
                  ],
                ),
              ),
            ),
            IconButton(
                onPressed: () {
                  widget.removeSelectedOptionData(widget.option);
                },
                icon: Icon(Icons.cancel))
          ],
        ));
  }
}
