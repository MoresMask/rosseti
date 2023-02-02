import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../applications/applications.dart';
import 'create_offer_page.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFAFBFD),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 35),
        child: Center(
          child: Column(children: [
            SizedBox(height: 68),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(width: 40),
                Text(
                  'seti.inno',
                  style: TextStyle(fontSize: 36, color: Color(0xFF205692)),
                ),
                Image.asset('assets/images/icon.png')
              ],
            ),
            SizedBox(height: 21),
            Container(
              width: 305,
              height: 165,
              child: OutlinedButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => CreateOffer()));
                },
                style: OutlinedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(24))),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Image.asset('assets/images/create.png'),
                    SizedBox(width: 21),
                    Text('Создать\n приложение',
                        textAlign: TextAlign.center,
                        style:
                            TextStyle(fontSize: 20, color: Color(0xFF205692)))
                  ],
                ),
              ),
            ),
            SizedBox(height: 35),
            Container(
              width: 305,
              height: 165,
              child: OutlinedButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (_) => Application()));
                },
                style: OutlinedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(24))),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Image.asset('assets/images/idea.png'),
                    SizedBox(width: 21),
                    Text('Заявки',
                        textAlign: TextAlign.center,
                        style:
                            TextStyle(fontSize: 20, color: Color(0xFF205692)))
                  ],
                ),
              ),
            ),
            SizedBox(height: 35),
            Container(
              width: 305,
              height: 165,
              child: OutlinedButton(
                onPressed: () {},
                style: OutlinedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(24))),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Image.asset('assets/images/skills.png'),
                    SizedBox(width: 21),
                    Text('Экспертизы',
                        textAlign: TextAlign.center,
                        style:
                            TextStyle(fontSize: 20, color: Color(0xFF205692)))
                  ],
                ),
              ),
            ),
          ]),
        ),
      ),
    );
  }
}

class ButtonWidget extends StatelessWidget {
  String image;
  String text;
  ButtonWidget({super.key, required this.image, required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 305,
      height: 165,
      child: OutlinedButton(
        onPressed: () {},
        style: OutlinedButton.styleFrom(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(24))),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Image.asset(image),
            SizedBox(width: 21),
            Text(text,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 20, color: Color(0xFF205692)))
          ],
        ),
      ),
    );
  }
}
