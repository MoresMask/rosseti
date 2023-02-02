import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:netwk/applications/comments.dart';
import 'package:netwk/config.dart';
import 'package:http/http.dart' as http;
import 'package:netwk/network/articles.dart';
import 'package:netwk/network/title.dart';
import 'package:video_player/video_player.dart';

class Application extends StatefulWidget {
  const Application({super.key});

  @override
  State<Application> createState() => _ApplicationState();
}

class _ApplicationState extends State<Application> {
  List<Articles> list = [];
  List<String> topic_title = [];

  void GetTopics() async {
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
      topic_title = liststr;
    });

    print(topic_title.length);
  }

  Future<List<Articles>> getPosts() async {
    var res = await http.get(
        Uri.parse(
            'https://phystechlab.ru/rosseti/public/api/suggestions/index'),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $token'
        });
    var response = jsonDecode(res.body);
    List jsonData = response['suggestions'] as List;
    return list =
        jsonData.map<Articles>((json) => Articles.fromJson(json)).toList();
  }

  @override
  void initState() {
    super.initState();
    getPosts();
    GetTopics();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFAFBFD),
      body: Column(
        children: [
          SizedBox(height: 68),
          headline(text: 'Создать'),
          Expanded(
            child: FutureBuilder<List<Articles>>(
              future: getPosts(),
              builder: ((context, snapshot) {
                if (snapshot.hasData) {
                  List<Articles> articles = snapshot.data!;
                  return ListView.builder(
                    scrollDirection: Axis.vertical,
                    itemCount: articles.length,
                    itemBuilder: (context, index) {
                      Articles list = articles[index];
                      return Column(
                        children: [
                          Container(
                              margin: EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 20),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(24),
                              ),
                              height: 123,
                              width: 336,
                              child: ListTile(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (_) =>
                                              InfoScreen(list: list)));
                                },
                                title: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    list.proposed_solution_image != null
                                        ? Image.network(
                                            list.proposed_solution_image!,
                                            width: 60,
                                            height: 60,
                                          )
                                        : Image.asset(
                                            'assets/images/car_image.png',
                                            width: 60,
                                            height: 60),
                                    SizedBox(width: 20),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          list.title != null
                                              ? Text(list.title!,
                                                  maxLines: 2,
                                                  style: TextStyle(
                                                    color: Color(0xFF205692),
                                                    fontSize: 20,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                  ))
                                              : Text(
                                                  'Название',
                                                  style: TextStyle(
                                                      fontSize: 20,
                                                      color: Color(0xFF205692)),
                                                ),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.end,
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceAround,
                                            children: [
                                              list.author!.full_name != null
                                                  ? Text(
                                                      list.author!.full_name!,
                                                      maxLines: 1,
                                                      style: TextStyle(
                                                          fontSize: 14,
                                                          color: Color(
                                                              0xFFA1A1A1)),
                                                    )
                                                  : Text('автор'),
                                              list.topic_id != null &&
                                                      list.topic_id! <=
                                                          topic_title.length - 1
                                                  ? Text(
                                                      topic_title[
                                                          list.topic_id!],
                                                      maxLines: 1,
                                                      textAlign:
                                                          TextAlign.right,
                                                      style: TextStyle(
                                                          fontSize: 14,
                                                          color: Color(
                                                              0xFF205692)),
                                                    )
                                                  : Text('тема проекта')
                                            ],
                                          )
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              )),
                        ],
                      );
                    },
                  );
                }
                return Center(child: const CircularProgressIndicator());
              }),
            ),
          ),
        ],
      ),
    );
  }
}

class InfoScreen extends StatefulWidget {
  InfoScreen({super.key, required this.list});

  final Articles list;

  @override
  State<InfoScreen> createState() => _InfoScreenState();
}

class _InfoScreenState extends State<InfoScreen> {
  bool? _isvideo;
  VideoPlayerController? _controller;
  VideoPlayerController? _playerController;
  double rating = 0;

  @override
  void initState() {
    if (widget.list.existing_solution_video != null) {
      _controller =
          VideoPlayerController.network(widget.list.existing_solution_video!);
      _controller!.initialize();
      _controller!.setLooping(true);
      _controller!.pause();
    }

    if (widget.list.proposed_solution_video != null) {
      _playerController =
          VideoPlayerController.network(widget.list.proposed_solution_video!);
      _playerController!.initialize();
      _playerController!.setLooping(true);
      _playerController!.pause();
    }

    super.initState();
  }

