import 'package:flutter/material.dart';
import 'package:flutter_application_1/modules/add_ticket/cubit/add_tickt_cubit.dart';
import 'package:flutter_application_1/modules/add_ticket/models/degree_model.dart';
import 'package:flutter_application_1/modules/add_ticket/models/transfer_to_model.dart';
import 'package:flutter_application_1/modules/add_ticket/views/widgets/show_cuprtiono_buttom_sheet.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddTicktButtonWidget extends StatefulWidget {
  const AddTicktButtonWidget({
    super.key,
    required this.setSelect,
  });
  final Function(String type, String selcted) setSelect;

  @override
  State<AddTicktButtonWidget> createState() => _AddTicktButtonWidgetState();
}

class _AddTicktButtonWidgetState extends State<AddTicktButtonWidget> {
  String selectedType = '';
  String selectedOption = '';

  @override
  Widget build(BuildContext context) {
    final addTicktCubit = context.read<AddTicktCubit>();
    return Column(
      children: [
        const SizedBox(height: 10),
        selectedType == '' || selectedType == 'TransferTo'
            ? SizedBox(
                width: MediaQuery.of(context).size.width,
                height: 50,
                child: ElevatedButton(
                  onPressed: () {
                    addTicktCubit.getRefNomList();
                    showCupertinoModal(
                        context: context,
                        list: addTicktCubit.transferModelList,
                        type: 'Transfer To',
                        selected: selectedOption,
                        onPressed: (selected) {
                          if (selected is TransferToModel) {
                            widget.setSelect('TransferTo', selected.resourceId);
                            setState(() {
                              selectedType = 'TransferTo';
                              selectedOption = selected.name;
                            });
                          }
                          if (selected == null) {
                            widget.setSelect('', '');
                            setState(() {
                              selectedType = '';
                              selectedOption = '';
                            });
                          }
                          Navigator.of(context).pop();
                        });

                    // showButtomDialog(
                    //     cubit: addTicktCubit,
                    //     context: context,
                    //     type: 'TransferTo',
                    //     setSelect: (s, v) {
                    //       widget.setSelect(s, v);
                    //       setState(() {
                    //         selectedType = s;
                    //       });
                    //     });
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.deepPurple,
                  ),
                  child: Text(
                    'Transfer To : $selectedOption',
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
              )
            : const SizedBox(),
        const SizedBox(height: 10),
        selectedType == '' || selectedType == 'Degree'
            ? SizedBox(
                width: MediaQuery.of(context).size.width,
                height: 50,
                child: ElevatedButton(
                  onPressed: () {
                    addTicktCubit.getDegreeList();

                    showCupertinoModal(
                        context: context,
                        list: addTicktCubit.degreeList,
                        type: 'degree',
                        selected: selectedOption,
                        onPressed: (selected) {
                          if (selected is DegreeModel) {
                            widget.setSelect('Degree', selected.degreeID);
                            setState(() {
                              selectedType = 'Degree';
                              selectedOption = selected.name;
                            });
                          }
                          if (selected == null) {
                            widget.setSelect('', '');
                            setState(() {
                              selectedType = '';
                              selectedOption = '';
                            });
                          }
                          Navigator.of(context).pop();
                        });
                    // showButtomDialog(
                    //     cubit: addTicktCubit,
                    //     context: context,
                    //     type: 'Degree',
                    //     setSelect: (s, v) {
                    //       widget.setSelect(s, v);
                    //       setState(() {
                    //         selectedType = s;
                    //       });
                    //     });
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.deepPurple,
                  ),
                  child: Text(
                    'Degree $selectedOption',
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
              )
            : const SizedBox(),
      ],
    );
  }
}
