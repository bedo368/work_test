import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/common/widgets/custom_text_filed.dart';

class FormTexTFildes extends StatelessWidget {
  const FormTexTFildes({
    super.key,
    required this.type,
    required TextEditingController discreiptioncontroller,
    required TextEditingController commentARcontroller,
    required this.selected,
    required TextEditingController correctiveARcontroller,
    required TextEditingController correctiveENcontroller,
  })  : _discreiptioncontroller = discreiptioncontroller,
        _commentARcontroller = commentARcontroller,
        _correctiveARcontroller = correctiveARcontroller,
        _correctiveENcontroller = correctiveENcontroller;

  final String type;
  final TextEditingController _discreiptioncontroller;
  final TextEditingController _commentARcontroller;
  final String selected;
  final TextEditingController _correctiveARcontroller;
  final TextEditingController _correctiveENcontroller;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        type == 'TransferTo' || type == 'Degree'
            ? Container(
                margin: const EdgeInsets.symmetric(vertical: 10),
                child: CustomTextField(
                  validator: (p0) {
                    if (_discreiptioncontroller.text.isEmpty) {
                      return 'please enter discre';
                    }
                    if (_discreiptioncontroller.text.length < 10) {
                      return 'please enter discre more then 10 char';
                    }
                    return null;
                  },
                  controller: _discreiptioncontroller,
                  label: 'discription',
                  maxLines: 2,
                ),
              )
            : const SizedBox(),
        type == 'Degree'
            ? Container(
                margin: const EdgeInsets.symmetric(vertical: 10),
                child: CustomTextField(
                  validator: (p0) {
                    if (_commentARcontroller.text.isEmpty) {
                      return 'please enter comment ar ';
                    }
                    if (_commentARcontroller.text.length < 10) {
                      return 'please enter discre more then 10 char';
                    }
                    return null;
                  },
                  controller: _commentARcontroller,
                  label: 'commentAr',
                ),
              )
            : const SizedBox(),
        type == 'Degree' && !(selected == '11' || selected == '12')
            ? Container(
                margin: const EdgeInsets.symmetric(vertical: 10),
                child: CustomTextField(
                  validator: (p0) {
                    if (_correctiveARcontroller.text.isEmpty) {
                      return 'please enter Corrective ar ';
                    }
                    if (_correctiveARcontroller.text.length < 10) {
                      return 'please enter Corrective more then 10 char';
                    }
                    return null;
                  },
                  controller: _correctiveARcontroller,
                  label: 'Corrective Ar ',
                ),
              )
            : const SizedBox(),
        type == 'Degree' && !(selected == '11' || selected == '12')
            ? Container(
                margin: const EdgeInsets.only(top: 10, bottom: 60),
                child: CustomTextField(
                  validator: (p0) {
                    if (_correctiveENcontroller.text.isEmpty) {
                      return 'please enter Corrective ar ';
                    }
                    if (_correctiveENcontroller.text.length < 10) {
                      return 'please enter Corrective en more then 10 char';
                    }
                    return null;
                  },
                  controller: _correctiveENcontroller,
                  label: 'Corrective En ',
                ),
              )
            : const SizedBox()
      ],
    );
  }
}
