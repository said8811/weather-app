import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:weatherapp/models/details/hourly.dart';
import 'package:weatherapp/models/weatherapp.dart';
import 'package:weatherapp/screens/map.dart';
import 'package:weatherapp/screens/secondpage.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'dart:convert';

class HomeWeather extends StatefulWidget {
  HomeWeather({super.key});

  @override
  State<HomeWeather> createState() => _HomeWeatherState();
}

class _HomeWeatherState extends State<HomeWeather> {
  DateTime now = DateTime.now();
  String url =
      "https://api.openweathermap.org/data/2.5/onecall?lat=41.2646&lon=69.2163&units=metric&exclude=minutely&appid=4a8eaf9ed512f638cdd7a82434895402";

  Future<OneCallData?> getData() async {
    var response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      var json = jsonDecode(response.body) as Map<String, dynamic>;
      return OneCallData.fromJson(json);
    }

    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Container(
        decoration: const BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
              Color(0xFFFFEBD0),
              Color(0xFFFBC295),
              Color(0xFFFFBD82)
            ])),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Container(
                      width: 30, height: 30, child: Icon(Icons.search)),
                ),
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: InkWell(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (_) => MapPage()));
                    },
                    child: Container(
                        width: 30,
                        height: 35,
                        child: const Icon(Icons.menu_rounded)),
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 26,
            ),
            FutureBuilder(
                future: getData(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (snapshot.hasError) {
                    return Center(child: Text(snapshot.error.toString()));
                  }
                  if (snapshot.hasData) {
                    return Container(
                      width: double.infinity,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(left: 22.0),
                            child: Text(
                              "${snapshot.data?.timezone}",
                              style: const TextStyle(
                                  fontSize: 25, fontWeight: FontWeight.w700),
                            ),
                          ),
                          const SizedBox(
                            height: 6,
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 22),
                            child: Text(
                              "${DateFormat.MMMEd().format(now)}",
                              style: TextStyle(color: Colors.grey),
                            ),
                          ),
                          Center(
                            child: Row(
                              children: [
                                Image(
                                  image: NetworkImage(
                                      'https://openweathermap.org/img/wn/${snapshot.data?.currentModel.weather[0].icon.substring(0, 2)}d@4x.png'),
                                  width: 240,
                                  height: 240,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(right: 20.0),
                                  child: Column(
                                    children: [
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            width: 40,
                                            height: 90,
                                            child: Padding(
                                              padding: EdgeInsets.only(top: 15),
                                              child: Text(
                                                "${snapshot.data?.currentModel.temp.toInt()}",
                                                style: const TextStyle(
                                                    fontSize: 63,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ),
                                          ),
                                          const Image(
                                            image: AssetImage(
                                                'assets/images/degree.png'),
                                          ),
                                        ],
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(right: 8.0),
                                        child: Text(
                                          "${snapshot.data?.currentModel.weather[0].main}",
                                          style: TextStyle(fontSize: 25),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Center(
                            child: Container(
                              padding:
                                  const EdgeInsets.only(right: 28, left: 10),
                              height: 70,
                              width: 320,
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.3),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(14)),
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Container(
                                        padding: const EdgeInsets.all(6),
                                        width: 32,
                                        height: 32,
                                        decoration: BoxDecoration(
                                          boxShadow: const [
                                            BoxShadow(
                                                color: Colors.grey,
                                                blurRadius: 5)
                                          ],
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          color: Colors.white,
                                        ),
                                        child: const Image(
                                          image: AssetImage(
                                              'assets/images/dewpoint.png'),
                                          width: 40,
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      const Text("Dew point")
                                    ],
                                  ),
                                  Text(
                                      "${snapshot.data?.currentModel.dewPoint}")
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 7,
                          ),
                          Center(
                            child: Container(
                              padding: EdgeInsets.only(right: 28),
                              height: 70,
                              width: 320,
                              decoration: BoxDecoration(
                                  color: Colors.white.withOpacity(0.3),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(14))),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: const [
                                      Image(
                                        image: AssetImage(
                                            'assets/images/wind.png'),
                                        height: 70,
                                      ),
                                      Text("Wind")
                                    ],
                                  ),
                                  Text(
                                      "${snapshot.data?.currentModel.windSpeed.toInt()}km/h")
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 7,
                          ),
                          Center(
                            child: Container(
                              padding: EdgeInsets.only(right: 28),
                              height: 70,
                              width: 320,
                              decoration: BoxDecoration(
                                  color: Colors.white.withOpacity(0.3),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(14))),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Padding(
                                          padding: const EdgeInsets.only(
                                            left: 14,
                                          ),
                                          child: Center(
                                            child: Container(
                                              width: 32,
                                              height: 32,
                                              decoration: const BoxDecoration(
                                                borderRadius: BorderRadius.all(
                                                  Radius.circular(7),
                                                ),
                                                color: Colors.white,
                                              ),
                                              child: Image.asset(
                                                  'assets/images/branch.png'),
                                            ),
                                          )),
                                      const SizedBox(
                                        width: 12,
                                      ),
                                      Text("Humidty")
                                    ],
                                  ),
                                  Text(
                                      "${snapshot.data?.currentModel.humidity}%")
                                ],
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 30, vertical: 12),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: const [
                                    Text(
                                      "Today",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                    SizedBox(
                                      width: 12,
                                    ),
                                    Text(
                                      "Tomorrow",
                                      style:
                                          TextStyle(color: Color(0xFFD6996B)),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        setState(() {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) => SecondP(
                                                      model: snapshot.data!)));
                                        });
                                      },
                                      child: const Text(
                                        "Next days  >",
                                        style:
                                            TextStyle(color: Color(0xFFD6996B)),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Container(
                              height: 97,
                              child: ListView.separated(
                                  separatorBuilder: (context, index) {
                                    return const SizedBox(
                                      width: 12,
                                    );
                                  },
                                  scrollDirection: Axis.horizontal,
                                  itemCount: 12,
                                  shrinkWrap: true,
                                  itemBuilder: ((context, index) {
                                    return Wether(snapshot.data?.hourly[index]);
                                  })))
                        ],
                      ),
                    );
                  }
                  return Container();
                })
          ],
        ),
      )),
    );
  }
}

Widget Wether(HourlyItem? hourlyItem) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 5),
    height: 50,
    width: 55,
    decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.3),
        borderRadius: BorderRadius.circular(30)),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "${DateTime.fromMillisecondsSinceEpoch((hourlyItem?.dt ?? 1668841200) * 1000).toString().substring(11, 16)}",
          style: const TextStyle(color: Colors.grey),
        ),
        const SizedBox(
          height: 5,
        ),
        Image(
          image: NetworkImage(
              'https://openweathermap.org/img/wn/${hourlyItem?.weather[0].icon.substring(0, 2)}d@4x.png'),
          width: 50,
        ),
        Text(
          "${hourlyItem?.temp.toInt()} °",
          style: const TextStyle(fontWeight: FontWeight.bold),
        )
      ],
    ),
  );
}
