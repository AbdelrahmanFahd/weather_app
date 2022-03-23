import 'package:flutter/material.dart';
import 'package:flutter_glow/flutter_glow.dart';
import '../widget/extra_weather.dart';
import '../model/weather.dart';

class DetailScreen extends StatelessWidget {
  const DetailScreen(
      {required this.tomorrowTempData, required this.sevenDayData, Key? key})
      : super(key: key);
  final Weather tomorrowTempData;
  final List<Weather> sevenDayData;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff030317),
      body: Column(children: [
        TomorrowWeather(tomorrowTempData),
        SevenDays(sevenDayData),
      ]),
    );
  }
}

class TomorrowWeather extends StatelessWidget {
  const TomorrowWeather(this.tomorrowTempData, {Key? key}) : super(key: key);
  final Weather tomorrowTempData;
  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return GlowContainer(
      glowColor: Colors.deepPurple.withOpacity(.4),
      borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(50), bottomRight: Radius.circular(50)),
      color: Colors.deepPurple.withOpacity(0.7),
      spreadRadius: 5,
      child: Column(
        children: [
          Padding(
            padding:
                const EdgeInsets.only(top: 50, left: 30, right: 30, bottom: 30),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                      child: const Icon(Icons.arrow_back_ios_outlined)),
                  Row(children: const [
                    Icon(Icons.calendar_today),
                    Text(
                      ' 7 days',
                      style:
                          TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                    ),
                  ]),
                  const Icon(Icons.more_vert)
                ]),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    // height: deviceSize. / 2.3,
                    width: deviceSize.width / 2.3,
                    child: Image(
                        image: AssetImage(tomorrowTempData.image.toString())),
                  ),
                  Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Text(
                          'Tomorrow',
                          style: TextStyle(height: .5, fontSize: 30),
                        ),
                        SizedBox(
                          height: 110,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              GlowText(
                                tomorrowTempData.maxTemperature.toString(),
                                style: const TextStyle(
                                    fontSize: 100, fontWeight: FontWeight.bold),
                              ),
                              Text(
                                '/' +
                                    tomorrowTempData.minTemperature.toString() +
                                    '\u00B0',
                                textAlign: TextAlign.end,
                                style: TextStyle(
                                    fontSize: 40,
                                    color: Colors.black54.withOpacity(0.3)),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          ' ' + tomorrowTempData.name.toString(),
                          style: const TextStyle(fontSize: 15),
                        ),
                      ]),
                ]),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 20, right: 50, left: 50),
            child: Column(children: [
              const Divider(color: Colors.white),
              const SizedBox(height: 10),
              ExtraWeather(tomorrowTempData),
            ]),
          ),
        ],
      ),
    );
  }
}

class SevenDays extends StatelessWidget {
  const SevenDays(this.sevenDayData, {Key? key}) : super(key: key);
  final List<Weather> sevenDayData;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
          itemCount: sevenDayData.length,
          itemBuilder: (ctx, index) => Padding(
                padding:
                    const EdgeInsets.only(left: 20.0, right: 20, bottom: 25),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      sevenDayData[index].day.toString(),
                      style: const TextStyle(fontSize: 20),
                    ),
                    SizedBox(
                      width: 135,
                      child: Row(children: [
                        Image(
                            width: 40,
                            image: AssetImage(
                                sevenDayData[index].image.toString()),
                            fit: BoxFit.fill),
                        const SizedBox(width: 15),
                        Text(
                          ' ' + sevenDayData[index].name.toString(),
                        ),
                      ]),
                    ),
                    Text.rich(
                      TextSpan(children: [
                        TextSpan(
                            text: '+' +
                                sevenDayData[index].maxTemperature.toString() +
                                '\u00B0',
                            style: const TextStyle(fontSize: 20)),
                        TextSpan(
                          text: '  +' +
                              sevenDayData[index].minTemperature.toString() +
                              '\u00B0',
                          style: TextStyle(
                              fontSize: 20, color: Colors.grey.withOpacity(.7)),
                        ),
                      ]),
                    )
                  ],
                ),
              )),
    );
  }
}
