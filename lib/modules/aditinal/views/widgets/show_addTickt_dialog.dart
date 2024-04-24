import 'package:flutter/material.dart';
import 'package:flutter_application_1/modules/aditinal/controllers/cubit/addinal_vist_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

Future<dynamic> showAddDialog(BuildContext context, AddinalVistState state) {
  final TextEditingController addTextContoller = TextEditingController();
  final keyForm = GlobalKey<FormState>();
  return showDialog(
      context: context,
      builder: (c) => Center(
            child: Material(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
                side: const BorderSide(
                  width: 0,
                ),
              ),
              child: SizedBox(
                width: MediaQuery.of(context).size.width * .8,
                height: 300,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(top: 20, left: 20),
                      child: const Text(
                        'Additinal Visit',
                        style: TextStyle(
                          fontSize: 25,
                        ),
                      ),
                    ),
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 20, horizontal: 20),
                        child: Form(
                          key: keyForm,
                          autovalidateMode: AutovalidateMode.always,
                          child: TextFormField(
                            validator: (v) {
                              if (addTextContoller.text.isEmpty) {
                                return 'please enter refNom';
                              }
                              return null;
                            },
                            controller: addTextContoller,
                            decoration: InputDecoration(
                              labelText: 'addinal',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                                borderSide: const BorderSide(width: 1),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Center(
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width * .7,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.purple),
                          onPressed: state is AddinalVisitAddTicktLoading
                              ? null
                              : () {
                                  keyForm.currentState!.validate();
                                  if (addTextContoller.text.isNotEmpty) {
                                    context.read<AddinalVistCubit>().addTicket(
                                        refNom: addTextContoller.text,
                                        context: context);
                                    addTextContoller.text = '';
                                  }
                                },
                          child: state is AddinalVisitAddTicktLoading
                              ? const CircularProgressIndicator()
                              : const Text(
                                  'submit',
                                  style: TextStyle(color: Colors.white),
                                ),
                        ),
                      ),
                    ),
                    Center(
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width * .7,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.purple),
                          onPressed: () {},
                          child: const Text(
                            'cancel',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ));
}
