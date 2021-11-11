import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:luuk/Page/ViewUi.dart';
import 'Model/AllAnimeModel.dart';
import 'Page/SeriesPageActivity.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      // title: 'Flutter Demo',
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
      ),
      home: MyHomePage(title: "LUUK's"),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: homescreen(),
    );
  }
}

class homescreen extends StatefulWidget{


  @override
  _homescreenState createState() => _homescreenState();
}

class _homescreenState extends State<homescreen> {
  TextEditingController tc = new TextEditingController();
  List<AllAnimeModel>  dataList = <AllAnimeModel>[];
  List<AllAnimeModel>  searchList = <AllAnimeModel>[];
  var isLoading=false;
  String query = '';

  List results = [];
  List rows = [];
  List bannerList = [];
  @override
  void initState() {
    callAnimeApi();
    callmangaApi();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: isLoading == true ? Center(
        child: CircularProgressIndicator(),
      ) : Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 2,right: 2.0,bottom: 5,top: 3),
            child: Container(
              height: 45,
              // color: Colors.white,
              child:Card(
                shape: RoundedRectangleBorder(
                  side: new BorderSide(color: Colors.white, width: 1.0),
                  borderRadius: BorderRadius.circular(30),),
                shadowColor: Colors.white,
                elevation: 10,
                child: TextField(
                  controller: tc,
                  decoration: InputDecoration(
                      hintText: 'Search',
                      contentPadding: EdgeInsets.symmetric(
                          horizontal: 15.0,vertical: 02),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(30)),
                          borderSide: BorderSide(color:Colors.white,width: 1)
                      ),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(30)),
                          borderSide: BorderSide(color:Colors.white,width: 1)
                      )
                  ),
                  onChanged: (v) {
                    setState(() {
                      query = v;
                      setResults(query);
                    });
                  },
                ),
              ),
            ),
          ),
          CarouselSlider(
            options: CarouselOptions(
                height: 200,
              autoPlay: true,
              enlargeCenterPage: true,
              autoPlayAnimationDuration: Duration(seconds: 1),
              viewportFraction: 1.0,
            ),
            items: bannerList.map((i) {
              print(i);
              return Builder(
                builder: (BuildContext context) {
                  return Container(
                      width: MediaQuery.of(context).size.width,
                      margin: EdgeInsets.symmetric(horizontal: 5.0),
                      decoration: BoxDecoration(
                          color: Colors.amber
                      ),
                      child:Container(
                        height: 200,
                        width: 150,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          image: DecorationImage(
                            image: NetworkImage(i),
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                  );
                },
              );
            }).toList(),
          ),
          Expanded(
            child: Container(
              child: query.isEmpty
                  ? ListView(
                shrinkWrap: true,
                children: [
                  SeriesPageActivity(dataList,"Anime series","anime"),
                  SeriesPageActivity(dataList,"Manga series","manga"),
                ],
              ):ListView(
                children: [
                  SeriesPageActivity(searchList,"Serach Item","search"),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void setResults(String query) {

    searchList = dataList.where((elem) =>
    elem.canonicalTitle
        .toString()
        .toLowerCase()
        .contains(query.toLowerCase()) ||
        elem.id
            .toString()
            .toLowerCase()
            .contains(query.toLowerCase()))
        .toList();
  }
  Future<List<AllAnimeModel>> callAnimeApi( ) async {
    setState(() {
      isLoading=true;
    });
    String emailUrl = "https://kitsu.io/api/edge/anime/";
    var emailPopupResponse =
    await http.get(Uri.parse(emailUrl), headers: <String, String>{
      'Content-Type': 'application/vnd.api+json',
    });
    if (emailPopupResponse.statusCode == 200) {
      var Data = json.decode(emailPopupResponse.body);
      var resdata = Data['data'] as List;

      setState(() {
        for (var o in resdata) {
          AllAnimeModel model = AllAnimeModel(o["id"],o["attributes"]["posterImage"]["tiny"], o["attributes"]["canonicalTitle"],o["type"]);
          dataList.add(model);
          results.add(model);
          bannerList.add(o["attributes"]["posterImage"]["tiny"].toString());
          isLoading=false;
        }
      });
    }
    return dataList;
  }

  Future<List<AllAnimeModel>> callmangaApi( ) async {
    setState(() {
      isLoading=true;
    });
    dataList = <AllAnimeModel>[];
    String emailUrl =
        "https://kitsu.io/api/edge/manga/";
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
          AllAnimeModel model = AllAnimeModel(o["id"],o["attributes"]["posterImage"]["tiny"], o["attributes"]["canonicalTitle"],o["type"]);
          dataList.add(model);
          isLoading = false;
        }
      });
    }
    return dataList;
  }

  static Widget placeHolder() {
    return Image.asset(
      'assets/img/png/image_placeholder.png',
      height: 50,
      width: 50,
    );
  }
}


