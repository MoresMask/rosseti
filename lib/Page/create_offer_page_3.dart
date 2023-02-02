import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

import 'package:image_picker/image_picker.dart';
import 'package:netwk/Page/create_offer_page.dart';
import 'package:netwk/Page/create_offer_pages.dart';
import 'package:netwk/Page/main_page.dart';
import 'package:netwk/config.dart';
import 'package:netwk/icons/img_icons.dart';
import 'package:netwk/icons/vector_icons.dart';
import 'package:http/http.dart' as http;
import 'package:netwk/icons/video_icons.dart';
import 'package:netwk/network/title.dart';
import 'package:video_player/video_player.dart';

class CreateOffPage_3 extends StatefulWidget {
  CreateOffPage_3(
      {super.key,
      required this.existing_solution_image,
      required this.existing_solution_video,
      required this.topic_id,
      required this.title,
      required this.existing_solution_text,
      required this.isNotEmpty});
  final String title;
  bool? isNotEmpty;
  final int? topic_id;
  final XFile? existing_solution_image;
  final XFile? existing_solution_video;
  final String existing_solution_text;

  @override
  State<CreateOffPage_3> createState() => _CreateOffPage_3State();
}

class _CreateOffPage_3State extends State<CreateOffPage_3> {
  XFile? proposed_solution_image;
  XFile? proposed_solution_video;
  File? image;
  File? media;
  bool? _isvideo;
  VideoPlayerController? _videoPlayerController;
  final ImagePicker picker = ImagePicker();
  TextEditingController proposed_solution_text = TextEditingController();

  Future<void> pickImagefromGallery() async {
    final imagepicked =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (imagepicked != null) {
      setState(() {
        image = File(imagepicked.path);
        proposed_solution_image = imagepicked;
      });
    }
  }

  void pickVideoFromGallery() async {
    final XFile? video = await picker.pickVideo(source: ImageSource.gallery);
    if (video == null) return;

    setState(() {
      media = File(video.path);
      _isvideo = true;
      proposed_solution_video = video;
    });

    _videoPlayerController = VideoPlayerController.file(media!);
    _videoPlayerController!.initialize();
    _videoPlayerController!.setLooping(true);
    _videoPlayerController!.pause();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 68),
            headline(text: 'Создать'),
            SizedBox(height: 17),
            Text('Расскажите как надо',
                style: TextStyle(color: Color(0xFF205692), fontSize: 20)),
            SizedBox(height: 17),
            Container(
                width: 305,
                height: 292,
                child: TextField(
                  controller: proposed_solution_text,
                  maxLines: null,
                  minLines: null,
                  expands: true,
                  textAlignVertical: TextAlignVertical.top,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(24))),
                )),
            SizedBox(height: 17),
            Text(
              'Добавьте фото или видео',
              style: TextStyle(color: Color(0xFF205692), fontSize: 20),
            ),
            SizedBox(height: 23),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 35),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    height: 51,
                    width: 91,
                    child: _isvideo != null
                        ? VideoPlayer(_videoPlayerController!)
                        : media != null
                            ? Image.file(media!)
                            : Text(''),
                  ),
                  SizedBox(width: 13),
                  image == null
                      ? Text('')
                      : Image.file(image!,
                          height: 51, width: 91, fit: BoxFit.fill),
                  SizedBox(width: 13),
                  Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(24),
                          color: Color(0xFFFFFFFF)),
                      child: IconButton(
                          onPressed: () {
                            pickVideoFromGallery();
                          },
                          icon: Icon(Video.video_player_1))),
                  SizedBox(width: 11),
                  Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(24),
                          color: Color(0xFFFFFFFF)),
                      child: IconButton(
                          onPressed: () {
                            pickImagefromGallery();
                          },
                          icon: Icon(Img.take_1)))
                ],
              ),
            ),
            SizedBox(height: 31),
            Container(
                width: 305,
                height: 58,
                child: OutlinedButton(
                    style: OutlinedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(24))),
                    onPressed: () {
                      if (proposed_solution_image != null ||
                          proposed_solution_text.text != null ||
                          proposed_solution_video != null) {
                        widget.isNotEmpty = true;
                      }
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => CreateOffPages(
                              isNotEmpty: widget.isNotEmpty,
                              title: widget.title,
                              topic_id: widget.topic_id,
                              existing_solution_text:
                                  widget.existing_solution_text,
                              existing_solution_image:
                                  widget.existing_solution_image,
                              existing_solution_video:
                                  widget.existing_solution_video,
                              proposed_solution_text:
                                  proposed_solution_text.text,
                              proposed_solution_image: proposed_solution_image,
                              proposed_solution_video: proposed_solution_video,
                            ),
                          ));
                    },
                    child: Text(
                      'Дальше',
                      style: TextStyle(color: Color(0xFF205692), fontSize: 20),
                    )))
          ],
        ),
      ),
    );
  }
}