  Future<void> grade_project() async {
    var msg = {'suggestion_id': widget.list.id, 'value': rating.toInt()};
    final http.Response response = await http.post(
        Uri.parse(Uri.encodeFull(
            "https://phystechlab.ru/rosseti/public/api/suggestions/rating/store")),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
          'Content-type': 'multipart/form-data'
        },
        body: jsonEncode(msg));
    print(rating.toInt());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFAFBFD),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 68),
            headline(text: 'Создать'),
            SizedBox(height: 17),
            Text(
              'Cейчас так',
              style: TextStyle(color: Color(0xFF205692), fontSize: 20),
            ),
            SizedBox(height: 16),
            Container(
                padding: EdgeInsets.all(14.0),
                width: 305,
                height: 292,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(24),
                    color: Colors.white),
                child: SingleChildScrollView(
                  child: widget.list.existing_solution_text != null
                      ? Text(
                          widget.list.existing_solution_text!,
                          style:
                              TextStyle(fontSize: 20, color: Color(0xFF205692)),
                        )
                      : Text(''),
                )),
            SizedBox(height: 21),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 35),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                      height: 68,
                      width: 121,
                      child: widget.list.existing_solution_video != null
                          ? VideoPlayer(_controller!)
                          : null),
                  SizedBox(width: 61),
                  widget.list.existing_solution_image == null
                      ? Text('')
                      : Image.network(widget.list.existing_solution_image!,
                          height: 68, width: 121, fit: BoxFit.fill),
                ],
              ),
            ),
            SizedBox(height: 30),
            Text(
              'Надо так',
              style: TextStyle(color: Color(0xFF205692), fontSize: 20),
            ),
            SizedBox(height: 17),
            Container(
                padding: EdgeInsets.all(14.0),
                width: 305,
                height: 292,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(24),
                    color: Colors.white),
                child: SingleChildScrollView(
                  child: widget.list.proposed_solution_text != null
                      ? Text(
                          widget.list.proposed_solution_text!,
                          style:
                              TextStyle(fontSize: 20, color: Color(0xFF205692)),
                        )
                      : Text(''),
                )),
            SizedBox(height: 17),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 35),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                      height: 68,
                      width: 121,
                      child: widget.list.proposed_solution_video != null
                          ? VideoPlayer(_playerController!)
                          : null),
                  SizedBox(width: 61),
                  widget.list.proposed_solution_image == null
                      ? Text('')
                      : Image.network(widget.list.proposed_solution_image!,
                          height: 68, width: 121, fit: BoxFit.fill),
                ],
              ),
            ),
            SizedBox(height: 30),
            Text(
              'И тогда будет так ',
              style: TextStyle(color: Color(0xFF205692), fontSize: 20),
            ),
            SizedBox(height: 17),
            Container(
                padding: EdgeInsets.all(14.0),
                width: 305,
                height: 292,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(24),
                    color: Colors.white),
                child: SingleChildScrollView(
                  child: widget.list.positive_effect != null
                      ? Text(
                          widget.list.positive_effect!,
                          style:
                              TextStyle(fontSize: 20, color: Color(0xFF205692)),
                        )
                      : Text(''),
                )),
            SizedBox(height: 25),
            RatingBar.builder(
                initialRating: widget.list.rating!.toDouble(),
                minRating: 1,
                direction: Axis.horizontal,
                allowHalfRating: true,
                itemCount: 5,
                itemPadding: EdgeInsets.symmetric(horizontal: 10),
                itemBuilder: (context, _) => Icon(
                      Icons.star,
                      color: Colors.yellow,
                    ),
                onRatingUpdate: (rating) {
                  setState(() {
                    this.rating = rating;
                    grade_project();
                  });
                }),
            SizedBox(height: 45),
            Container(
              width: 305,
              height: 58,
              child: OutlinedButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => comment(list: widget.list),
                        ));
                  },
                  style: OutlinedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(24))),
                  child: Text(
                    'Обсудить',
                    style: TextStyle(fontSize: 20, color: Color(0xFF205692)),
                  )),
            ),
            SizedBox(height: 25)
          ],
        ),
      ),
    );
  }
}
