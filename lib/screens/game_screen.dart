import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';

class GameScreen extends StatefulWidget {
  @override
  _GameScreenState createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  double ballX = 0; // Posisi horizontal bola
  double ballY = -1; // Posisi vertikal bola
  double playerX = 0; // Posisi horizontal pemain
  int score = 0; // Skor pemain
  bool gameOver = false;

  late Timer gameTimer;

  void startGame() {
    setState(() {
      score = 0;
      ballX = 0;
      ballY = -1;
      gameOver = false;
    });

    gameTimer = Timer.periodic(Duration(milliseconds: 50), (timer) {
      setState(() {
        ballY += 0.05;

        if (ballY >= 1) {
          // Cek apakah bola tertangkap
          if ((ballX - playerX).abs() < 0.2) {
            score++;
            resetBall();
          } else {
            gameOver = true;
            timer.cancel();
          }
        }
      });
    });
  }

  void resetBall() {
    setState(() {
      ballX = Random().nextDouble() * 2 - 1; // Posisi acak
      ballY = -1; // Reset ke atas
    });
  }

  void movePlayer(String direction) {
    setState(() {
      if (direction == "left" && playerX > -1) {
        playerX -= 0.1;
      } else if (direction == "right" && playerX < 1) {
        playerX += 0.1;
      }
    });
  }

  @override
  void dispose() {
    gameTimer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueAccent,
      appBar: AppBar(
        title: Text('Catch the Ball'),
        centerTitle: true,
      ),
      body: gameOver
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Game Over',
                    style: TextStyle(fontSize: 30, color: Colors.white),
                  ),
                  Text(
                    'Score: $score',
                    style: TextStyle(fontSize: 20, color: Colors.white),
                  ),
                  ElevatedButton(
                    onPressed: startGame,
                    child: Text('Restart'),
                  ),
                ],
              ),
            )
          : Stack(
              children: [
                // Bola
                Positioned(
                  top: MediaQuery.of(context).size.height * (ballY + 1) / 2,
                  left: MediaQuery.of(context).size.width * (ballX + 1) / 2,
                  child: Container(
                    width: 30,
                    height: 30,
                    decoration: BoxDecoration(
                      color: Colors.red,
                      shape: BoxShape.circle,
                    ),
                  ),
                ),

                // Pemain
                Positioned(
                  bottom: 50,
                  left: MediaQuery.of(context).size.width * (playerX + 1) / 2 -
                      50,
                  child: Container(
                    width: 100,
                    height: 20,
                    color: Colors.green,
                  ),
                ),

                // Skor
                Positioned(
                  top: 20,
                  left: 20,
                  child: Text(
                    'Score: $score',
                    style: TextStyle(fontSize: 20, color: Colors.white),
                  ),
                ),
              ],
            ),
      bottomNavigationBar: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          IconButton(
            icon: Icon(Icons.arrow_left, color: Colors.white),
            onPressed: () => movePlayer("left"),
          ),
          IconButton(
            icon: Icon(Icons.arrow_right, color: Colors.white),
            onPressed: () => movePlayer("right"),
          ),
        ],
      ),
    );
  }
}
