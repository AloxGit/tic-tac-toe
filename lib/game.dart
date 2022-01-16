import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'gameParams.dart';
import 'dart:math';

class Game extends StatefulWidget {
  @override
  _GameState createState() => _GameState();
}

class _GameState extends State<Game> {
  Widget block(bool player, int i, context) {
    return Builder(builder: (BuildContext context){
      return Expanded(
        child: Container(
          height: 90,
          child: GestureDetector(
              child: Container(
                padding: EdgeInsets.all(30),
                color: Colors.transparent,
                height: 32,
                width: 32,
                child: AnimatedSwitcher(
                  duration: Duration(milliseconds: 300),
                  child: board[i~/3][i%3]=='_'?null:Image(image: AssetImage('assets/images/'+board[i~/3][i%3]+'.png'),
                  fit: BoxFit.fill,
                ),
              ),
              ),
              onTap: () async{
                if(board[i~/3][i%3]=='_') {
                  setState(() {
                    board[i~/3][i%3]=char;
//                    gameOver=true;
                  });

                  if(isMovesLeft()) {

                    int a=0;
                    if(winningMove()==10){
                      a=findBestMove();
                    } else {
                      a=winningMove();
                    }
                    await Future.delayed(const Duration(milliseconds: 150), () {
                      setState(() {
                        board[a~/3][a%3]=opponent;
                      });
                    });
                    if(isWinning()) {
//                      print("losy");
                      Future.delayed(const Duration(milliseconds: 300), () {
                        setState(() {
                          gameResult='You lost :(';
                          gameOver=true;
                        });
                      });

                    }
                    else if(!isMovesLeft()) {
//                      print("losy");
                      Future.delayed(const Duration(milliseconds: 300), () {
                        setState(() {
                          gameResult='It was a tie';
                          gameOver=true;
                        });
                      });

                    }


                  } else {
                    Future.delayed(const Duration(milliseconds: 300), () {
                      setState(() {
                        gameResult='It was a tie';
                        gameOver=true;
                      });
                    });
                  }
                }
              }
          ),
        ),
      );
    });
  }




  Widget sizedBox() {
    return SizedBox(
      width: 5,
      child: Container(
        color: Color(0xFF2C6171),
      ),
    );
  }

  void firstPlay(){
    if(player==2) {
      var rng = new Random();
      List corners=[[0, 0], [0, 2], [2, 0], [2, 2]];
      Future.delayed(const Duration(milliseconds: 300), () {
        setState(() {
          var pt=corners[rng.nextInt(4)];
          board[pt[0]][pt[1]]=opponent;
          print(board);
        });
      });

    }
  }


  @override
  void initState() {
    super.initState();
    setState(() {
      board=[
        ['_', '_', '_'],
        ['_', '_', '_'],
        ['_', '_', '_'],
      ];
      gameOver=false;

    });
//    print(player);
    firstPlay();

    }

  bool shouldPop = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          width: MediaQuery.of(context).size.width < 600
              ? MediaQuery.of(context).size.width / 1.3
              : 400,
          alignment: Alignment.center,
          height: MediaQuery.of(context).size.width / 1.3,
          child: AnimatedSwitcher(
            duration: Duration(milliseconds: 600),
            child: gameOver?Container(
              height: 200,
              child: Column(
                children: [
                  Text(gameResult,
                    style: TextStyle(
                        fontSize: 40,
                        fontWeight: FontWeight.w600,
                        color: Colors.black87),
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  RawMaterialButton(
                    fillColor: Color(0xFF2C6171),
                    elevation: 0.0,
                    splashColor: Color(0xff28A592),
                    child: Padding(
                        padding: EdgeInsets.fromLTRB(30, 10, 30, 10.0),
                        child: Text("Play again",
//            textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 30.0,
                              color: Colors.white,
//                        fontFamily: 'EuropaNuova',
                              fontWeight: FontWeight.w600),
                        )
                    ),
                    onPressed: () {
                      setState(() {
                        gameOver=false;
                        board=[
                          ['_', '_', '_'],
                          ['_', '_', '_'],
                          ['_', '_', '_'],
                        ];
                      });
                      firstPlay();
                    },
                    shape: const StadiumBorder(
                      side: BorderSide(
                        color: Color(0xff28A592),
                        width: 1.0,
                      ),
                    ),
                  )
                ],
              ),
            ):Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Expanded(
                    child: Row(
                      children: <Widget>[
                        block(true , 0, context),
                        sizedBox(),
                        block(true , 1, context),
                        sizedBox(),
                        block(true , 2, context),
                      ],
                    ),
                  ),
                  Divider(
                    color: Color(0xFF2C6171),
                    height: 10,
                    thickness: 5,
                  ),
                  Expanded(
                    child: Row(
                      children: <Widget>[
                        block(true , 3, context),
                        sizedBox(),
                        block(true , 4, context),
                        sizedBox(),
                        block(true , 5, context),
                      ],
                    ),
                  ),
                  Divider(
                    color: Color(0xFF2C6171),
                    height: 10,
                    thickness: 5,
                  ),
                  Expanded(
                    child: Row(
                      children: <Widget>[
                        block(true , 6, context),
                        sizedBox(),
                        block(true , 7, context),
                        sizedBox(),
                        block(true , 8, context),
                      ],
                    ),
                  ),
                ]
            ),
          ),
        ),
      ),
    );
  }
}
