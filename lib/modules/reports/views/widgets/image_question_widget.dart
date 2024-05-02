import 'package:flutter/material.dart';
import 'package:flutter_application_1/modules/reports/models/question_model.dart';
import 'package:flutter_application_1/modules/reports/models/question_options_model.dart';
import 'package:image_picker/image_picker.dart';

class ImageQuestionWidget extends StatefulWidget {
  const ImageQuestionWidget({
    super.key,
    required this.question,
    required this.questionOptions,
    required this.onSelected,
  });
  final QuestionModel question;
  final List<QuestionOptionsModel> questionOptions;
  final Function(dynamic quetionInfo) onSelected;

  @override
  State<ImageQuestionWidget> createState() => _ImageQuestionWidgetState();
}

class _ImageQuestionWidgetState extends State<ImageQuestionWidget>
    with AutomaticKeepAliveClientMixin {
  QuestionOptionsModel? currentValue;

  int imageNum = 0;

  List<String> imageList = [];

  @override
  void initState() {
    imageNum = int.parse(widget.questionOptions.first.imagesCounter);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<void> _pickImage(ImageSource source) async {
    final pickedImage = await ImagePicker().pickImage(source: source);
    if (pickedImage != null && imageList.length < imageNum) {
      setState(() {
        imageList.add(pickedImage.path);

        if (imageList.length == imageNum) {
          widget.onSelected({'question': widget.question, 'answer': imageList});
        }
      });
    }
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
              TextButton(
                  onPressed: () {
                    if (imageList.length >= imageNum) {
                      setState(() {
                        imageList.clear();
                        widget.onSelected(
                            {'question': widget.question, 'answer': null});
                      });
                    } else {
                      _pickImage(ImageSource.gallery);
                    }
                  },
                  child: Row(
                    children: [
                      Text('${imageNum - imageList.length}'),
                      Icon(imageList.length < imageNum
                          ? Icons.image
                          : Icons.cancel),
                    ],
                  ))
            ],
          ),
        )
      ],
    );
  }

  @override
  bool get wantKeepAlive => true;
}
