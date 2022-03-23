import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../model/weather.dart';

class ExtraWeather extends StatelessWidget {
  const ExtraWeather(this.temp, {Key? key}) : super(key: key);
  final Weather temp;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Column(
          children: [
            const Icon(CupertinoIcons.wind),
            const SizedBox(height: 10),
            Text(
              temp.wind.toString() + ' Km/m',
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
            ),
            const SizedBox(height: 10),
            const Text(
              'Wind',
              style: TextStyle(color: Colors.black54, fontSize: 16),
            )
          ],
        ),
        Column(
          children: [
            const Icon(CupertinoIcons.wind),
            const SizedBox(height: 10),
            Text(
              temp.humidity.toString() + ' %',
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
            ),
            const SizedBox(height: 10),
            const Text(
              'Humidity',
              style: TextStyle(color: Colors.black54, fontSize: 16),
            )
          ],
        ),
        Column(
          children: [
            const Icon(CupertinoIcons.wind),
            const SizedBox(height: 10),
            Text(
              temp.chanceRain.toString() + ' %',
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
            ),
            const SizedBox(height: 10),
            const Text(
              'Rain',
              style: TextStyle(color: Colors.black54, fontSize: 16),
            )
          ],
        ),
      ],
    );
  }
}
