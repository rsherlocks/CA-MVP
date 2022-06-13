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
    final player= Player(name: "akib", category: "No");
    final team=Team(playerIdOne: 3, playerIdTwo: 102, playerIdThree: 103, playerIdFour: 104, playerIdFive: 105, playerIdSix: 106, playerIdSeven: 107, playerIdEight: 108, teamName: "phoenix");
    final delivery=DeliveryBall(strikerId: 101, nonStrikerId: 102, bowlerId: 141, run: 2, overId: 1);
    final match=Match( teamIdOne: 3, teamIdTwo: 4, matchName: "isct2", scoreId: 0);


    // await PlayerOperations().createPlayer(player);
    //
    // var playerData=await PlayerOperations().getAllPlayer();
    // playerData.forEach((element) {
    //   print("Player ${element.id}  & ${element.name}");
    //
    // });


    // await TeamOperations().createTeam(team);
    //
    //
    // var teamData=await TeamOperations().getAllTeam();
    //
    // teamData.forEach((element) {
    //     print("Team ${element.id}  & ${element.playerIdOne}  & ${element.teamName}");
    //
    // });

    // var playerData = await TeamOperations().getAllTeamQuery();
    // playerData?.forEach((element) {
    //   print("player ${element.name}  & ${element.id}");
    // });


    // var y= await TeamOperations().getAllTeam();
    // var y= await TeamOperations().searchAllTeamByName("phonix");
    // y?.forEach((element) {
    //   print("1111 ${element.teamName}  & ${element.playerIdOne}");
    // });

    // await DeliveryOperations().createDelivery(delivery);
    // var deliveryData=await DeliveryOperations().getAllDelivery();

    
    //var deliveryData=await DeliveryOperations().searchAllDeliveryByOverId(1);

    // deliveryData?.forEach((element) {
    //   print("delivery ${element.strikerId}  & ${element.run}  & ${element.overId}");
    // });

    // await MatchOperation().createMatch(match);
    //
    // var matchData=await MatchOperation().getAllMatch();
    //
    // matchData?.forEach((element) {
    //   print("match ${element.id}  & ${element.matchName}");
    // });

    var score=Score(matchId:2, overSerial: 1, deliveriesBall:"1,2,3,4");
    // await ScoreOperation().createScore(score);

    // var scoreData= await ScoreOperation().getAllScore();
    // scoreData?.forEach((element) {
    //   print("match ${element.matchId}  & ${element.deliveriesBall}");
    // });

    var matchDataQuery = await MatchOperation().getAllMatchQuery();
    matchDataQuery?.forEach((element) {
      print("match ${element.id}  & ${element.matchName}   ${element.teamIdOne}");
    });


    // print(x?.length);
    // this.player=(await players)! as List<Player>;
    // print(player);

  }
}
