import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:http/http.dart' as http;
import '../Page/main_page.dart';

class SmsScreen extends StatefulWidget {
  const SmsScreen({super.key});

  @override
  State<SmsScreen> createState() => _SmsScreenState();
}

class _SmsScreenState extends State<SmsScreen> {
  final TextEditingController smsCodeVerification = TextEditingController();
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
                  controller: smsCodeVerification,
                  decoration: InputDecoration(
                      hintText: 'Код из СМС',
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
    if (smsCodeVerification.text == '1111') {
      var response = await http.post(
          Uri.parse(
              "https://phystechlab.ru/rosseti/public/api/auth/verify-code"),
          body: ({
            'code': smsCodeVerification.text,
          }));
      if (response.statusCode == 200) {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => MainPage()));
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
