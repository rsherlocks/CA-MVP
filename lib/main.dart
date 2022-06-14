// @dart=2.9
import 'dart:async';
import 'dart:ffi';

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
  int _overCounter = 4;
  int _ballCounter = 1;
  TextEditingController _overNumberController = TextEditingController();
  TextEditingController _currentBallScoreController = TextEditingController();
  String matchName = "KPL - 2022";
  String team1 = "";
  String team2 = "";
  String matchTime = "07 July, 2022, 4:00 pm";
  String allDeliveries = "";
  List<String> scorePerBall = ["0", "0","0","0","0","0"];
  // String _firstBall = "0";
  // String _secondBall = "0";
  // String _thirdBall = "0";
  // String _fourthBall = "0";
  // String _fifthBall = "0";
  // String _sixthBall = "0";


   List<Player> player;
   Future future;

  @override
  initState() {
    super.initState();
    //todo get match info and team info
    setMatchInfo();
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

            const SizedBox(height: 5,),
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
            Text("Match Time: $matchTime", style: const TextStyle(fontSize: 17),),
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
            // Padding(
            //   padding: const EdgeInsets.fromLTRB(10,3,10,3),
            //   child: Row(
            //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //     children: [
            //       buildMaterialButton("Out", Colors.red),
            //       buildMaterialButton("Bye", Colors.orangeAccent),
            //       buildMaterialButton("Leg-bye", Colors.orangeAccent)
            //     ],
            //   ),
            // ),
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
                          var idOfDelivery = await insertDeliveryAndGetAllDelivery(int.parse(_currentBallScoreController.text), _overCounter);
                          allDeliveries += "${idOfDelivery.toString()},";
                          print("ALL DELIVERIES: $allDeliveries");
                          if(_ballCounter == 6){
                            final score = Score(matchId: 2, deliveriesBall: allDeliveries, overSerial: _overCounter);
                            await ScoreOperation().createScore(score);
                            allDeliveries = "";
                          }
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
        individualScore(scorePerBall[0]),
        individualScore(scorePerBall[1]),
        individualScore(scorePerBall[2]),
        individualScore(scorePerBall[3]),
        individualScore(scorePerBall[4]),
        individualScore(scorePerBall[5]),
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
                // await getOverDetailsByOverNumber(int.parse(_overNumberController.text));
                setState((){
                  getOverDetails(int.parse(_overNumberController.text));
                });

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
    final player = Player(name: "wahab", category: "Batsman");
    final team = Team(playerIdOne: 11, playerIdTwo: 12, playerIdThree: 13, playerIdFour: 14, playerIdFive: 15, playerIdSix: 16,
                        playerIdSeven: 17, playerIdEight: 18, teamName: "team ade");
    final delivery = DeliveryBall(strikerId: 101, nonStrikerId: 102, bowlerId: 141, run: 2, overId: 1);
    final match = Match( teamIdOne: 3, teamIdTwo: 4, matchName: "isct2", scoreId: 0);


    // await PlayerOperations().createPlayer(player);

    // await createNewMatch();

    // await PlayerOperations().deletePlayerById(3);

    // await DeliveryOperations().deleteDeliveryById(2);

    // await MatchOperation().deleteAllMatch();

    // var playerData = await PlayerOperations().getAllPlayer();
    // print("playerData size: ${playerData.length}");
    //
    // playerData.forEach((element) {
    //   print("Player ${element.id} || ${element.name} || ${element.category}");
    // });


    // await TeamOperations().createTeam(team);
    //
    //
    await getAllTeamData();
    //
    // teamData.forEach((element) {
    //     print("Team ${element.id}  & ${element.playerIdOne}  & ${element.teamName}");
    //
    // });
    // final player= Player(id:1, name: "Rakib2", category: "No");
    //
    //
    // final team=Team(playerIdOne: 101, playerIdTwo: 102, playerIdThree: 103, playerIdFour: 104, playerIdFive: 105, playerIdSix: 106, playerIdSeven: 107, playerIdEight: 108, teamName: "phonix");
    //await TeamOperations().createTeam(team);
    //var x=await PlayerOperations().searchAllPlayerByName("Rakib2");

    // var playerData = await TeamOperations().getAllTeamQuery();
    // playerData?.forEach((element) {
    //   print("player ${element.name}  & ${element.id}");
    // });
    // final delivery = DeliveryBall(strikerId: 101, nonStrikerId: 102, bowlerId: 141, run: 2, overId: 1);


    // var y= await TeamOperations().getAllTeam();
    // var y= await TeamOperations().searchAllTeamByName("phonix");
    // y?.forEach((element) {
    //   print("1111 ${element.teamName}  & ${element.playerIdOne}");
    // });

    // await insertDeliveryAndGetAllDelivery(3, 1);


    //var deliveryData=await DeliveryOperations().searchAllDeliveryByOverId(1);

    await getAllDeliveryData();
    // deliveryData?.forEach((element) {
    //   print("delivery ${element.strikerId}  & ${element.run}  & ${element.overId}");
    // });

    // await MatchOperation().createMatch(match);
    //
    await getAllMatchData();

    // var score = Score(matchId:2, overSerial: 1, deliveriesBall:"1,2,3,4");
    // await ScoreOperation().createScore(score);

    await getAllScoreData();


    // var matchDataQuery = await MatchOperation().getTwoTeamsQuery();
    // print("matchDataQuery size: ${matchDataQuery.length}");
    //
    // matchDataQuery?.forEach((element) {
    //   print("match team ${element.id}  & ${element.playerIdOne}   ${element.playerIdOne}");
    // });


    // print(x?.length);
    // this.player=(await players)! as List<Player>;
    // print(player);

  }


  Future<void> getAllTeamData() async {
    var teamData = await TeamOperations().getAllTeam();
    print("teamData size: ${teamData.length}");

    teamData?.forEach((element) {
      print("teamData id: ${element.id}  & playerIdOne: ${element.playerIdOne}  ||  teamName ${element.teamName}");
    });
  }


  Future<void> getAllScoreData() async {
    var scoreData= await ScoreOperation().getAllScore();
    print("scoreData size: ${scoreData.length}");

    scoreData?.forEach((element) {
      print("scoreData matchId: ${element.matchId}  & overSerial: ${element.overSerial}  deliveries: ${element.deliveriesBall}");
    });
  }


  Future<void> getAllMatchData() async {
    var matchData = await MatchOperation().getAllMatch();
    print("matchData size: ${matchData.length}");

    matchData?.forEach((element) {
      print("match matchid: ${element.id}  & matchName: ${element.matchName}");
    });
  }

  Future<void> createNewMatch() async{
    final match = Match(teamIdOne: 1, teamIdTwo: 2, matchName: matchName, scoreId: 0);

    var idOfMatch = await MatchOperation().createMatch(match);
    print("IdOfMatch: $idOfMatch");
  }


  Future<int> insertDeliveryAndGetAllDelivery(int run, int overNumber) async {
    final delivery = DeliveryBall(strikerId: 102, nonStrikerId: 101, bowlerId: 141, run: run, overId: overNumber);
    var idOfDelivery = await DeliveryOperations().createDelivery(delivery);
    print("ins: $idOfDelivery");

    return idOfDelivery;
  }


  Future<void> getOverDetailsByOverNumber(int id) async {
    var deliveryData = await DeliveryOperations().searchAllDeliveryByOverId(id).then((value) =>
        value == null ? print("value nulllll") :  assignValue(value)
    );
  }


  Future<void> getAllDeliveryData() async {
    var deliveryData = await DeliveryOperations().getAllDelivery();

    print("deliveryData size: ${deliveryData.length}");

    deliveryData?.forEach((element) {
      print("delivery id: ${element.id}  & ${element.run}  & ${element.overId}");
    });

  }

  Map<int, int> getIdsFromDeliveries(String deliveries){
    final splittedString = deliveries.split(',');
    final Map<int, int> ids = {
      for (int i = 0; i < splittedString.length; i++)
        if(splittedString[i].isNotEmpty)
          i: int.parse(splittedString[i])
    };
    print(ids);

    ids.forEach((key, value) {
      print("$key :: $value");
    });
    return ids;
  }


  assignValue(List value) {
    setState((){
      print("total value length ${value.length}");

      for(int i = 0; i<value.length; i++){
        scorePerBall[i] = value[i].run.toString();
      }

      print("updated value");
    });
  }

  void setMatchInfo() async{
    var match  = await MatchOperation().getMatchById(2);
    print(match.matchName);

    matchName = match.matchName;
    team1 = await TeamOperations().getTeamById(match.teamIdOne);
    team2 = await TeamOperations().getTeamById(match.teamIdTwo);
  }

  Future<void> getOverDetails(int overNumber) async {
    var score = await ScoreOperation().searchScoreByMatchIdAndOverNumber(2, overNumber);
    var deliveryIds = score.deliveriesBall;
    print(deliveryIds);

    var idsMap = getIdsFromDeliveries(deliveryIds);

    idsMap.forEach((key, value) async {
      var del = await DeliveryOperations().searchDeliveryById(value);
      scorePerBall[key] = del.run.toString();
      print("scoree-  key: $key || value: ${scorePerBall[key]} ");
    });

  }
}
