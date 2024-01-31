import 'dart:math';

import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  CountDownController timeController=CountDownController();
  Random random = Random();
  int randomNumContainerText = 00;
  int clickAttempts=0;
  int timerFailures=0;

  int getRandomNumber() {
    return random.nextInt(60);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Title'),),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
        //  mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 30,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black),
                    borderRadius: BorderRadius.circular(15),
                    color: Colors.blue[50]
                  ),
                  child: Column(
                    children: [
                      Text('Current Second'),
                      Divider(height: 30,),
                      Text(DateTime.timestamp().second.toString())
                    ],
                  ),
                ),
                SizedBox(width: 30,),
                Container(padding:  EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black),
                      borderRadius: BorderRadius.circular(15),
                      color: Colors.red[300]
                  ),
                  child: Column(
                    children: [
                      Text('Random Number'),
                      Divider(height: 30,),
                      Text(randomNumContainerText.toString())
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 40,),
            Container(
              padding: EdgeInsets.all(30),
              decoration: BoxDecoration(
                border: Border.all(),
                borderRadius: BorderRadius.circular(15),
                color: randomNumContainerText==DateTime.timestamp().second? Colors.green : Colors.amber
              ),
              child: Column(
                children: [
                  randomNumContainerText==DateTime.timestamp().second? Text('Success:)',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.white),):
                      Text('Sorry try again',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.white),),
                  Divider(height: 30,),
                  randomNumContainerText==DateTime.timestamp().second? Text('Score',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.white),):
                      Text('Attempts : ${clickAttempts}',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.white))

                ],
              ),
            ),
            SizedBox(height: 20,),
            CircularCountDownTimer(
                width: MediaQuery.of(context).size.width/2,
                height: MediaQuery.of(context).size.width/2,
                duration: 5,
                fillColor: Colors.grey,
                ringColor: Colors.green,
            controller: timeController,
            strokeWidth: 10,
            isReverse: true,
            autoStart: false,
            textStyle: TextStyle(fontSize: 40),
            onComplete: (){

                  setState(() {
                    timerFailures++;
                    print('timer over=${timerFailures}');
                  });
            },
            ),
            SizedBox(height: 20,),
            ElevatedButton(onPressed: (){
              timeController.start();
              int randomNumber = getRandomNumber();
              setState(() {
                randomNumContainerText = randomNumber;
                clickAttempts++;
                print('clicks= ${clickAttempts}');
              });
            }, child: Text('Click'),style: ElevatedButton.styleFrom(maximumSize: Size(250, 100)),)
          ],
        ),
      ),
    );
  }
}
