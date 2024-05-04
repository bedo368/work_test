import 'package:flutter/material.dart';
import 'package:flutter_application_1/modules/aditinal/controllers/cubit/addinal_vist_cubit.dart';
import 'package:flutter_application_1/modules/aditinal/views/widgets/show_addTickt_dialog.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

SliverAppBar searchAppBart(BuildContext context, AddinalVistState state,
    Function(String searchKy) searchKey) {
  return SliverAppBar(
    pinned: true,
    elevation: 0,
    backgroundColor: Colors.white,
    title: Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Container(
          height: 50,
          width: MediaQuery.of(context).size.width * .7,
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: TextField(
            decoration: InputDecoration(
              hintText: 'Search...',
              prefixIcon: const Icon(Icons.search),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
            onSubmitted: (value) {
              searchKey(value);
              context.read<AddinalVistCubit>().fetchAddinalList(ref: value);
            },
          ),
        ),
        IconButton(
            onPressed: () {
              showAddDialog(context, state);
            },
            icon: const Icon(Icons.add))
      ],
    ),
    flexibleSpace: FlexibleSpaceBar(
      collapseMode: CollapseMode.pin,
      background: Container(
        color: Colors.white, // Set the same color as SliverAppBar
      ),
    ),
  );
}
