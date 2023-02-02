import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

import 'package:image_picker/image_picker.dart';
import 'package:netwk/Page/main_page.dart';
import 'package:netwk/config.dart';
import 'package:netwk/icons/img_icons.dart';
import 'package:netwk/icons/vector_icons.dart';
import 'package:http/http.dart' as http;
import 'package:netwk/icons/video_icons.dart';
import 'package:netwk/network/title.dart';
import 'package:video_player/video_player.dart';

import 'create_offer_page_2.dart';

class CreateOffer extends StatefulWidget {
  const CreateOffer({super.key});

  @override
  State<CreateOffer> createState() => _CreateOfferState();
}

class _CreateOfferState extends State<CreateOffer> {
  List<String> list = [];
  bool isNotEmpty = false;
  int? index;

//запрос
  Future GetTopics() async {
    List<Topics> listtop;

    List<String> liststr = [];
    var res = await http.get(
        Uri.parse('https://phystechlab.ru/rosseti/public/api/topics'),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $token'
        });
    var jsonData = jsonDecode(res.body);
    var rest = jsonData['topics'] as List;
    listtop = rest.map<Topics>((json) => Topics.fromJson(json)).toList();

    for (var i = 0; i < listtop.length; i++) {
      liststr.add(listtop[i].title.toString());
    }
//передача данных в лист
    setState(() {
      list = liststr;
    });
  }

// инициализация
  @override
  void initState() {
    GetTopics();
    super.initState();
  }

  TextEditingController title_contoller = TextEditingController();
  TextEditingController topic_id_contoller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFAFBFD),
      body: SingleChildScrollView(
        child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 68),
            child: Center(
              child: Column(
                children: [
                  const headline(
                    text: 'Создать',
                  ),
                  const SizedBox(height: 17),
                  const Text('Расскажите о предложении',
                      style: TextStyle(color: Color(0xFF205692), fontSize: 20)),
                  const SizedBox(height: 34),
                  const Text('Выберите тему и название',
                      style: TextStyle(color: Color(0xFF205692), fontSize: 20)),
                  const SizedBox(height: 34),
                  Container(
                    width: 305,
                    height: 58,
                    child: TextFormField(
                        controller: topic_id_contoller,
                        decoration: InputDecoration(
                            hintText: 'Тема проекта',
                            suffixIcon: PopupMenuButton(
                              icon: Icon(Vector.vector),
                              onSelected: (dynamic value) async {
                                index = list.indexOf(value);
                                topic_id_contoller.text = value.toString();
                              },
                              itemBuilder: (BuildContext context) {
                                return list.map<PopupMenuItem<String>>((
                                  String value,
                                ) {
                                  return new PopupMenuItem(
                                      child: new Text(value), value: value);
                                }).toList();
                              },
                            ),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(24)))),
                  ),
                  SizedBox(height: 34),
                  Container(
                    width: 305,
                    height: 58,
                    child: TextField(
                        controller: title_contoller,
                        decoration: InputDecoration(
                            hintText: 'Название',
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(24)))),
                  ),
                  SizedBox(height: 213),
                  Container(
                      width: 305,
                      height: 58,
                      child: OutlinedButton(
                          style: OutlinedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(24))),
                          onPressed: () {
                            if (title_contoller != null || index != null) {
                              isNotEmpty = true;
                            }
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => CreateOffPage(
                                    title: title_contoller.text,
                                    topic_id: index,
                                    isNotEmpty: isNotEmpty,
                                  ),
                                ));
                          },
                          child: Text(
                            'Дальше',
                            style: TextStyle(
                                color: Color(0xFF205692), fontSize: 20),
                          )))
                ],
              ),
            )),
      ),
    );
  }
}
