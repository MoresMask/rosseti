import 'package:flutter/material.dart';
import 'package:netwk/Page/main_page.dart';
import 'package:netwk/auth/phone.dart';
import 'package:netwk/icons/vector_icons.dart';

import 'Page/create_offer_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      // home: MyHomePage(),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFAFBFD),
      body: Center(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 141),
              child: Image.asset('assets/images/image_1.png'),
            ),
            const SizedBox(height: 50),
            const Text('seti.inno',
                style: TextStyle(fontSize: 62, color: Color(0xFF205692))),
            const SizedBox(height: 10),
            const Text(
              'Рационализатор',
              style: TextStyle(fontSize: 20, color: Color(0xFF2C2929)),
            ),
            const SizedBox(height: 199),
            Container(
                width: 305,
                height: 58,
                child: OutlinedButton(
                  style: OutlinedButton.styleFrom(
                      elevation: 20,
                      shadowColor: Color.fromARGB(45, 0, 0, 0),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(24))),
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => PhoneNumber()));
                  },
                  child: Text(
                    'Регистрация',
                    style: TextStyle(fontSize: 20, color: Color(0xFF205692)),
                  ),
                )),
          ],
        ),
      ),
    );
  }
}
