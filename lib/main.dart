// @dart=2.9
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

class MyApp extends StatelessWidget {

   List<Player> player;
   Future future;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Crud"),
      ),

      body: Container(
        child: Column(
          children: <Widget>[
            RaisedButton(onPressed:onClick,child: Text("click"),)
          ],

        ),
      ),

    );

  }



  void onClick() async {
    final player= Player(id:1, name: "Rakib2", category: "No");


    final team=Team(playerIdOne: 101, playerIdTwo: 102, playerIdThree: 103, playerIdFour: 104, playerIdFive: 105, playerIdSix: 106, playerIdSeven: 107, playerIdEight: 108, teamName: "phonix");
    //await TeamOperations().createTeam(team);
    //var x=await PlayerOperations().searchAllPlayerByName("Rakib2");

    final delivery=DeliveryBall(strikerId: 101, nonStrikerId: 102, bowlerId: 141, run: 5, extraRun: 0);


    //var x = await PlayerOperations().getAllPlayer();
    // var y= await TeamOperations().getAllTeam();
    // var y= await TeamOperations().searchAllTeamByName("phonix");
    // y?.forEach((element) {
    //   print("1111 ${element.teamName}  & ${element.playerIdOne}");
    // });

    // await DeliveryOperations().createDelivery(delivery);
    // var deliveryData=await DeliveryOperations().getAllDelivery();

    
    var deliveryData=await DeliveryOperations().searchAllDeliveryById(1);

    deliveryData?.forEach((element) {
      print("delivery ${element.strikerId}  & ${element.run}");
    });

    // final match=Match( teamIdOne: 1, teamIdTwo: 2, matchName: "isct", scoreId: 1);
    // await MatchOperation().createMatch(match);

    // var matchData=await MatchOperation().getAllMatch();
    //
    // matchData?.forEach((element) {
    //   print("match ${element.teamIdOne}  & ${element.matchName}");
    // });

    // var score=Score(matchId:101, overSerial: 2, deliveriesBall:"1,2,3");
    // await ScoreOperation().createScore(score);

    var scoreData= await ScoreOperation().getAllScore();
    scoreData?.forEach((element) {
      print("match ${element.matchId}  & ${element.deliveriesBall}");
    });

    // x?.forEach((element) {
    //   print("1111 ${element.name}  & ${element.category}");
    // });
    // print(x?.length);
    // this.player=(await players)! as List<Player>;
    // print(player);

  }
}
