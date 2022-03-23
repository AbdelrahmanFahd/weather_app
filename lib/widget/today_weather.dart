import 'package:flutter/material.dart';
import '../model/weather.dart';
import '../screens/detail_screen.dart';

class TodayWeather extends StatefulWidget {
  const TodayWeather(
      {required this.tomorrowTempData,
      required this.todayWeatherData,
      required this.sevenDayData,
      Key? key})
      : super(key: key);
  final Weather tomorrowTempData;
  final List<Weather> todayWeatherData;
  final List<Weather> sevenDayData;

  @override
  State<TodayWeather> createState() => _TodayWeatherState();
}

class _TodayWeatherState extends State<TodayWeather> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 30.0, left: 30.0, top: 10),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Today',
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.w800)),
              GestureDetector(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (ctx) => DetailScreen(
                            tomorrowTempData: widget.tomorrowTempData,
                            sevenDayData: widget.sevenDayData,
                          )));
                },
                child: Row(children: const [
                  Text('7 days',
                      style: TextStyle(fontSize: 18, color: Colors.grey)),
                  Icon(
                    Icons.arrow_forward_ios_outlined,
                    size: 15,
                    color: Colors.grey,
                  )
                ]),
              ),
            ],
          ),
          const SizedBox(height: 15),
          Container(
            margin: const EdgeInsets.only(bottom: 30),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  WeatherWidget(widget.todayWeatherData[0]),
                  WeatherWidget(widget.todayWeatherData[1]),
                  WeatherWidget(widget.todayWeatherData[2]),
                  WeatherWidget(widget.todayWeatherData[3]),
                ]),
          ),
        ],
      ),
    );
  }
}

class WeatherWidget extends StatelessWidget {
  const WeatherWidget(this.weather, {Key? key}) : super(key: key);
  final Weather weather;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 11),
      decoration: BoxDecoration(
          border: Border.all(width: 1, color: Colors.white),
          borderRadius: BorderRadius.circular(35)),
      child: Column(children: [
        Text(
          weather.currentTemperature.toString() + '\u00B0',
          style: const TextStyle(fontSize: 20),
        ),
        const SizedBox(height: 5),
        Image(
          image: AssetImage(weather.image.toString()),
          width: 50,
          height: 50,
        ),
        const SizedBox(height: 5),
        Text(
          weather.time.toString(),
          style: const TextStyle(fontSize: 16, color: Colors.grey),
        ),
      ]),
    );
  }
}
