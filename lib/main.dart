// @dart=2.9
import 'dart:async';

import 'package:ca_mvp/data/delivery_operation.dart';
import 'package:ca_mvp/data/match%20operation.dart';
import 'package:ca_mvp/data/player_operation.dart';
import 'package:ca_mvp/data/score%20operation.dart';
import 'package:ca_mvp/data/team%20operation.dart';
import 'package:ca_mvp/models/delivery.dart';
import 'package:ca_mvp/models/match.dart';
import 'package:ca_mvp/models/player.dart';
import 'package:ca_mvp/models/score.dart';
import 'package:ca_mvp/models/team.dart';
import 'package:flutter/material.dart';

void main(){
  runApp(new MaterialApp(home: MyApp()));
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int _overCounter = 20;
  int _ballCounter = 1;
  TextEditingController _overNumberController = TextEditingController();
  TextEditingController _currentBallScoreController = TextEditingController();
  String matchName = "XYZ Tournament - 2022";
  String team1 = "Team_A";
  String team2 = "Team_B";
  String matchTime = "07 July, 2020, 03:00 PM";
  String _firstBall = "0";
  String _secondBall = "0";
  String _thirdBall = "0";
  String _fourthBall = "0";
  String _fifthBall = "0";
  String _sixthBall = "0";


   List<Player> player;
   Future future;

  @override
  void initState() {
    super.initState();
    //todo get match info and team info

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("MVP", textAlign: TextAlign.center,),
      ),

      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            ElevatedButton(onPressed: onClick, style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(Colors.green)
            ), child: const Text("Perform Operations"),),

            const SizedBox(height: 15,),
            Text(matchName, style: const TextStyle(fontSize: 20),),
            const SizedBox(height: 5,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Batting: $team1   ||", style: const TextStyle(fontSize: 17),),
                const SizedBox(width: 10,),
                Text("Bowling: $team2", style: const TextStyle(fontSize: 17),),
              ],
            ),
            const SizedBox(height: 5,),
            Text("Match Time: $matchTime"),
            const Text("---------------------------------------------------------------------------------------------"),
            const SizedBox(height: 10,),
            const Text("Enter over number to find detailed score", style: TextStyle(fontSize: 18),),
            const SizedBox(height: 5,),
            getOverDetailsRow(),
            const SizedBox(height: 10,),
            overDetailsRow(),
            const SizedBox(height: 10,),
            const Text("---------------------------------------------------------------------------------------------"),
            const SizedBox(height: 10,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Current Over: $_overCounter    ||   ", style: const TextStyle(fontSize: 18),),
                Text("Current Ball: $_ballCounter", style: const TextStyle(fontSize: 18),),
              ],
            ),
            const SizedBox(height: 10,),

            SizedBox(
              width: 180,
              height: 50,
              child: TextField(
                enabled: false,
                controller: _currentBallScoreController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  hintText: 'Enter score for ball $_ballCounter',
                ),
                textAlign: TextAlign.center,
              ),
            ),



            const SizedBox(height: 20,),
            buildRow("0", Colors.blueGrey, "1", Colors.blueGrey, "2", Colors.blueGrey, "3", Colors.blueGrey),
            buildRow("4", Colors.blueGrey, "6", Colors.blueGrey, "Wide", Colors.orangeAccent, "No ball", Colors.orangeAccent),
            Padding(
              padding: const EdgeInsets.fromLTRB(10,3,10,3),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  buildMaterialButton("Out", Colors.red),
                  buildMaterialButton("Bye", Colors.orangeAccent),
                  buildMaterialButton("Leg-bye", Colors.orangeAccent)
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(10,3,10,3),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  buildMaterialButton("Reset", Colors.black54),
                  MaterialButton(
                    color: Colors.green,
                    height: 45,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ), onPressed: () async {
                          FocusManager.instance.primaryFocus?.unfocus();
                          await insertDeliveryAndGetAllDelivery(int.parse(_currentBallScoreController.text), _overCounter);
                          updateRunAndBallCounter("Submit");
                        },
                    child: const Text("Submit", style: TextStyle(color: Colors.white, fontSize: 18),),
                  )
                ],
              ),
            ),
          ],
        ),
      ),

    );

  }

  Row overDetailsRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        individualScore(_firstBall),
        individualScore(_secondBall),
        individualScore(_thirdBall),
        individualScore(_fourthBall),
        individualScore(_fifthBall),
        individualScore(_sixthBall),
      ],
    );
  }

  Container individualScore(String score) {
    return Container(
      alignment: Alignment.center,
      width: 35,
      height: 30,
      color: Colors.amber.shade300,
      child: Text(score, style: const TextStyle(fontSize: 16),),
    );
  }

  Row getOverDetailsRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          width: 120,
          height: 50,
          child: TextField(
            controller: _overNumberController,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              hintText: 'Over',
            ),
          ),
        ),
        const SizedBox(width: 15,),
        MaterialButton(
          color: Colors.green,
          height: 45,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ), onPressed: () async {
                FocusManager.instance.primaryFocus?.unfocus();
                await getOverDetailsByOverNumber(int.parse(_overNumberController.text));
            },
          child: const Text("Submit", style: TextStyle(color: Colors.white, fontSize: 18),),
        )
      ],
    );
  }

  Padding buildRow(String firstButtonText, Color color1, String secondButtonText, Color color2, String thirdButtonText, Color color3, String fourthButtonText, Color color4,) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(10,10,10,3),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          buildMaterialButton(firstButtonText, color1),
          buildMaterialButton(secondButtonText, color2),
          buildMaterialButton(thirdButtonText, color3),
          buildMaterialButton(fourthButtonText, color4),
        ],
      ),
    );
  }

  MaterialButton buildMaterialButton(String buttonText, Color color) {
    return MaterialButton(
      color: color,
      height: 45,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ), onPressed: () {
      updateRunAndBallCounter(buttonText);
    },
      child: Text(buttonText, style: const TextStyle(color: Colors.white, fontSize: 18),),
    );
  }

  void updateRunAndBallCounter(String buttonText) {
    setState((){
      if((buttonText == "0") || (buttonText == "1") || (buttonText == "2") || (buttonText == "3" )|| (buttonText == "4") || (buttonText =="6")){
        _currentBallScoreController.text = buttonText;
      } else if(buttonText == "Out"){
        _currentBallScoreController.text = "W";
      } else if(buttonText == "Wide"){
        _currentBallScoreController.text = "Wd";
      } else if(buttonText == "No ball"){
        _currentBallScoreController.text = "N";
      } else if(buttonText == "Bye"){
        _currentBallScoreController.text = "B";
      } else if(buttonText == "Leg-bye"){
        _currentBallScoreController.text = "LB";
      } else if(buttonText == "Reset"){
        _currentBallScoreController.clear();
      } else if(buttonText == "Submit"){
          print("Current ball: $_ballCounter  || score: ${_currentBallScoreController.text}");
          _ballCounter++;
          _currentBallScoreController.clear();
      }


      if(_ballCounter == 7){
        _ballCounter = 1;
        _overCounter++;
      }
    });
  }


  void onClick() async {
    // final player= Player(id:1, name: "Rakib2", category: "No");
    //
    //
    // final team=Team(playerIdOne: 101, playerIdTwo: 102, playerIdThree: 103, playerIdFour: 104, playerIdFive: 105, playerIdSix: 106, playerIdSeven: 107, playerIdEight: 108, teamName: "phonix");
    //await TeamOperations().createTeam(team);
    //var x=await PlayerOperations().searchAllPlayerByName("Rakib2");

    // final delivery = DeliveryBall(strikerId: 101, nonStrikerId: 102, bowlerId: 141, run: 2, overId: 1);


    //var x = await PlayerOperations().getAllPlayer();
    // var y= await TeamOperations().getAllTeam();
    // var y= await TeamOperations().searchAllTeamByName("phonix");
    // y?.forEach((element) {
    //   print("1111 ${element.teamName}  & ${element.playerIdOne}");
    // });

    // await insertDeliveryAndGetAllDelivery(3, 1);


    await getAllDeliveryData();

    // final match=Match( teamIdOne: 1, teamIdTwo: 2, matchName: "isct", scoreId: 1);
    // await MatchOperation().createMatch(match);

    // var matchData=await MatchOperation().getAllMatch();
    //
    // matchData?.forEach((element) {
    //   print("match ${element.teamIdOne}  & ${element.matchName}");
    // });

    // var score=Score(matchId:101, overSerial: 2, deliveriesBall:"1,2,3");
    // await ScoreOperation().createScore(score);

    // var scoreData= await ScoreOperation().getAllScore();
    // scoreData?.forEach((element) {
    //   print("match ${element.matchId}  & ${element.deliveriesBall}");
    // });

    // x?.forEach((element) {
    //   print("1111 ${element.name}  & ${element.category}");
    // });
    // print(x?.length);
    // this.player=(await players)! as List<Player>;
    // print(player);

  }

  Future<void> insertDeliveryAndGetAllDelivery(int run, int overNumber) async {
    final delivery = DeliveryBall(strikerId: 102, nonStrikerId: 101, bowlerId: 141, run: run, overId: overNumber);
    await DeliveryOperations().createDelivery(delivery);

    // deliveryData?.forEach((element) {
    //   print("delivery ${element.strikerId}  & ${element.run}  & ${element.overId}");
    // });
    // return delivery;
  }



  Future<void> getOverDetailsByOverNumber(int id) async {
    var deliveryData = await DeliveryOperations().searchAllDeliveryById(id).then((value) =>
        value == null ? print("value nulllll") :  insertValue(value)
    );


    // print("abc: ${deliveryData[0]}");
    // print("avbc: ${deliveryData[1]}");


    // for (var element in deliveryData) {
    //   print("delivery ${element.strikerId}  & ${element.run}  & ${element.overId}");
    // }
    // return deliveryData;



  }
  Future<void> getAllDeliveryData() async {
    await DeliveryOperations().getAllDelivery().then((value) => value.forEach((element) {
      // Timer(Duration(milliseconds: 300), () {
      print("delivery ${element.strikerId}  & ${element.run}  & ${element.overId}");
      // });


    }));


  }

  insertValue(List value) {
    setState((){
      print("total value length ${value.length}");

      _firstBall = value[0].run.toString();
      _secondBall = value[1].run.toString();
      _thirdBall = value[2].run.toString();
      _fourthBall = value[3].run.toString();
      _fifthBall = value[4].run.toString();
      // _sixthBall = value[5].run.toString();

      print("updated value");
    });


  }
}
