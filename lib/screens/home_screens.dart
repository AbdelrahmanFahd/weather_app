import 'package:flutter/material.dart';
import '../dummy_data.dart';
import '../model/weather.dart';
import '../widget/current_weather.dart';
import '../widget/today_weather.dart';
import '../model/location.dart';

Weather currentTempData = currentTemp;
Weather tomorrowTempData = tomorrowTemp;
List<Weather> todayWeatherData = todayWeather;
List<Weather> sevenDayData = sevenDay;

String lat = '33.44';
String log = '-94.04';
String city = 'Cairo';
bool isUpdating = false;

class HomeScreens extends StatefulWidget {
  const HomeScreens({Key? key}) : super(key: key);

  @override
  State<HomeScreens> createState() => _HomeScreensState();
}

class _HomeScreensState extends State<HomeScreens> {
  void getData(bool fromSearch, String cityName) async {
    setState(() {
      isUpdating = true;
    });
    if (fromSearch) {
      final location = await getNamedLocation(cityName);
      lat = location.lat;
      log = location.log;
      city = location.name;
    } else {
      final location = await getLocation();
      lat = location!.lat;
      log = location.log;
      city = location.name;
    }
    await fetchData(lat, log, city).then((value) {
      setState(() {
        currentTempData = value[0];
        tomorrowTempData = value[1];
        todayWeatherData = value[2];
        sevenDayData = value[3];
        isUpdating = false;
      });
    });
  }

  @override
  void initState() {
    super.initState();
    getData(false, 'Cairo');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff030317),
      body: SingleChildScrollView(
        child: Column(children: [
          CurrentWeather(
              currentTempData: currentTempData,
              getData: getData,
              isUpdate: isUpdating),
          TodayWeather(
              todayWeatherData: todayWeatherData,
              sevenDayData: sevenDayData,
              tomorrowTempData: tomorrowTempData),
        ]),
      ),
    );
  }
}
