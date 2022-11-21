import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:weatherapp/models/details/daily.dart';
import 'package:weatherapp/models/weatherapp.dart';
import 'package:intl/intl.dart';

class SecondP extends StatefulWidget {
  OneCallData model;
  SecondP({super.key, required this.model});

  @override
  State<SecondP> createState() => _SecondPState();
}

class _SecondPState extends State<SecondP> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20),
        decoration: BoxDecoration(
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
            Container(
              padding: EdgeInsets.only(top: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  InkWell(
                    onTap: () {
                      setState(() {
                        Navigator.pop(context);
                      });
                    },
                    child: Container(
                        width: 30, height: 30, child: Icon(Icons.arrow_back)),
                  ),
                  const SizedBox(
                    width: 90,
                  ),
                  const Text(
                    "Next 7 Days",
                    style: TextStyle(fontSize: 15),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 35,
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              width: double.infinity,
              height: 186,
              decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.4),
                  borderRadius: BorderRadius.circular(15)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Tomorrow",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Row(
                        children: [
                          Text(
                            "${widget.model.daily[1].dailyTemp.day.toInt()} °",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Image(
                            image: NetworkImage(
                                'https://openweathermap.org/img/wn/${widget.model.daily[1].weather[0].icon.substring(0, 2)}d@4x.png'),
                            width: 70,
                          )
                        ],
                      )
                    ],
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Container(
                            padding: const EdgeInsets.all(8),
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.white,
                            ),
                            child: const Image(
                              image: AssetImage('assets/images/dewpoint.png'),
                              width: 40,
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Text("${widget.model.daily[1].dewPoint}")
                        ],
                      ),
                      SizedBox(
                        width: 25,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Container(
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.white,
                            ),
                            child: Image(
                              image: AssetImage('assets/images/winding.png'),
                              width: 70,
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text("${widget.model.daily[1].windSpeed} km/h")
                        ],
                      ),
                      SizedBox(
                        width: 25,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Container(
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.white,
                            ),
                            child: const Image(
                              image: AssetImage('assets/images/branch.png'),
                              width: 70,
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Text("${widget.model.daily[1].humidity} %")
                        ],
                      ),
                    ],
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 25,
            ),
            Container(
              child: Expanded(
                  child: ListView.separated(
                      separatorBuilder: (context, index) {
                        return const SizedBox(height: 10);
                      },
                      itemCount: 7,
                      itemBuilder: ((context, index) {
                        return Wetherinfo(widget.model.daily[index]);
                      }))),
            )
          ],
        ),
      )),
    );
  }
}

Widget Wetherinfo(DailyItem dailyItem) {
  return Container(
    height: 70,
    padding: const EdgeInsets.only(left: 25, right: 10),
    decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.4),
        borderRadius: BorderRadius.circular(10)),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          "${DateFormat.EEEE().format(DateTime.fromMillisecondsSinceEpoch(dailyItem.dt * 1000))}",
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        Row(
          children: [
            Text(
              "${dailyItem.dailyTemp.day.toInt()} °",
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            Image(
              image: NetworkImage(
                  'https://openweathermap.org/img/wn/${dailyItem.weather[0].icon.substring(0, 2)}d@4x.png'),
              width: 70,
            )
          ],
        ),
      ],
    ),
  );
}
