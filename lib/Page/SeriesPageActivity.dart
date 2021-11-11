
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:luuk/Model/AllAnimeModel.dart';
import 'package:http/http.dart' as http;
import 'package:luuk/Page/ViewUi.dart';

class SeriesPageActivity extends StatefulWidget{
  List<AllAnimeModel> dataList;
  String maintTitle;
  String type;
  SeriesPageActivity(this.dataList,this.maintTitle,this.type);

  @override
  _mangaPageActivityState createState() => _mangaPageActivityState();
}

class _mangaPageActivityState extends State<SeriesPageActivity> {
  @override
  Widget build(BuildContext context) {
    return Padding(padding: const EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(widget.maintTitle,textAlign: TextAlign.left, style: TextStyle(
                color:Colors.white,
                fontSize:20.0
            ),),
          ),

          ViewUi.getListView(widget.dataList, context,widget.type)
        ],
      ),
    );
  }
}