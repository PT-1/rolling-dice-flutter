import 'dart:math';
import "package:flutter/material.dart";

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with SingleTickerProviderStateMixin{
  static int diceLimit = 6;
  int leftDice = 1;
  int rightDice = 2;
  AnimationController _controller;
  CurvedAnimation animation;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    animate();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _controller.dispose();
  }

  animate() {
    _controller = AnimationController(duration: Duration(milliseconds: 1500), vsync: this);
    animation = CurvedAnimation(parent: _controller, curve: Curves.bounceInOut);
    animation.addListener(() {
      setState(() {

      });
      print(_controller.value);
    });
    animation.addStatusListener((status)
    {
      if (status == AnimationStatus.completed) {
        setState(() {
          leftDice = randomNum(diceLimit);
          rightDice = randomNum(diceLimit);
        });
        print("Completed");
        _controller.reverse();
      }
    });
  }
  void changingDice() {
    _controller.forward();

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Roll the dice'),
      ),
      body: Center(
        child: Column(
          children: [
            const SizedBox(
              height: 100,
            ),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(onDoubleTap: changingDice,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Image(height: 100-(animation.value*100),
                        image: AssetImage("asset/images/Dice$leftDice.png"),
//                        height: 150,
                      ),
                    ),
                  ),
                  GestureDetector(onDoubleTap: changingDice,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Image(height: 100-(animation.value*100),
                          image: AssetImage("asset/images/Dice$rightDice.png"),
//                          height: 150,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Center(
                child: RaisedButton(
                  hoverElevation: 15.0,
                  onPressed: () => changingDice(),
                  disabledTextColor: Colors.redAccent,
                  child: Text(
                    "Roll",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

int randomNum(int max) {
  var toReturn = Random();
  return toReturn.nextInt(max) + 1;
}
