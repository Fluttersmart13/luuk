
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:luuk/Model/AllAnimeModel.dart';

class animePageActivity extends StatefulWidget{
  @override
  _animePageActivityState createState() => _animePageActivityState();
}

class _animePageActivityState extends State<animePageActivity> {
  late List<AllAnimeModel> dataList;
  late List<AllAnimeModel> data111;
  @override
  void initState() {
    callAnimeApi();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(padding: const EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 5,),
          Text("Anime series",textAlign: TextAlign.left, style: TextStyle(
              color:Colors.white,
              fontSize:20.0
          ),),
          SizedBox(height: 5,),
          Container(
            color: Colors.black,
            height: 230,
            child: new ListView.builder(
                itemCount: dataList.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (BuildContext ctxt, int index) {
                  AllAnimeModel setmodel = dataList[index];

                  print(setmodel.id.toString());
                  return  Container(
                    width: 150,
                    child: Card(
                      child: Column(
                        children: [
                          SizedBox(height: 10,),
                          ClipRRect(
                            borderRadius: BorderRadius.circular(0.0),
                            child: Image.network(setmodel.poster,
                              fit: BoxFit.cover,
                            ),
                          ),
                          SizedBox(height: 10,),
                          Expanded(child: Text(setmodel.canonicalTitle,textAlign: TextAlign.center,style: TextStyle(
                            fontSize: 10
                          ),)),
                          SizedBox(height: 5,),
                        ],
                      ),
                    ),
                  );
                }),
          )
        ],
      ),
    );
  }

  Future<List<AllAnimeModel>> callAnimeApi( ) async {
    dataList = <AllAnimeModel>[];
    String emailUrl =
        "https://kitsu.io/api/edge/anime/";
    var emailPopupResponse =
    await http.get(Uri.parse(emailUrl), headers: <String, String>{
      'Content-Type': 'application/vnd.api+json',
    });
    if (emailPopupResponse.statusCode == 200) {
      var Data = json.decode(emailPopupResponse.body);
      var resdata = Data['data'] as List;

      setState(() {
        for (var o in resdata) {

          print("attributes${o["attributes"]["posterImage"]["tiny"].toString()}");
          AllAnimeModel model = AllAnimeModel(o["id"],o["attributes"]["posterImage"]["tiny"], o["attributes"]["canonicalTitle"]);
          dataList.add(model);
        }
      });
    }
    return dataList;
  }
}