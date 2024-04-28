import 'package:flutter/material.dart';
import 'package:flutter_application_1/modules/add_ticket/cubit/add_tickt_cubit.dart';

class AddTicktFloatingButton extends StatelessWidget {
  const AddTicktFloatingButton({
    super.key,
    required this.type,
    required GlobalKey<FormState> formKey,
    required this.selected,
    required this.cubit,
    required TextEditingController discreiptioncontroller,
    required TextEditingController projectNumbercontroller,
    required TextEditingController commentARcontroller,
    required TextEditingController correctiveARcontroller,
    required TextEditingController correctiveENcontroller,
  })  : _formKey = formKey,
        _discreiptioncontroller = discreiptioncontroller,
        _projectNumbercontroller = projectNumbercontroller,
        _commentARcontroller = commentARcontroller,
        _correctiveARcontroller = correctiveARcontroller,
        _correctiveENcontroller = correctiveENcontroller;

  final String type;
  final GlobalKey<FormState> _formKey;
  final String selected;
  final AddTicktCubit cubit;
  final TextEditingController _discreiptioncontroller;
  final TextEditingController _projectNumbercontroller;
  final TextEditingController _commentARcontroller;
  final TextEditingController _correctiveARcontroller;
  final TextEditingController _correctiveENcontroller;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          left: 40,
          right: 0,
          bottom: 10,
          child: FloatingActionButton(
            onPressed: () {
              FocusManager.instance.primaryFocus?.unfocus();

              if (type == '') {
                ScaffoldMessenger.of(context)
                  ..clearSnackBars()
                  ..showSnackBar(const SnackBar(
                      content: Center(child: Text('please select Type'))));
                return;
              }
              if (_formKey.currentState!.validate() &&
                  type == 'TransferTo' &&
                  selected != '') {
                cubit.addTicketWithRefNom(
                    disc: _discreiptioncontroller.text,
                    refNom: _projectNumbercontroller.text,
                    transferTotype: selected);
              }

              if (_formKey.currentState!.validate() && type == 'Degree') {
                cubit.addTicktWithDegreeId(
                    refNom: _projectNumbercontroller.text,
                    degreeId: selected,
                    disc: _discreiptioncontroller.text,
                    commentAr: _commentARcontroller.text,
                    correctiveAr: (selected == '11' || selected == '12')
                        ? _correctiveARcontroller.text
                        : '',
                    correctiveEn: (selected == '11' || selected == '12')
                        ? _correctiveENcontroller.text
                        : '');
              }
            },
            child: const Text('Submit'),
          ),
        ),
      ],
    );
  }
}
