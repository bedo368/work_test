import 'package:flutter/material.dart';
import 'package:flutter_application_1/modules/aditinal/controllers/cubit/addinal_vist_cubit.dart';
import 'package:flutter_application_1/modules/aditinal/views/widgets/adintal_item_widget.dart';
import 'package:flutter_application_1/modules/aditinal/views/widgets/build_adinal_list.dart';
import 'package:flutter_application_1/modules/aditinal/views/widgets/search_appbar.dart';
import 'package:flutter_application_1/modules/aditinal/views/widgets/show_success_d.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// import 'package:url_launcher/url_launcher.dart';

class AddinalSecreen extends StatefulWidget {
  const AddinalSecreen({super.key});

  @override
  State<AddinalSecreen> createState() => _AddinalSecreenState();
}

class _AddinalSecreenState extends State<AddinalSecreen> {
  final ScrollController _controller = ScrollController();

  @override
  void initState() {
    super.initState();
    _controller.addListener(_scrollListener);
  }

  @override
  void dispose() {
    _controller.removeListener(_scrollListener);
    _controller.dispose();
    super.dispose();
  }

  void _scrollListener() {
    double currentPosition = _controller.position.pixels;
    double maxScrollExtent = _controller.position.maxScrollExtent;
    if (currentPosition >= maxScrollExtent) {
      final c = context.read<AddinalVistCubit>();
      if (!c.isLoading) {
        context.read<AddinalVistCubit>().fetchAddinalList(ref: searchKey);
      }
    }
  }

  String? searchKey;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: BlocConsumer<AddinalVistCubit, AddinalVistState>(
          listener: (context, state) {
            if (state is AddinalVistError) {
              ScaffoldMessenger.of(context)
                ..clearSnackBars()
                ..showSnackBar(SnackBar(content: Text(state.message)));
            }
            if (state is AddinalVisitAddTicktDone ||
                state is AddinalVistError) {
              Navigator.pop(context);
            }
            if (state is AddinalVisitAddTicktDone) {
              sowAddTicktDialogSuccess(context, state);
            }
          },
          builder: (context, state) {
            return CustomScrollView(
              physics: const BouncingScrollPhysics(
                  parent: AlwaysScrollableScrollPhysics()),
              controller: _controller,
              slivers: [
                searchAppBart(context, state, (val) {
                  setState(() {
                    searchKey = val;
                  });
                }),
                const PinedAdinalList(),
                const BuildAdinalList(),
                state is AddinalVistLoading
                    ? const SliverToBoxAdapter(
                        child: Center(
                          child: Center(child: CircularProgressIndicator()),
                        ),
                      )
                    : const SliverToBoxAdapter(),
              ],
            );
          },
        ),
      ),
    );
  }
}
