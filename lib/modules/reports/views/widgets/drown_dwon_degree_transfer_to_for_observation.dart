import 'package:flutter/material.dart';
import 'package:flutter_application_1/modules/reports/models/question_options_data_model.dart';

class DropDownDegreeTransferToButton extends StatefulWidget {
  const DropDownDegreeTransferToButton(
      {super.key,
      required this.list,
      required this.type,
      required this.selectFunc});
  final List<QuestionsOptionDModel> list;
  final String type;
  final Function(QuestionsOptionDModel selected) selectFunc;

  @override
  State<DropDownDegreeTransferToButton> createState() =>
      _DropDownDegreeTransferToButtonState();
}

class _DropDownDegreeTransferToButtonState
    extends State<DropDownDegreeTransferToButton> with AutomaticKeepAliveClientMixin{
  _DropDownDegreeTransferToButtonState();
  QuestionsOptionDModel? selected;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Text(widget.type),
        SizedBox(
          width: MediaQuery.of(context).size.width * .5,
          child: DropdownButton<QuestionsOptionDModel>(
            value: selected,
            onChanged: (newValue) {
              widget.selectFunc(newValue!);
            },
            items: widget.list.map<DropdownMenuItem<QuestionsOptionDModel>>(
                (QuestionsOptionDModel value) {
              return DropdownMenuItem<QuestionsOptionDModel>(
                value: value,
                child: Text(widget.type == 'Degree'
                    ? value.degreeName
                    : value.transferName),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
  
  @override
  bool get wantKeepAlive => true;
}
