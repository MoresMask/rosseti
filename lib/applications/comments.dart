import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:intl/intl.dart';
import 'package:netwk/config.dart';
import 'package:netwk/network/articles.dart';

class Message {
  final String text;
  final String full_name;
  final DateTime date;
  final bool isSentByMe;

  Message(
      {required this.isSentByMe,
      required this.text,
      required this.full_name,
      required this.date});
}

class comment extends StatefulWidget {
  Articles list;
  comment({super.key, required this.list});

  @override
  State<comment> createState() => _commentState();
}

class _commentState extends State<comment> {
  List<Message> messagen = [];
  List<Message> messageses = [
    Message(
        text: 'Так точно',
        full_name: 'автор',
        date: DateTime.now(),
        isSentByMe: true),
    Message(
        isSentByMe: false, text: 'Да', full_name: 'Вы', date: DateTime.now()),
    Message(
        text: 'Так точно',
        full_name: 'автор',
        date: DateTime.now(),
        isSentByMe: true),
    Message(
        isSentByMe: false, text: 'Да', full_name: 'Вы', date: DateTime.now()),
    Message(
        text: 'Так точно',
        full_name: 'автор',
        date: DateTime.now(),
        isSentByMe: true),
    Message(
        isSentByMe: false, text: 'Да', full_name: 'Вы', date: DateTime.now()),
    Message(
        text: 'Так точно',
        full_name: 'автор',
        date: DateTime.now(),
        isSentByMe: true),
    Message(
        isSentByMe: false, text: 'Да', full_name: 'Вы', date: DateTime.now()),
    Message(
        text: 'Так точно',
        full_name: 'автор',
        date: DateTime.now(),
        isSentByMe: true),
    Message(
        isSentByMe: false, text: 'Да', full_name: 'Вы', date: DateTime.now()),
    Message(
        text: 'Так точно',
        full_name: 'автор',
        date: DateTime.now(),
        isSentByMe: true),
    Message(
        isSentByMe: false, text: 'Да', full_name: 'Вы', date: DateTime.now()),
    Message(
        text: 'Так точно',
        full_name: 'автор',
        date: DateTime.now(),
        isSentByMe: true),
    Message(
        isSentByMe: false, text: 'Да', full_name: 'Вы', date: DateTime.now()),
    Message(
        text: 'Так точно',
        full_name: 'автор',
        date: DateTime.now(),
        isSentByMe: true),
    Message(
        isSentByMe: false, text: 'Да', full_name: 'Вы', date: DateTime.now()),
    Message(
        text: 'Так точно',
        full_name: 'автор',
        date: DateTime.now(),
        isSentByMe: true),
    Message(
        isSentByMe: false, text: 'Да', full_name: 'Вы', date: DateTime.now()),
    Message(
        text: 'Так точно',
        full_name: 'автор',
        date: DateTime.now(),
        isSentByMe: true),
    Message(
        isSentByMe: false, text: 'Да', full_name: 'Вы', date: DateTime.now()),
    Message(
        text: 'Так точно',
        full_name: 'автор',
        date: DateTime.now(),
        isSentByMe: true),
    Message(
        isSentByMe: false, text: 'Да', full_name: 'Вы', date: DateTime.now()),
    Message(
        text: 'Так точно',
        full_name: 'автор',
        date: DateTime.now(),
        isSentByMe: true),
    Message(
        isSentByMe: false, text: 'Да', full_name: 'Вы', date: DateTime.now()),
  ].reversed.toList();

  @override
  void initState() {
    List<Message> messages = [];
    for (int i = 0; i < widget.list.comments!.length; i++) {
      if (widget.list.comments![i].text != null) {
        messages.add(Message(
            date: widget.list.comments![i].datetime!,
            isSentByMe: widget.list.comments![i].you == 0 ? false : true,
            text: widget.list.comments![i].text!,
            full_name: widget.list.comments![i].user!.full_name!));
      }
    }
    setState(() {
      messagen = messages;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(height: 68),
          headline(text: 'Обсуждение'),
          Expanded(
              child: GroupedListView<Message, DateTime>(
            padding: EdgeInsets.all(8.0),
            elements: messagen,
            useStickyGroupSeparators: true,
            groupBy: (messages) => DateTime(
                messages.date.year, messages.date.month, messages.date.day),
            groupHeaderBuilder: (Message message) => SizedBox(
              height: 40,
              child: Center(
                child: Card(
                    color: Theme.of(context).primaryColor,
                    child: Padding(
                      padding: EdgeInsets.all(8),
                      child: Text(
                        DateFormat.yMMMMd().format(message.date),
                        style: TextStyle(color: Colors.white),
                      ),
                    )),
              ),
            ),
            itemBuilder: (context, Message message) => Align(
              alignment: message.isSentByMe
                  ? Alignment.centerRight
                  : Alignment.centerLeft,
              child: Card(
                color: message.isSentByMe ? Color(0xFF205692) : Colors.white,
                elevation: 8,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(24),
                ),
                child: Padding(
                  padding:
                      EdgeInsets.only(bottom: 10, top: 10, left: 20, right: 20),
                  child: Text(message.text,
                      style: TextStyle(
                          color:
                              message.isSentByMe ? Colors.white : Colors.black,
                          fontSize: 18)),
                ),
              ),
            ),
          )),
          Container(
            margin: EdgeInsets.only(bottom: 20),
            width: 323,
            height: 58,
            child: TextField(
              decoration: InputDecoration(
                  hintText: 'Ваше сообщение',
                  suffixIcon: Container(
                    child: IconButton(
                      icon: Icon(Icons.arrow_upward),
                      focusColor: Color(0xFF205692),
                      onPressed: () {},
                    ),
                  ),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(66))),
              onSubmitted: (text) {
                final message = Message(
                    isSentByMe: true,
                    text: text,
                    full_name: 'Вы',
                    date: DateTime.now());
                setState(() {
                  messagen.add(message);
                });
              },
            ),
          )
        ],
      ),
    );
  }
}
