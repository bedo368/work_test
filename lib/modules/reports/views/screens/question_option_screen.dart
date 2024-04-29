// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_application_1/modules/reports/controllers/questin_cubit/question_cubit.dart';
// import 'package:flutter_application_1/modules/reports/views/screens/question_option_date_screen.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// class QuestionOptionScreen extends StatelessWidget {
//   const QuestionOptionScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: BlocConsumer<QuestionCubit, QuestionState>(
//         listener: (context, state) {},
//         builder: (context, state) {
//           final cubit = context.read<QuestionCubit>();
//           return ListView.separated(
//               itemBuilder: (context, index) {
//                 return ListTile(
//                   onTap: () {
//                     Navigator.of(context).push(MaterialPageRoute(
//                         builder: (c) => BlocProvider.value(
//                               value: cubit
//                                 ..fetchQuestionOptionDataByQOptionId(
//                                     qOId: cubit.questionOption[index].qOID),
//                               child: const QustionOptionDataScreen(),
//                             )));
//                   },
//                   title: Text(cubit.questionOption[index].answer),
//                 );
//               },
//               separatorBuilder: (context, index) {
//                 return const Divider();
//               },
//               itemCount: cubit.questionOption.length);
//         },
//       ),
//     );
//   }
// }
