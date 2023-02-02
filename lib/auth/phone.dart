import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:netwk/auth/sms.dart';
import 'package:http/http.dart' as http;

class PhoneNumber extends StatefulWidget {
  const PhoneNumber({super.key});

  @override
  State<PhoneNumber> createState() => _PhoneNumberState();
}

class _PhoneNumberState extends State<PhoneNumber> {
  final TextEditingController numberTextController = TextEditingController();

  void dispose() {
    numberTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFAFBFD),
      body: Center(
        child: Column(
          children: [
            SizedBox(height: 273),
            Container(
              width: 305,
              height: 58,
              child: TextField(
                  controller: numberTextController,
                  decoration: InputDecoration(
                      hintText: 'Телефон',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(24)))),
            ),
            SizedBox(height: 17),
            Container(
                width: 305,
                height: 58,
                child: OutlinedButton(
                    style: OutlinedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(24))),
                    onPressed: () {
                      login();
                    },
                    child: Text(
                      'Далее',
                      style: TextStyle(color: Color(0xFF205692), fontSize: 20),
                    )))
          ],
        ),
      ),
    );
  }

  Future<void> login() async {
    if (numberTextController.text.isNotEmpty) {
      var response = await http.post(
          Uri.parse("https://phystechlab.ru/rosseti/public/api/auth/phone"),
          body: ({'phone': numberTextController.text}));
      if (response.statusCode == 200) {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => SmsScreen()));
      } else {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('Invaild Credentils')));
      }
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Invaild')));
    }
  }
}
