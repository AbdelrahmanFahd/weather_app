import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_glow/flutter_glow.dart';

import '../model/weather.dart';
import 'extra_weather.dart';

class CurrentWeather extends StatefulWidget {
  const CurrentWeather(
      {required this.isUpdate,
      required this.currentTempData,
      required this.getData,
      Key? key})
      : super(key: key);
  final Weather currentTempData;
  final void Function(bool fromSearch, String cityName) getData;
  final bool isUpdate;
  @override
  State<CurrentWeather> createState() => _CurrentWeatherState();
}

class _CurrentWeatherState extends State<CurrentWeather> {
  bool searchBar = false;
  final controller = TextEditingController();

  void toggleSearchBar() {
    setState(() {
      searchBar = !searchBar;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GlowContainer(
      height: MediaQuery.of(context).size.height - 250,
      margin: const EdgeInsets.only(top: 1),
      padding: const EdgeInsets.only(top: 50, left: 30, right: 30),
      glowColor: Colors.deepPurple.withOpacity(.4),
      borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(50), bottomRight: Radius.circular(50)),
      // color: const Color(0xff00A1FF).withOpacity(.7),
      color: Colors.deepPurple.withOpacity(0.7),
      spreadRadius: 5,
      child: SingleChildScrollView(
        child: Column(children: [
          searchBar
              ? TextField(
                  controller: controller,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)),
                    fillColor: const Color(0xff030317),
                    filled: true,
                    hintText: 'Enter a city Name',
                  ),
                  textInputAction: TextInputAction.search,
                  onSubmitted: (_) {
                    toggleSearchBar();
                    widget.getData(true, controller.text);
                  },
                )
              : GestureDetector(
                  onTap: toggleSearchBar,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Icon(CupertinoIcons.square_grid_2x2),
                      //appBar
                      Row(
                        children: [
                          const Icon(CupertinoIcons.map_fill),
                          SizedBox(
                            width: 200,
                            child: FittedBox(
                              fit: BoxFit.scaleDown,
                              child: Text(
                                ' ' +
                                    widget.currentTempData.location.toString(),
                                style: const TextStyle(
                                    fontSize: 30, fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const Icon(Icons.more_vert)
                    ],
                  ),
                ),
          // state of api

          GestureDetector(
            onTap: widget.isUpdate
                ? null
                : () {
                    widget.getData(false, 'Cairo');
                  },
            child: Container(
              margin: const EdgeInsets.only(top: 10),
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  border: Border.all(width: 1, color: Colors.white)),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (widget.isUpdate)
                    const SizedBox(
                        height: 15,
                        width: 15,
                        child: CircularProgressIndicator()),
                  if (widget.isUpdate) const SizedBox(width: 10),
                  Text(
                    widget.isUpdate ? 'Updating' : 'Update',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ),

          //weather
          Container(
            margin: const EdgeInsets.only(top: 20),
            height: 400,
            child: Column(
              children: [
                //image of weather
                SizedBox(
                  height: 180,
                  child: Image(
                    image: AssetImage(widget.currentTempData.image.toString()),
                    fit: BoxFit.cover,
                  ),
                ),

                //currentTemperature
                Text(
                  widget.currentTempData.currentTemperature.toString(),
                  style: const TextStyle(
                      height: 0.5, fontSize: 100, fontWeight: FontWeight.bold),
                ),
                Text(
                  widget.currentTempData.name.toString(),
                  style: const TextStyle(fontSize: 25),
                ),
                Text(
                  widget.currentTempData.day.toString(),
                  style: const TextStyle(fontSize: 18),
                ),
                const Divider(color: Colors.white),
                const SizedBox(height: 10),
                ExtraWeather(widget.currentTempData),
              ],
            ),
          ),
        ]),
      ),
    );
  }
}
