import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/modules/reports/models/question_model.dart';
import 'package:flutter_application_1/modules/reports/models/question_options_model.dart';

class FileQuestionWidget extends StatefulWidget {
  const FileQuestionWidget({
    super.key,
    required this.question,
    required this.questionOptions,
  });
  final QuestionModel question;
  final List<QuestionOptionsModel> questionOptions;

  @override
  State<FileQuestionWidget> createState() => _FileQuestionWidgetState();
}

class _FileQuestionWidgetState extends State<FileQuestionWidget>
    with AutomaticKeepAliveClientMixin {
  QuestionOptionsModel? currentValue;

  String filePath = '';
  void _openFilePicker() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null) {
      setState(() {
        filePath = result.files.single.path!;
      });
    } else {}
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return ListView(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      children: [
        ListTile(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(child: Text(widget.question.qTitle)),
              Column(
                children: [
                  IconButton(
                      onPressed: () {
                        if (filePath != '') {
                          setState(() {
                            filePath = '';
                          });
                          return;
                        }
                        _openFilePicker();
                      },
                      icon: filePath != ''
                          ? const Icon(
                              Icons.cancel,
                              color: Colors.red,
                            )
                          : const Icon(Icons.file_upload)),
                  widget.question.required != '1'
                      ? const Align(
                          alignment: Alignment.topRight,
                          child: Text(
                            'not required',
                            style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.w400,
                                color: Colors.grey),
                          ),
                        )
                      : const SizedBox(),
                ],
              )
            ],
          ),
        )
      ],
    );
  }

  @override
  bool get wantKeepAlive => true;
}
