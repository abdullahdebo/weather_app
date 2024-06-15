import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ExtraWeather extends StatelessWidget {
  const ExtraWeather({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Column(
          children: [
            Icon(
              CupertinoIcons.wind,
              color: Colors.white,
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              '50' + ' ' 'K/m',
              style: GoogleFonts.roboto(fontSize: 17, fontWeight: FontWeight.bold, color: Colors.white),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              'Wind',
              style: GoogleFonts.roboto(fontSize: 17, fontWeight: FontWeight.bold, color: Colors.white),
            ),
          ],
        ),
        Column(
          children: [
            Icon(
              CupertinoIcons.drop,
              color: Colors.white,
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              '50' + '%',
              style: GoogleFonts.roboto(fontSize: 17, fontWeight: FontWeight.bold, color: Colors.white),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              'Humidity',
              style: GoogleFonts.roboto(fontSize: 17, fontWeight: FontWeight.bold, color: Colors.white),
            ),
          ],
        ),
        Column(
          children: [
            Icon(
              CupertinoIcons.cloud_rain,
              color: Colors.white,
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              '50' + ' ' 'K/m',
              style: GoogleFonts.roboto(fontSize: 17, fontWeight: FontWeight.bold, color: Colors.white),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              'Rain',
              style: GoogleFonts.roboto(fontSize: 17, fontWeight: FontWeight.bold, color: Colors.white),
            ),
          ],
        ),
      ],
    );
  }
}
