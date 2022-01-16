import 'package:flutter/material.dart';
import 'gameParams.dart';
import 'game.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
//      backgroundColor: Color(0xff28A592),
      body: Container(
        padding: EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
//          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text("Your character",
                  style: TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.w600,
                      color: Colors.black87),
                ),

                GestureDetector(
                  child: Column(
                    children: [
                      Container(
                        height: 32,
                        width: 32,
                        child: AnimatedSwitcher(
                          duration: Duration(milliseconds: 150),
                          child: char=='x'?Image(image: AssetImage('assets/images/'+char+'.png'),
                            fit: BoxFit.fill,
                          ):Container(
                            child: Image(image: AssetImage('assets/images/'+char+'.png'),
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                      ),
                      Container(
                        width: 32,
                        child: Divider(
                          color: Color(0xFF2C6171),
                          height: 10,
                          thickness: 3,
                        ),
                      ),
                    ],
                  ),
                    onTap: () {
                      setState(() {
                        if(char=='x') {
                          char='o';
                          opponent='x';
                        } else {
                          char='x';
                          opponent='o';
                        }
                      });}
                )
              ],
            ),
            SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text("Turn",
                  style: TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.w600,
                      color: Colors.black87),
                ),
                GestureDetector(
                  child: Column(
                    children: [
                      AnimatedSwitcher(
                        duration: Duration(milliseconds: 150),
                        child: player==1?Text(player.toString(),
                          style: TextStyle(fontSize: 40, fontWeight: FontWeight.w600, color: Colors.black87),
                        ):Container(
                          child: Text(player.toString(),
                            style: TextStyle(fontSize: 40, fontWeight: FontWeight.w600, color: Colors.black87),
                          ),
                        ),
                      ),
                      Container(
                        width: 32,
                        child: Divider(
                          color: Color(0xFF2C6171),
                          height: 1,
                          thickness: 3,
                        ),
                      ),
                    ],
                  ),
                  onTap: () {
                    setState(() {
                      player=3-player;
                    });}
                )
              ],
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
                  child: Text("Start",
                    style: TextStyle(
                        fontSize: 30.0,
                        color: Colors.white,
                        fontWeight: FontWeight.w600),
                  )
              ),
              onPressed: () {
                setState(() {
                  board=[
                    ['_', '_', '_'],
                    ['_', '_', '_'],
                    ['_', '_', '_'],
                  ];
                });
                print(board);
                Navigator.of(context).push(MaterialPageRoute(builder: (_) => Game()));
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
      ),
    );
  }
}
