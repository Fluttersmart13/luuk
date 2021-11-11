
import 'package:flutter/material.dart';

class mangaPageActivity extends StatefulWidget{
  @override
  _mangaPageActivityState createState() => _mangaPageActivityState();
}

class _mangaPageActivityState extends State<mangaPageActivity> {
  List<String> litems = ["1","2","Third","4"];
  @override
  Widget build(BuildContext context) {
    return Padding(padding: const EdgeInsets.all(10.0),
      child: Column(
        children: [
          SizedBox(height: 10,),
          Text("Name of the"),
          Container(
            color: Colors.black,
            height: 230,
            child: new ListView.builder(
                itemCount: litems.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (BuildContext ctxt, int index) {
                  return  Card(
                    child: Column(
                      children: [
                        SizedBox(height: 10,),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(0.0),
                          child: Image.network("https://media.kitsu.io/anime/poster_images/4604/tiny.jpg",
                            fit: BoxFit.cover,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 5.0),
                        ),
                        Text("", style: TextStyle(
                          color:Color(0xff202124),
                        ),),
                        Text(litems[index]),
                      ],
                    ),
                  );
                }),
          )
        ],
      ),
    );
  }
}