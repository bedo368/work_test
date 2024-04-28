import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/common/widgets/custom_text_filed.dart';
import 'package:flutter_application_1/modules/add_ticket/cubit/add_tickt_cubit.dart';
import 'package:flutter_application_1/modules/add_ticket/views/widgets/add_ticket_buttons_widgets.dart';
import 'package:flutter_application_1/modules/add_ticket/views/widgets/add_tickt_floating_action_button.dart';
import 'package:flutter_application_1/modules/add_ticket/views/widgets/form_text_fileds.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';

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
  final TextEditingController _commentARcontroller = TextEditingController();
  final TextEditingController _correctiveENcontroller = TextEditingController();
  final TextEditingController _correctiveARcontroller = TextEditingController();

  String type = '';
  String selected = '';
  @override
  void dispose() {
    super.dispose();
    _discreiptioncontroller.dispose();
    _commentARcontroller.dispose();
    _correctiveENcontroller.dispose();
    _correctiveARcontroller.dispose();
    _projectNumbercontroller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AddTicktCubit, AddTicktState>(
      listener: (context, state) {
        if (state is AddTicktErrorState) {
          showToast(
            state.message,
            backgroundColor: Colors.red,
            context: context,
            position: StyledToastPosition.top,
            curve: Curves.easeOut,
            reverseCurve: Curves.easeIn,
          );
          Navigator.of(context).pop();
        }
        if (state is AddTicktWithTransferIdSuccess ||
            state is AddTicktWithDegreeIdSuccess) {
          Navigator.of(context).pop();

          showToast(
            "Success",
            backgroundColor: Colors.green,
            context: context,
            position: StyledToastPosition.top,
            curve: Curves.easeOut,
            reverseCurve: Curves.easeIn,
          );
        }
        if (state is AddTicktWithDegreeIdOrTransferIdLoading && type != '') {
          showDialog(
              context: context,
              builder: (_) => Material(
                    color: Colors.white.withOpacity(0),
                    child: const Center(
                      child: CircularProgressIndicator(),
                    ),
                  ));
        }
      },
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
                        return null;
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
                    FormTexTFildes(
                        type: type,
                        discreiptioncontroller: _discreiptioncontroller,
                        commentARcontroller: _commentARcontroller,
                        selected: selected,
                        correctiveARcontroller: _correctiveARcontroller,
                        correctiveENcontroller: _correctiveENcontroller)
                  ],
                ),
              ),
            ),
            floatingActionButton: AddTicktFloatingButton(
                type: type,
                formKey: _formKey,
                selected: selected,
                cubit: cubit,
                discreiptioncontroller: _discreiptioncontroller,
                projectNumbercontroller: _projectNumbercontroller,
                commentARcontroller: _commentARcontroller,
                correctiveARcontroller: _correctiveARcontroller,
                correctiveENcontroller: _correctiveENcontroller),
          ),
        );
      },
    );
  }
}
