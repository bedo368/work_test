// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_application_1/modules/reports/controllers/questin_cubit/question_cubit.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// class QustionOptionDataScreen extends StatelessWidget {
//   const QustionOptionDataScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return BlocConsumer<QuestionCubit, QuestionState>(
//       listener: (context, state) {},
//       builder: (context, state) {
//         final cubit = context.read<QuestionCubit>();
//         return Scaffold(
//           body: ListView.separated(
//               itemBuilder: (constext, index) {
//                 return Text(cubit.questionOptionData[index].degreeName);
//               },
//               separatorBuilder: (context, index) {
//                 return Divider();
//               },
//               itemCount: cubit.questionOptionData.length),
//         );
//       },
//     );
//   }
// }
