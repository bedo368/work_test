import 'package:flutter/material.dart';
import 'package:flutter_application_1/modules/aditinal/controllers/cubit/addinal_vist_cubit.dart';
import 'package:flutter_application_1/modules/aditinal/views/widgets/adintal_item_widget.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BuildAdinalList extends StatelessWidget {
  const BuildAdinalList({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddinalVistCubit, AddinalVistState>(
      builder: (context, state) {
        final cubit = context.read<AddinalVistCubit>();
        return SliverList.builder(
          itemBuilder: (context, index) {
            return AditinalItemWedget(
                title: cubit.list[index].quotationID,
                refNo: cubit.list[index].referenceNo,
                payment: cubit.list[index].paid,
                stage: cubit.list[index].stage);
          },
          itemCount: cubit.list.length,
        );
      },
    );
  }
}
