import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/common/widgets/custom_text_filed.dart';
import 'package:flutter_application_1/modules/add_ticket/cubit/add_tickt_cubit.dart';
import 'package:flutter_application_1/modules/add_ticket/views/widgets/add_ticket_buttons_widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddTicktScreen extends StatefulWidget {
  const AddTicktScreen({super.key});

  @override
  State<AddTicktScreen> createState() => _AddTicktScreenState();
}

class _AddTicktScreenState extends State<AddTicktScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _projectNumbercontroller =
      TextEditingController();
  final TextEditingController _discreiptioncontroller = TextEditingController();
  final TextEditingController _CommentARcontroller = TextEditingController();
  final TextEditingController _CorrectiveENcontroller = TextEditingController();
  final TextEditingController _CorrectiveARcontroller = TextEditingController();

  String type = '';
  String selected = '';
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AddTicktCubit, AddTicktState>(
      listener: (context, state) {},
      builder: (context, state) {
        final cubit = context.read<AddTicktCubit>();
        return SafeArea(
          child: Scaffold(
            appBar: AppBar(
              title: const Text('Add Ticket'),
            ),
            body: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Form(
                key: _formKey,
                child: ListView(
                  shrinkWrap: true,
                  children: [
                    CustomTextField(
                      keyboardType: TextInputType.number,
                      controller: _projectNumbercontroller,
                      validator: (p0) {
                        if (_projectNumbercontroller.text.isEmpty) {
                          return 'please enter project num';
                        }
                      },
                    ),
                    AddTicktButtonWidget(
                      setSelect: (type, selected) {
                        setState(() {
                          this.type = type;
                          this.selected = selected;
                        });
                      },
                    ),
                    Column(
                      children: [
                        type == 'TransferTo'
                            ? CustomTextField(
                                validator: (p0) {
                                  if (_discreiptioncontroller.text.isEmpty) {
                                    return 'please enter discre';
                                  }
                                  if (_discreiptioncontroller.text.length <
                                      10) {
                                    return 'please enter discre more then 10 char';
                                  }
                                },
                                controller: _discreiptioncontroller,
                                label: 'discription',
                                maxLines: 2,
                              )
                            : const SizedBox()
                      ],
                    )
                  ],
                ),
              ),
            ),
            floatingActionButton: Stack(
              children: [
                Positioned(
                  left: 40,
                  right: 0,
                  bottom: 10,
                  child: FloatingActionButton(
                    onPressed: () {
                      if (type == '') {
                        ScaffoldMessenger.of(context)
                          ..clearSnackBars()
                          ..showSnackBar(const SnackBar(
                              content:
                                  Center(child: Text('please select Type'))));
                        return;
                      }
                      if (_formKey.currentState!.validate() &&
                          type != '' &&
                          selected != '') {
                        cubit.addTicketWithRefNom(
                            disc: _discreiptioncontroller.text,
                            refNom: _projectNumbercontroller.text,
                            transferTotype: selected);
                      }
                    },
                    child: const Text('Submit'),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
