import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class Weather {
  final int? max;
  final int? min;
  final int? current;
  final String? name;
  final String? day;
  final int? wind;
  final int? humidtiy;
  final int? chanceRain;
  final String? image;
  final String? time;
  final String? location;
  Weather({this.max, this.min, this.current, this.name, this.day, this.wind, this.humidtiy, this.chanceRain, this.image, this.time, this.location});
}

String apId = '78d153b81299a5d35bc4bfb05c6c7022';

Future<Weather?> fetchData(String lat, String lon, String city) async {
  var response = await http.get(Uri.parse('https://api.openweathermap.org/data/2.5/weather?lat=$lat&lon=$lon&appid=$apId&units=metric'));
  if (response.statusCode == 200) {
    var res = json.decode(response.body);
    var current = res['main'];
    Weather currentTemp = Weather(
        current: current['temp'].round(),
        name: res['weather'][0]['main'],
        day: DateFormat('EEEE dd MMMM').format(DateTime.fromMillisecondsSinceEpoch(res['dt'] * 1000)),
        wind: res['wind']['speed'].round(),
        humidtiy: current['humidity'],
        chanceRain: 0,
        location: res['name'],
        image: findIcon(res['weather'][0]['main'].toString()));
    return currentTemp;
  }
}

String? findIcon(String name) {
  switch (name) {
    case "Clouds":
      return 'assets/sunny.png';
      break;
    case "Rain":
      return 'assets/rainy.png';
      break;
    case "Drizzle":
      return 'assets/rainy.png';
      break;
    case "Thunderstorm":
      return 'assets/thunder.png';
      break;
    case "Snow":
      return 'assets/snow.png';
      break;
    default:
      return 'assets/sunny.png';
      break;
  }
}

class CityModel {
  final String? name;
  final String? lat;
  final String? lon;
  CityModel({this.name, this.lat, this.lon});
}


Future<CityModel?> fetchCity(String city) async {
    String link = 'https://raw.githubusercontent.com/dr5hn/countries-states-cities-database/master/cities.json';
    var response = await http.get(Uri.parse(link));
    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      for (var i = 0; i < data.length; i++) {
        if (data[i]['name'].toString().toLowerCase() == city.toLowerCase()) {
          print(data[i]);
          return CityModel(
            name: data[i]['name'].toString(),
            lat: data[i]['latitude'].toString(),
            lon: data[i]['longitude'].toString(),
          );
        }
      }
  }

  return null;
}
