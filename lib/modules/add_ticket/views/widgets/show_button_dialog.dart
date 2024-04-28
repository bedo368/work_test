import 'package:flutter/material.dart';
import 'package:flutter_application_1/modules/add_ticket/cubit/add_tickt_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

showButtomDialog(
    {required AddTicktCubit cubit,
    required BuildContext context,
    required String type,
    required void Function(String selected, String value) setSelect}) {
  return showModalBottomSheet(
      isDismissible: false,
      backgroundColor: Colors.white.withOpacity(0),
      context: context,
      
      builder: (context) => BlocProvider<AddTicktCubit>.value(
            value: cubit,
            child: BlocBuilder<AddTicktCubit, AddTicktState>(
                builder: (BuildContext context, AddTicktState state) {
              return state is AddTicktLoadingState
                  ? const CircularProgressIndicator()
                  : ListView(
                      shrinkWrap: true,
                      children: [
                        Card(
                          margin: const EdgeInsets.only(left: 5, right: 5),
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(10),
                                topRight: Radius.circular(10)),
                          ),
                          child: Container(
                              padding: const EdgeInsets.all(10),
                              width: MediaQuery.of(context).size.width,
                              child: Center(
                                  child: Text(type == 'TransferTo'
                                      ? 'Transfer to '
                                      : 'Degree'))),
                        ),
                        Container(
                          margin: const EdgeInsets.symmetric(horizontal: 5),
                          child: const Divider(
                            height: 1,
                          ),
                        ),
                        Card(
                          margin: const EdgeInsets.symmetric(horizontal: 5),
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(10),
                                bottomRight: Radius.circular(10)),
                          ),
                          child: ListView.separated(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) {
                              return TextButton(
                                onPressed: () {
                                  if (type == 'TransferTo') {
                                    setSelect(
                                        'TransferTo',
                                        cubit.transferModelList[index]
                                            .resourceId);
                                  } else {
                                    setSelect('Degree',
                                        cubit.degreeList[index].degreeID);
                                  }
                                  Navigator.of(context).pop();
                                },
                                child: Text(
                                  type == 'TransferTo'
                                      ? cubit.transferModelList[index].name
                                      : cubit.degreeList[index].name,
                                ),
                              );
                            },
                            separatorBuilder: (_, __) => const Divider(
                              height: 1,
                            ),
                            itemCount: type == 'TransferTo'
                                ? cubit.transferModelList.length
                                : cubit.degreeList.length,
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.white,
                          ),
                          margin: const EdgeInsets.only(
                              top: 20, bottom: 10, left: 5, right: 5),
                          width: MediaQuery.of(context).size.width,
                          child: TextButton(
                            onPressed: () {
                              setSelect('', '');
                              Navigator.of(context).pop();
                            },
                            child: const Text('Cancel'),
                          ),
                        ),
                      ],
                    );
            }),
          ));
}
