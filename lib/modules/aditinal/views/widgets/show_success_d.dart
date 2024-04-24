import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_1/modules/aditinal/controllers/cubit/addinal_vist_cubit.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

Future<dynamic> sowAddTicktDialogSuccess(
  BuildContext context,
  AddinalVisitAddTicktDone state,
) {
  void launchURL(String url) async {
    print(url);
    if (await canLaunchUrl(Uri.parse(url))) {
      print(url);
      await launchUrl(Uri.parse(url));
    } else {
      throw 'Could not launch $url';
    }
  }

  void shareText(String text) {
    Share.share(text);
  }

  return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => Center(
            child: Material(
              child: Card(
                child: SizedBox(
                  width: MediaQuery.of(context).size.width * .9,
                  height: 100,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Column(
                        children: [
                          IconButton(
                              onPressed: () {
                                launchURL(state.link);
                              },
                              icon: const Icon(Icons.save)),
                          const Text('open')
                        ],
                      ),
                      Column(
                        children: [
                          IconButton(
                              onPressed: () {
                                shareText(state.link);
                              },
                              icon: const Icon(Icons.save)),
                          const Text('share')
                        ],
                      ),
                      Column(
                        children: [
                          IconButton(
                              onPressed: () {
                                Clipboard.setData(
                                    ClipboardData(text: state.link));
                              },
                              icon: const Icon(Icons.copy)),
                          const Text('copy')
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          ));
}
