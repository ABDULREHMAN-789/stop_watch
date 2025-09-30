import 'dart:async';
import 'package:flutter/material.dart';

class home extends StatefulWidget {
  const home({super.key});

  @override
  State<home> createState() => _homeState();
}

class _homeState extends State<home> {
  // logical
  int seconds = 0, minutes = 0, hours = 0;
  String digitSecond = "00", digitMinutes = "00", digitHours = '00';
  Timer? timer;
  bool started = false;
  List laps = [];

  // creating stop timer function

  void stop() {
    timer!.cancel();
    setState(() {
      started = false;
    });
  }

  // creating restart  function
  void reset() {
    timer!.cancel();
    setState(() {
      seconds = 0;
      minutes = 0;
      hours = 0;

      digitSecond = "00";
      digitMinutes = "00";
      digitHours = "00";

      started = false;
    });
  }

  void addlaps() {
    String lap = "$digitHours:$digitMinutes:$digitSecond";
    setState(() {
      laps.add(lap);
    });
  }

  // creating start timer function

  void start() {
    started = true;

    // Use periodic timer instead of one-time timer
    timer = Timer.periodic(Duration(seconds: 1), (Timer timer) {
      int localSeconds = seconds + 1;
      int localMinutes = minutes;
      int localHours = hours;

      // Time logic fix
      if (localSeconds > 59) {
        localSeconds = 0;
        localMinutes++;
      }
      if (localMinutes > 59) {
        localMinutes = 0;
        localHours++;
      }

      // Update UI safely
      setState(() {
        seconds = localSeconds;
        minutes = localMinutes;
        hours = localHours;

        digitSecond = (seconds >= 10) ? "$seconds" : "0$seconds";
        digitMinutes = (minutes >= 10) ? "$minutes" : "0$minutes";
        digitHours = (hours >= 10) ? "$hours" : "0$hours";
      });
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.indigo,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "STOP WATCH APP ",
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 20),
              Text(
                "$digitHours:$digitMinutes:$digitSecond",
                style: TextStyle(fontSize: 80, fontWeight: FontWeight.bold),
              ),
              Container(
                height: 400,
                decoration: BoxDecoration(
                  color: Colors.white30,
                  borderRadius: BorderRadius.circular(20),
                ),
                // add list buildr
                child: ListView.builder(
                  itemCount: laps.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(18.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Center(child: Text("LAPS||")),
                          Text(
                            "Lap ${index + 1}",
                            style: TextStyle(color: Colors.white,),
                          ),
                          Text(
                                " ${laps[index]}",
                            style: TextStyle(color: Colors.white),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
              SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: RawMaterialButton(
                      onPressed: () {
                        (!started) ? start() : stop();
                      },
                      shape: StadiumBorder(
                        side: BorderSide(color: Colors.lightBlue),
                      ),
                      child: Text((!started)?"START": "PAUSE",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 20),
                  IconButton(
                      onPressed: (){
                        addlaps();
                      },
                      icon: Icon(Icons.flag)),
                  SizedBox(width: 20),
                  Expanded(
                    child: RawMaterialButton(
                      onPressed: () {
                        reset();
                      },
                      shape: StadiumBorder(
                        side: BorderSide(color: Colors.lightBlue),
                      ),
                      child: Text(
                        "RESET",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
