// ignore_for_file: use_build_context_synchronously

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/common/widgets/custom_text_filed.dart';
import 'package:flutter_application_1/modules/reports/controllers/stage_cubit/stages_cubit.dart';
import 'package:flutter_application_1/modules/reports/models/stage_models.dart';
import 'package:flutter_application_1/modules/reports/views/screens/sections_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';

class StageScreen extends StatefulWidget {
  const StageScreen({super.key});

  @override
  State<StageScreen> createState() => _StageScreenState();
}

class _StageScreenState extends State<StageScreen> {
  final projectNomTextController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  String _locationMessage = '';
  late StageModel _selectedStage;

  Future<void> getProjectStageIdAndPushToSections(
      {required StageModel stage}) async {
    _selectedStage = stage;
    if (!_formKey.currentState!.validate()) {
      return;
    }
    await _getCurrentLocation();

    if (_locationMessage == '' &&
        _locationMessage == 'Location permission denied.') {
      return;
    }
    context.read<StagesCubit>().getProductStageId(
        stageId: stage.stageID,
        projectNo: projectNomTextController.text,
        location: _locationMessage);
  }

  Future<void> _getCurrentLocation() async {
    try {
      log('message');
      LocationPermission permission = await Geolocator.requestPermission();

      if (permission == LocationPermission.denied) {
        setState(() {
          _locationMessage = 'Location permission denied.';
        });
        return;
      }

      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);

      setState(() {
        _locationMessage =
            'Latitude: ${position.latitude}, Longitude: ${position.longitude}';
      });
    } catch (e) {
      setState(() {
        _locationMessage = 'Error: ${e.toString()}';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: BlocConsumer<StagesCubit, StagesState>(
        listener: (context, state) {
          if (state is StagesGetProductStageIdLoadingState) {
            showDialog(
                context: context,
                builder: (context) => const Center(
                      child: CircularProgressIndicator(),
                    ));
          }
          if (state is StagesErrorState) {
            Navigator.of(context).pop();
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(state.message)));
          }
          if (state is StagesGetProductStageIdSucessState) {
            Navigator.of(context).pop();
            Navigator.of(context).push(MaterialPageRoute(
                builder: (c) => SectionScreen(
                      stage: _selectedStage,
                      pStageId: state.productStageId,
                    )));
          }
        },
        builder: (context, state) {
          final stagecubit = context.read<StagesCubit>();
          return Column(
            children: [
              Container(
                margin: const EdgeInsets.only(top: 20),
                width: MediaQuery.of(context).size.width * .5,
                child: Form(
                  autovalidateMode: AutovalidateMode.always,
                  key: _formKey,
                  child: CustomTextField(
                    hintText: 'Project Id',
                    controller: projectNomTextController,
                    keyboardType: TextInputType.number,
                    validator: (p0) {
                      if (projectNomTextController.text.isEmpty) {
                        return 'please enter a project id';
                      }
                      return null;
                    },
                    suffixIcon: IconButton(
                      icon: const Icon(Icons.search),
                      onPressed: () {},
                    ),
                  ),
                ),
              ),
              Expanded(
                child: ListView.separated(
                  separatorBuilder: (context, index) {
                    return const Divider(
                      color: Colors.black,
                    );
                  },
                  itemBuilder: (context, index) {
                    return state is StagesLoadingState
                        ? const CircularProgressIndicator()
                        : TextButton(
                            onPressed: () {
                              getProjectStageIdAndPushToSections(
                                  stage: stagecubit.stages[index]);
                              // Navigator.of(context).push(MaterialPageRoute(
                              //   builder: (context) => SectionScreen(
                              //     stage: stagecubit.stages[index],
                              //   ),
                              // ));
                            },
                            child: Text(stagecubit.stages[index].stageName));
                  },
                  itemCount: stagecubit.stages.length,
                ),
              ),
            ],
          );
        },
      )),
    );
  }
}
