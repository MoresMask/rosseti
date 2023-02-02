import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

import 'package:image_picker/image_picker.dart';
import 'package:netwk/Page/create_offer_page_3.dart';
import 'package:netwk/Page/main_page.dart';
import 'package:netwk/config.dart';
import 'package:netwk/icons/img_icons.dart';
import 'package:netwk/icons/vector_icons.dart';
import 'package:http/http.dart' as http;
import 'package:netwk/icons/video_icons.dart';
import 'package:netwk/network/title.dart';
import 'package:video_player/video_player.dart';

import 'create_offer_page.dart';
import 'create_offer_page_2.dart';

class CreateOffPage extends StatefulWidget {
  CreateOffPage({super.key, this.title, this.topic_id, this.isNotEmpty});
  String? title;
  int? topic_id;
  bool? isNotEmpty;
  @override
  State<CreateOffPage> createState() => _CreateOffPageState();
}

class _CreateOffPageState extends State<CreateOffPage> {
  File? image;
  File? media;
  XFile? imagepick;
  XFile? videos;
  bool? _isvideo;

  VideoPlayerController? _videoPlayerController;
  final ImagePicker picker = ImagePicker();
  TextEditingController existingsolution = TextEditingController();

  Future<void> pickImagefromGallery() async {
    final XFile? imagepicked =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (imagepicked != null) {
      setState(() {
        image = File(imagepicked.path);
        imagepick = imagepicked;
      });
    }
  }

  void pickVideoFromGallery() async {
    final XFile? video = await picker.pickVideo(source: ImageSource.gallery);
    if (video == null) return;

    setState(() {
      media = File(video.path);
      _isvideo = true;
      videos = video;
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
            Text('Расскажите как сейчас',
                style: TextStyle(color: Color(0xFF205692), fontSize: 20)),
            SizedBox(height: 17),
            Container(
                width: 305,
                height: 292,
                child: TextField(
                  maxLines: null,
                  minLines: null,
                  expands: true,
                  textAlignVertical: TextAlignVertical.top,
                  controller: existingsolution,
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
                  const SizedBox(width: 11),
                  Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(24),
                          color: Color(0xFFFFFFFF)),
                      child: IconButton(
                          onPressed: () async {
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
                      if (imagepick != null ||
                          videos != null ||
                          existingsolution.text != null) {
                        widget.isNotEmpty = true;
                      }
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => CreateOffPage_3(
                              isNotEmpty: widget.isNotEmpty,
                              title: widget.title!,
                              topic_id: widget.topic_id,
                              existing_solution_image: imagepick,
                              existing_solution_video: videos,
                              existing_solution_text: existingsolution.text,
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
