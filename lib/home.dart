import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_glow/flutter_glow.dart';
import 'package:google_fonts/google_fonts.dart';

import 'Detailpage.dart';
import 'data.dart';
import 'extraweather.dart';


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
          TodayWeather(),
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
  var focusNode = FocusNode();
  bool searchBar = false;
  Weather ? currentWeather;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: GlowContainer(
        height: MediaQuery.of(context).size.height / 1.5,
        margin: EdgeInsets.all(2.0),
        padding: EdgeInsets.only(top: 60, left: 30, right: 30),
        glowColor: Color(0xff00A1FF),
        borderRadius: BorderRadius.only(bottomLeft: Radius.circular(60), bottomRight: Radius.circular(60)),
        color: Color(0xff00A1FF),
        spreadRadius: 5,
        child: Column(
          children: [
            Container(
              child: searchBar
                  ? TextField(
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
                      onSubmitted: (value) {
                        fetchCity(value).then((city)async{
                         await fetchData(city!.lat.toString(), city.lon.toString(), city.name.toString()).then((value){
                           print(value);
                           setState(() {
                             currentWeather= value!;
                           });
                         });
                        });
                        var temp;
                        // showDialog(
                        //     context: context,
                        //     builder: (BuildContext context) {
                        //       return AlertDialog(
                        //         backgroundColor: Color(0xff030317),
                        //         title: Text('City Not Found'),
                        //         content: Text('Please Check The City Name'),
                        //         actions: [
                        //           TextButton(
                        //             onPressed: () {
                        //               Navigator.of(context).pop();
                        //             },
                        //             child: Text('Ok'),
                        //           )
                        //         ],
                        //       );
                        //     });
                      },
                    )
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Icon(
                          CupertinoIcons.square_grid_2x2,
                          color: Colors.white,
                        ),
                        Row(
                          children: [
                            Icon(
                              CupertinoIcons.map_fill,
                              color: Colors.white,
                            ),
                            GestureDetector(
                              onTap: () {
                                searchBar = true;
                                setState(() {});
                                focusNode.requestFocus();
                              },
                              child: Text(
                                currentWeather == null ? '--': '${currentWeather?.name.toString()}',
                                style: GoogleFonts.roboto(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 30,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Icon(
                          Icons.more_vert,
                          color: Colors.white,
                        ),
                      ],
                    ),
            ),
            Container(
              margin: EdgeInsets.only(top: 10.0),
              padding: EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                border: Border.all(width: 0.2, color: Colors.white),
                borderRadius: BorderRadius.circular(30.0),
              ),
              child: Text(
                'Updated',
                style: GoogleFonts.roboto(fontWeight: FontWeight.bold),
              ),
            ),
            Container(
              height: 220,
              child: Stack(
                children: [
                  Image(
                    image: AssetImage('assets/sunny.png'),
                    fit: BoxFit.fill,
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    left: 0,
                    child: Center(
                      child: Column(
                        children: [
                          GlowText(
                            currentWeather == null ? '0 ': '${currentWeather?.current.toString()}',
                            style: GoogleFonts.roboto(fontWeight: FontWeight.bold, fontSize: 40, height: 0.5),
                          ),
                          Text(
                            currentWeather == null ? '--': '${currentWeather?.name.toString()}',
                            style: GoogleFonts.roboto(fontWeight: FontWeight.bold, fontSize: 25),
                          ),
                          Text(
                            '15 / 6 / 2024 ',
                            style: GoogleFonts.roboto(fontWeight: FontWeight.bold, fontSize: 18),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Divider(
              color: Colors.white,
            ),
            SizedBox(
              height: 15,
            ),
            Row(
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
                      currentWeather == null ? '0' + ' ' 'K/m':'${currentWeather?.wind.toString()} K/m',
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
                      currentWeather == null ? '0%': '${currentWeather?.humidtiy.toString()}%',
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
                      currentWeather == null ? '0' + ' ' 'K/m':'${currentWeather?.chanceRain.toString()}%',
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
            )
          ],
        ),
      ),
    );
  }
}

class TodayWeather extends StatelessWidget {
  const TodayWeather({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 30, right: 30, top: 10),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Today',
                style: GoogleFonts.roboto(fontSize: 25, fontWeight: FontWeight.bold),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) {
                    return Detailpage();
                  }));
                },
                child: Row(
                  children: [
                    Text(
                      '7 Days',
                      style: GoogleFonts.roboto(color: Colors.grey, fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    Icon(
                      Icons.arrow_forward_ios_outlined,
                      color: Colors.grey,
                      size: 15,
                    )
                  ],
                ),
              ),
            ],
          ),
          SizedBox(
            height: 15,
          ),
          Container(
            margin: EdgeInsets.only(bottom: 30),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              weatherWidget(),
              weatherWidget(),
              weatherWidget(),
              weatherWidget(),
            ],
          ),
        ],
      ),
    );
  }
}

class weatherWidget extends StatelessWidget {
  const weatherWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(15),
      decoration: BoxDecoration(
        border: Border.all(width: 0.2, color: Colors.white),
        borderRadius: BorderRadius.circular(35),
      ),
      child: Column(
        children: [
          Text(
            '17' '+' '\u00B0',
            style: GoogleFonts.roboto(
              fontSize: 20,
            ),
          ),
          SizedBox(
            height: 5,
          ),
          Image(
            image: AssetImage('assets/sunny.png'),
            width: 50,
            height: 50,
          ),
          SizedBox(
            height: 5,
          ),
          Text(
            '12.00',
            style: GoogleFonts.roboto(fontSize: 16, color: Colors.grey),
          ),
        ],
      ),
    );
  }
}
