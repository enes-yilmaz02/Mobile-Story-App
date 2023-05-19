// ignore_for_file: use_key_in_widget_constructors, library_private_types_in_public_api, prefer_const_constructors, sort_child_properties_last

import 'package:flutter/material.dart';
import 'dart:math';

void main() {
  runApp(SayiToplamaOyunu());
}

class SayiToplamaOyunu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sayı Toplama Oyunu',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: OyunEkrani(),
    );
  }
}

class OyunEkrani extends StatefulWidget {
  @override
  _OyunEkraniState createState() => _OyunEkraniState();
}

class _OyunEkraniState extends State<OyunEkrani> {
  List<int> secilenSayilar = [];
  late int randomSayi;
  int kalanHak = 3;

  @override
  void initState() {
    super.initState();
    yeniOyunBaslat();
  }

  void yeniOyunBaslat() {
    setState(() {
      secilenSayilar.clear();
      randomSayi = _uretRandomSayi();
      kalanHak = 3;
    });
  }

  int _uretRandomSayi() {
    Random random = Random();
    return (random.nextInt(5) + 1) * 10;
  }

  void sayiSec(int sayi) {
    setState(() {
      if (kalanHak > 0) {
        secilenSayilar.add(sayi);
        kalanHak--;

        if (secilenSayilar.length == 3) {
          if (secilenSayilar.reduce((a, b) => a + b) == randomSayi) {
            _oyunSonucDialog(true);
          } else {
            _oyunSonucDialog(false);
          }
        } else if (kalanHak == 0) {
          _oyunSonucDialog(false);
        }
      }
    });
  }

  void _oyunSonucDialog(bool kazandiMi) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Oyun Bitti'),
          content: Text(kazandiMi
              ? 'Tebrikler, kazandınız!'
              : 'Üzgünüz, tekrar deneyiniz.'),
          actions: [
            TextButton(
              child: Text('Tamam'),
              onPressed: () {
                yeniOyunBaslat();
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sayı Toplama Oyunu'),
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/dart.jpeg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GridView.builder(
              shrinkWrap: true,
              itemCount: 5,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 5,
                childAspectRatio: 1.0,
                crossAxisSpacing: 10.0,
                mainAxisSpacing: 10.0,
              ),
              itemBuilder: (BuildContext context, int index) {
                int sayi = (index + 1) * 10;
                return TextButton(
                  onPressed: (kalanHak > 0) ? () => sayiSec(sayi) : null,
                  child: Text(
                    sayi.toString(),
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.transparent),
                    padding: MaterialStateProperty.all<EdgeInsets>(
                        EdgeInsets.all(10.0)),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        side: BorderSide(color: Colors.white),
                      ),
                    ),
                  ),
                );
              },
            ),
            SizedBox(height: 20.0),
            Text('Seçilen Sayılar: ${secilenSayilar.join(', ')}'),
            SizedBox(height: 10.0),
            Text('Kalan Hak: $kalanHak'),
          ],
        ),
      ),
    );
  }
}
