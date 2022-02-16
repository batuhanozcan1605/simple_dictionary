import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:dictionary/Kelimeler.dart';
import 'package:dictionary/detailed_screen.dart';
import 'package:flutter/material.dart';

import 'KelimelerCevap.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  bool searching = false;
  String searchingWord = "";

  List<Kelimeler> parseKelimelerCevap(String cevap) {
    return KelimelerCevap.fromJson(json.decode(cevap)).kelimeListesi;
  }

  Future<List<Kelimeler>> tumKelimeleriGoster() async {
    var url = "http://kasimadalan.pe.hu/sozluk/tum_kelimeler.php";
    var cevap = await http.get(Uri.parse(url));
    return parseKelimelerCevap(cevap.body);
  }

  Future<List<Kelimeler>> aramaYap(String searchingWord) async {
    var url = "http://kasimadalan.pe.hu/sozluk/kelime_ara.php";
    var veri = {"ingilizce":searchingWord};
    var cevap = await http.post(Uri.parse(url), body: veri);
    return parseKelimelerCevap(cevap.body);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: searching ? TextField(
          decoration: InputDecoration(
            hintText: "Arama için bir şey yazın."),
          onChanged: (result){
            print("Arama sonucu:$result");
            setState(() {
              searchingWord = result;
            });
          },
        ) : Text("TUR - ENG Dictionary"),
        actions: [
          searching ?
          IconButton(
              onPressed:() {
                setState(() {
                  searching = false;
                  searchingWord = '';
                });
              },
              icon: Icon(Icons.cancel)):
          IconButton(
              onPressed: (){
                setState(() {
                  searching = true;
                });
            }, icon: Icon(Icons.search))
        ],
      ),
      body: FutureBuilder<List<Kelimeler>>(
        future: searching ? aramaYap(searchingWord) : tumKelimeleriGoster(),
        builder: (context, snapshot){
          if(snapshot.hasData){
            var kelimelerListesi = snapshot.data;
            return ListView.builder(
                itemCount: kelimelerListesi!.length,
                itemBuilder: (context, index){
                  var kelime = kelimelerListesi[index];
                  return GestureDetector(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context) => DetailedScreen(kelime: kelime,)));
                    },
                    child: SizedBox(
                      height: 50,
                      child: Card(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(kelime.ingilizce, style: TextStyle(fontWeight: FontWeight.bold),),
                            Text(kelime.turkce),
                          ],
                        ),
                      ),
                    ),
                  );
                }
            );
            }else{
            return Center();
          }
        }
      ),
    );
  }
}
