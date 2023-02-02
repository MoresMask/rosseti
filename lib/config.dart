import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

String token =
    "eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiIxIiwianRpIjoiZWRjODRmMzNiOWJhNDU2ZmNmNWRkMWMzYzkzNjJlYTJhNjllMTM1NjY0ZTk1MjE1MGY5Y2U4YmFiNzc4YjU5NmQ2MzNkNTcyZTI3MjU0YzYiLCJpYXQiOjE2NzUzNDc0OTgsIm5iZiI6MTY3NTM0NzQ5OCwiZXhwIjoxNzA2ODgzNDk4LCJzdWIiOiIxNjQiLCJzY29wZXMiOltdfQ.VDSdRx1L1lwjzvuyBtiRBekPmQGvdUdpPZ8EQEGY160wroJDaJUJAgE0j4KinKyQ7Utt6wQh_KJwMUbOmf6hXC7QVU2_65c8ps3WMA5TQWDYSiY-o4IXVPPAdTNkICeczPilJKxLOE9BKsFz3OJBu-fHRmtr9ItfP9bDE1iqHENYinPcqjDhwtxNHII3ua7e-rIQXnHK-zhwvtRbFx2KRK5AVaLhK1y1RMnXZgoPFznGvFtFxn4EutsoTeNZw8vHVNR1AvQB28cJUCHP9clpqsLOfoIf50yyNrH0xjiuNpoXao4ONMWEmmTFgy48mtV8kMCYjG-P5ArWv6RGkerz5Czo-SS8Z51UVe6FAl5gn60_j7B0y9A3B-WYYaZvAw_Gfg0tD6JzXTCH8bGPlnB9QXlV3jGxuYe4KGzT9MMgQsSzBlhrSZK2UFY2arrCz822mLDdq6HpAu_D2wbEJlC9P5Gt21Xh76jfNiYzhWKgxjYIKqzpqs1s5rn8CAUW2t__CyfzSgBRTYs1zP8hfqFj9DhFfq-nSD2SaIRfxXoyDxamZ9LkKm358LdP-igDQ2gVGcA01nY2l2ansuuYdUsN41Q0BsAdh5SJIuodQkSY4LfJHxxqOE4vgLBeYKe0NyEDhJNp40haQKK6lbaKoODX3l3R9XJAzjMRIZghIBjq9p8";

class headline extends StatelessWidget {
  final String text;
  const headline({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back)),
        Text(
          text,
          style: TextStyle(fontSize: 36, color: Color(0xFF205692)),
        ),
        Image.asset('assets/images/icon.png')
      ],
    );
  }
}
