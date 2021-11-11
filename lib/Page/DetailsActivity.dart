import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:luuk/Model/DetailModel.dart';
import 'package:http/http.dart' as http;
import 'package:luuk/Page/ViewUi.dart';
import 'package:luuk/Utility.dart';
import 'package:share/share.dart';

import 'package:url_launcher/url_launcher.dart';
class DetailsActivity extends StatefulWidget{
  String id,type;
  DetailsActivity(this.id,this.type);

  @override
  _detailsState createState() => _detailsState();
}

class _detailsState extends State<DetailsActivity> {
  var isloading = false;
  var genersself = "null";
  var generssrelated = "null";
  late List<DetailModel> dataList;
  Color changecolor = Colors.grey;
  var isfavioret = false;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: isloading==true
          ? Center(
        child: CircularProgressIndicator(),
      ):SafeArea(
        child: Column(
          children: [
            ImageWithDetail(),
            SubDetails(),
            Expanded(
              child: Container(
                color: Colors.white,
                child: ListView(
                  children: [
                    ChildDetails(),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  ImageWithDetail(){
    return  Padding(
      padding: const EdgeInsets.only(left: 0,right: 0),
      child: Container(
        color: Colors.black,
        child: Row(
          children: [
            Expanded(
              flex: 2,
              child:
              Container(
                height: 200,
                width: 150,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  image: DecorationImage(
                    image: NetworkImage(dataList[0].poster),
                    fit: BoxFit.fill,
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 4,
              child: Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ViewUi.setMainTitle("Main Title"),
                      ViewUi.setTitle(widget.type.toUpperCase(), context),
                      ViewUi.setMainTitle("Canconical title"),
                      ViewUi.setTitle(dataList[0].canonicalTitle, context),
                      ViewUi.setMainTitle("Type"),
                      ViewUi.setTitle("${dataList[0].showType == "null" ? "NA":dataList[0].showType} , ${dataList[0].episodeCount == "nul" ? "NA":dataList[0].episodeCount} Episode", context),
                      ViewUi.setMainTitle("Year"),
                      ViewUi.setTitle("${dataList[0].startDate == "null" ? "NA":dataList[0].startDate}  till  ${dataList[0].endDate == "null" ? "NA": dataList[0].endDate}", context),
                    ],
                  )
              ),
            )
          ],
        ),
      ),
    );
  }

  SubDetails() {
    return  Padding(
      padding: const EdgeInsets.only(left: 3,right: 3,top: 10),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
      borderRadius: BorderRadius.only(
      topRight: Radius.circular(40),
      bottomRight: Radius.circular(0),
      bottomLeft: Radius.circular(0),
      topLeft: Radius.circular(40),
      )),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Align(
                alignment: Alignment.topRight,
                child: Padding(
                  padding: const EdgeInsets.only(right: 15.0,top: 10),
                  child: InkWell(
                    onTap: (){
                      setState(() {
                        if(isfavioret){

                          callToastMethod("Remove from favorite");
                          changecolor=Colors.black;
                          isfavioret = false;
                        }else{
                          changecolor=Colors.red;
                          isfavioret = true;
                          callToastMethod("Added into favorite");
                        }
                      });
                    },
                      child: Icon(Icons.favorite,color: changecolor,size: 30,)),
                )),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Text("Generes"),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10.0),
              child: Column(
                children: [
                  Text(genersself == "null" ? "NA" :genersself),
                  Text(generssrelated == "null" ? "NA" :generssrelated),
                ],
              ),
            ),
            SizedBox(height: 10,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text("Average rating"),
                    setRating(dataList[0].averageRating.toString(),"avg"),


                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text("Age Rating"),
                    setRating(dataList[0].averageRating.toString(),"age"),
                  ],
                ),
              ],
            ),
            SizedBox(height: 10,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ViewUi.setNormalTitle("Episode Duration"),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text("Airing status"),
                ),

              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [

                Padding(
                  padding: const EdgeInsets.only(left:50.0),
                  child: Text(dataList[0].episodeCount.toString()),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 25),
                  child: Card(
                      color: Colors.red,
                      child: Padding(
                        padding: const EdgeInsets.all(3.0),
                        child: Text(dataList[0].status.toString(),
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold

                        ),
                        ),
                      )),
                ),


              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
               InkWell(
                        onTap: () async {
                          await launch('https://www.youtube.com/watch?v=${dataList[0].youtubeVideoId}');
                        },
                        child: Image.asset('assets/img/youtube.png',height: 30,)),

                InkWell(
                        onTap: () async {
                          await Share.share("Series name: ${widget.type} \n ${"https://www.youtube.com/watch?v=${dataList[0].youtubeVideoId}"}");

                        },
                        child:Row(
                          children: [
                            Text("share ",style: TextStyle(
                              fontWeight: FontWeight.bold
                            ),),
                            Icon(Icons.share,),
                          ],
                        ),
                ),
              ],
            ),


