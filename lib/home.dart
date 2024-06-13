import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_glow/flutter_glow.dart';
import 'package:google_fonts/google_fonts.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff030317),
      body: Column(
        children: [
          CurrentWeather(),
        ],
      ),
    );
  }
}


class CurrentWeather extends StatefulWidget {
  const CurrentWeather({super.key});

  @override
  State<CurrentWeather> createState() => _CurrentWeatherState();
}

class _CurrentWeatherState extends State<CurrentWeather> {
  @override
  var focusNode = FocusNode();
  Widget build(BuildContext context) {
    return GestureDetector(
      child: GlowContainer(
        height: MediaQuery.of(context).size.height / 1.5,
        margin: EdgeInsets.all(2.0),
        padding: EdgeInsets.only(top: 60,left: 30,right: 30),
        glowColor: Color(0xff00A1FF),
        borderRadius: BorderRadius.only(bottomLeft: Radius.circular(60),bottomRight: Radius.circular(60)),
        color: Color(0xff00A1FF),
        spreadRadius: 5,
        child: Column(
          children: [
            Container(
              child: TextField(
                focusNode: focusNode,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  fillColor: Colors.black,
                  filled: true,
                  hintText: 'Enter a City Name',
                  hintStyle: GoogleFonts.roboto(),
                ),
                textInputAction: TextInputAction.search,
                onSubmitted: (value){
                  var temp;
                  if(temp == null){
                    showDialog(
                        context: context,
                        builder: (BuildContext context){
                          return AlertDialog(
                            backgroundColor: Color(0xff030317),
                            title: Text('City Not Found'),
                            content: Text('Please Check The City Name'),
                            actions: [
                              TextButton(
                                  onPressed: ()
                                  {
                                Navigator.of(context).pop();
                              },
                                  child: Text('Ok'),)
                            ],
                          );
                        }
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}



