// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors, library_private_types_in_public_api

import 'dart:math';
import 'package:flutter/material.dart';

void main() {
  runApp(NumberGameApp());
}

class NumberGameApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Number Game',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: NumberGameScreen(),
    );
  }
}

class NumberGameScreen extends StatefulWidget {
  @override
  _NumberGameScreenState createState() => _NumberGameScreenState();
}

class _NumberGameScreenState extends State<NumberGameScreen> {
  late int targetNumber;
  List<int> selectedNumbers = [];

  @override
  void initState() {
    super.initState();
    generateTargetNumber();
  }

  void generateTargetNumber() {
    final random = Random();
    targetNumber = (random.nextInt(5) + 1) *
        10; // Rastgele 10 ve katlarından bir hedef sayı üretme
  }

  void selectNumber(int number) {
    setState(() {
      if (!selectedNumbers.contains(number)) {
        selectedNumbers.add(number);
      }
    });
    checkTargetNumber();
  }

  void checkTargetNumber() {
    int sum =
        selectedNumbers.fold(0, (previous, current) => previous + current);
    if (sum == targetNumber) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Tebrikler!'),
            content: Text('Hedef sayıya ulaştınız.'),
            actions: [
              TextButton(
                child: Text('Tamam'),
                onPressed: () {
                  generateTargetNumber();
                  selectedNumbers.clear();
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    } else if (sum > targetNumber) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Üzgünüz!'),
            content: Text('Hedef sayıya ulaşamadınız. Tekrar deneyin.'),
            actions: [
              TextButton(
                child: Text('Tamam'),
                onPressed: () {
                  selectedNumbers.clear();
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Sayı Toplama Oyunu')),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/dart.jpeg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          children: [
            SizedBox(height: 20),
            Text(
              'Hedef Sayı: $targetNumber',
              style: TextStyle(fontSize: 24),
            ),
            SizedBox(height: 20),
            GridView.count(
              crossAxisCount: 2,
              shrinkWrap: true,
              children: List.generate(5, (index) {
                int number = (index + 1) * 10;
                return GestureDetector(
                  onTap: () => selectNumber(number),
                  child: Container(
                    margin: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(
                          10), // Kenarlıkları yuvarlak yapma
                      color: Colors.white
                          .withOpacity(0.5), // Şeffaf beyaz arka plan
                    ),
                    child: Center(
                      child: Text(
                        number.toString(),
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight:
                              FontWeight.bold, // Kalın ve belirgin font stil
                        ),
                      ),
                    ),
                  ),
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}