            SizedBox(height: 5,),
          ],
        ),
      ),
    );
  }

  ChildDetails(){
    return  Padding(
        padding: const EdgeInsets.only(left: 5,right: 5),
          child: Container(
            color: Colors.white,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Text("Syponsis",textAlign:TextAlign.left,style: TextStyle(
                    fontSize: 18,
                  ),),
                ),
                ViewUi.setDetailText(dataList[0].synopsis.toString(), context),
                SizedBox(height: 10,),
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Text("Description",textAlign:TextAlign.left,style: TextStyle(
                    fontSize: 18,
                  ),),
                ),
                ViewUi.setDetailText(dataList[0].description.toString(), context),
                SizedBox(height: 500,),


              ],
            ),
          ),
    );
  }

  @override
  void initState() {
    callDetailApi();
  }

  callDetailApi( ) async {
    setState(() {
      isloading = true;
    });
    dataList = <DetailModel>[];
    String emailUrl = "https://kitsu.io/api/edge/${widget.type}/${widget.id}";
    var emailPopupResponse =
        await http.get(Uri.parse(emailUrl), headers: <String, String>{
      'Content-Type': 'application/vnd.api+json',
    });
    if (emailPopupResponse.statusCode == 200) {
      var Data = json.decode(emailPopupResponse.body);
      var resdata = Data['data'];
      setState(() {

        // genersself = resdata["attributes"]["relationships"]["genres"]["links"]["self"];
        // generssrelated = resdata["attributes"]["relationships"]["genres"]["links"]["related"];
        DetailModel model = new DetailModel(resdata['id'], resdata["attributes"]["posterImage"]["tiny"].toString(), resdata['attributes']['canonicalTitle'].toString(),
            resdata['attributes']['averageRating'].toString(), resdata['attributes']['synopsis'], resdata['attributes']['description'].toString(),
            resdata['attributes']['ageRating'].toString(), resdata['attributes']['showType'].toString(), resdata['attributes']['episodeCount'] ?? 0, resdata['attributes']['youtubeVideoId'].toString(), resdata['attributes']['startDate'].toString(), resdata['attributes']['endDate'].toString(),"${resdata['attributes']['status'].toString()}");
        dataList.add(model);
        isloading = false;
      });
    }
  }

  setRating(String vale,String key) {
    var colour;
    if(key == "age"){
      colour = Colors.red;
    }else{
      colour = Colors.amber;
    }
    if(vale == "null"){
      vale = "0";

    }
    double rate = double.parse(vale);
    rate = rate/20;
    return RatingBarIndicator(
      rating: rate,
      itemBuilder: (context, index) => Icon(
        Icons.star,
        color: colour,
      ),
      itemCount: 5,
      itemSize: 18.0,
      direction: Axis.horizontal,
    );
  }

  void setFlag(bool flage) {
    if(flage){

    }
  }
}


