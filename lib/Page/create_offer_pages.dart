import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
// import 'package:http/http.dart';

import 'package:image_picker/image_picker.dart';
import 'package:netwk/Page/main_page.dart';
import 'package:netwk/config.dart';
import 'package:netwk/icons/img_icons.dart';
import 'package:netwk/icons/vector_icons.dart';
// import 'package:http/http.dart' as http;
import 'package:netwk/icons/video_icons.dart';
import 'package:netwk/network/articles.dart';
import 'package:netwk/network/title.dart';
import 'package:video_player/video_player.dart';

class CreateOffPages extends StatefulWidget {
  CreateOffPages(
      {super.key,
      required this.title,
      required this.topic_id,
      required this.existing_solution_text,
      required this.proposed_solution_text,
      this.existing_solution_image,
      this.existing_solution_video,
      this.proposed_solution_image,
      this.proposed_solution_video,
      this.isNotEmpty});
  String title;
  int? topic_id;
  String existing_solution_text;
  String proposed_solution_text;
  XFile? existing_solution_image;
  XFile? existing_solution_video;
  XFile? proposed_solution_video;
  XFile? proposed_solution_image;
  bool? isNotEmpty;

  @override
  State<CreateOffPages> createState() => _CreateOffPagesState();
}

class _CreateOffPagesState extends State<CreateOffPages> {
  TextEditingController positive_effect = TextEditingController();
  int index = 0;
  // Future<void> MyRequest() async {
  //   var response = await http.post(
  //       Uri.parse("http://phystechlab.ru/rosseti/public/api/suggestions/store"),
  //       headers: {
  //         'Accept': 'application/json',
  //         'Authorization': 'Bearer $token',
  //       },
  //       body: ({
  //         'title': widget.title,
  //         'topic_id': widget.topic_id,
  //         'existing_solution_text': widget.existing_solution_text,
  //         'proposed_solution_text': widget.proposed_solution_text,
  //         'positive_effect': positive_effect.text,
  //       }));
  // }

  // Future<void> Submit_offer() async {
  //   // var body = {
  //   //   'title': widget.title,
  //   //   'topic_id': widget.topic_id,
  //   //   'existing_solution_text': widget.existing_solution_text,
  //   //   'existing_solution_image': widget.existing_solution_image,
  //   //   'existing_solution_video': widget.existing_solution_video,
  //   //   'proposed_solution_text': widget.proposed_solution_text,
  //   //   'proposed_solution_image': widget.proposed_solution_image,
  //   //   'proposed_solution_video': widget.proposed_solution_video,
  //   //   'positive_effect': positive_effect.text,
  //   // };
  //   Response response = await Dio.post(
  //     Uri.parse(Uri.encodeFull(
  //         "https://phystechlab.ru/rosseti/public/api/suggestions/store")),
  //     headers: {
  //       'Accept': 'application/json',
  //       'Authorization': 'Bearer $token',
  //       // 'Content-type': 'multipart/form-data'
  //     },
  //     body: {
  //       'title': widget.title,
  //       'topic_id': widget.topic_id,
  //       'existing_solution_text': widget.existing_solution_text,
  //       'existing_solution_image': widget.existing_solution_image,
  //       'existing_solution_video': widget.existing_solution_video,
  //       'proposed_solution_text': widget.proposed_solution_text,
  //       'proposed_solution_image': widget.proposed_solution_image,
  //       'proposed_solution_video': widget.proposed_solution_video,
  //       'positive_effect': positive_effect.text,
  //     },
  //   );
  // }

  void FetchData() async {
    var dio = Dio();
    Response response = await dio.post(
        "https://phystechlab.ru/rosseti/public/api/suggestions/store",
        data: {
          'title': widget.title,
          'topic_id': widget.topic_id,
          'existing_solution_text': widget.existing_solution_text,
          // 'existing_solution_image': widget.existing_solution_image,
          // 'existing_solution_video': widget.existing_solution_video,
          'proposed_solution_text': widget.proposed_solution_text,
          // 'proposed_solution_image': widget.proposed_solution_image,
          // 'proposed_solution_video': widget.proposed_solution_video,
          'positive_effect': positive_effect.text,
        },
        options: Options(headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
          'Content-Type': 'multipart/form-data'
        }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 68),
            headline(
              text: 'Создать',
            ),
            SizedBox(height: 17),
            Text('Расскажите как будет',
                style: TextStyle(color: Color(0xFF205692), fontSize: 20)),
            SizedBox(height: 17),
            Container(
                width: 305,
                height: 292,
                child: TextField(
                  controller: positive_effect,
                  maxLines: null,
                  minLines: null,
                  expands: true,
                  textAlignVertical: TextAlignVertical.top,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(24))),
                )),
            SizedBox(height: 35),
            Container(
                width: 305,
                height: 58,
                child: OutlinedButton(
                    style: OutlinedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(24))),
                    onPressed: () {
                      positive_effect != null
                          ? widget.isNotEmpty = true
                          : widget.isNotEmpty = false;

                      if (widget.isNotEmpty == true) {
                        // MyRequest();
                        FetchData();
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => MainPage(),
                            ));
                      }
                    },
                    child: Text(
                      'Готово',
                      style: TextStyle(color: Color(0xFF205692), fontSize: 20),
                    )))
          ],
        ),
      ),
    );
  }
}
