import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:luuk/Model/AllAnimeModel.dart';

import '../Utility.dart';
import 'DetailsActivity.dart';

class ViewUi{

  static getListView(List<AllAnimeModel> dataList,BuildContext context,String keytype){
    return Container(
      color: Colors.black,
      height: 250,
      child: new ListView.builder(
          itemCount: dataList.length,
          scrollDirection: Axis.horizontal,
          itemBuilder: (BuildContext ctxt, int index) {
            AllAnimeModel setmodel = dataList[index];
            if(keytype== "search"){
              return  InkWell(
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Container(
                    width: 150,
                    child: Column(
                      children: [
                        Container(
                          height: 200,
                          width: 150,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                              topRight: Radius.circular(10),
                              bottomRight: Radius.circular(0),
                              bottomLeft: Radius.circular(0),
                              topLeft: Radius.circular(10),
                            ),
                            image: DecorationImage(
                              image: NetworkImage(dataList[index].poster),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        SizedBox(height: 10,),
                        Expanded(child: Text(setmodel.canonicalTitle,textAlign: TextAlign.center,style: TextStyle(
                            fontSize: 10,
                          fontWeight: FontWeight.bold
                        ),)),
                        SizedBox(height: 5,),
                      ],
                    ),

                  ),
                ),
                onTap: (){
                  callToastMethod(setmodel.id);
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => DetailsActivity(setmodel.id,setmodel.type)),
                  );
                },
              );
            }else{
              if(setmodel.type == keytype){
                return  InkWell(
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Container(
                      width: 150,
                      child: Column(
                        children: [
                          Container(
                            height: 200,
                            width: 150,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                topRight: Radius.circular(10),
                                bottomRight: Radius.circular(0),
                                bottomLeft: Radius.circular(0),
                                topLeft: Radius.circular(10),
                              ),
                              image: DecorationImage(
                                image: NetworkImage(dataList[index].poster),
                                fit: BoxFit.cover,
                              ),
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
                  ),
                  onTap: (){
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => DetailsActivity(setmodel.id,setmodel.type)),
                    );
                  },
                );
              }
            }
            return new Container();
          }),
    );
  }

  static setMainTitle(String msg){
    if(msg == "null"){
      msg = "NA";
    }
    return Padding(
      padding: const EdgeInsets.only(left: 10,top: 5),
      child: Text(msg,style:TextStyle(
          color: Colors.white,
          fontSize: 15,
      ),),
    );
  }
  static setTitle(String msg,BuildContext context){
    if(msg == "null"){
      msg = "NA";
    }
    return Padding(
      padding: const EdgeInsets.only(left: 10,top: 5),
      child: Text(msg,
        style: GoogleFonts.lato(
            textStyle: Theme.of(context).textTheme.headline6,
            fontSize: 15,
            fontWeight: FontWeight.w900,
            fontStyle: FontStyle.italic,
            color: Colors.white
        ),
      ),
    );
  }
  static setDetailText(String msg,BuildContext context){
    if(msg == "null"){
      msg = "NA";
    }
    return Padding(
      padding: const EdgeInsets.only(left: 10,top: 5),
      child: Text(msg,textAlign:TextAlign.left,style: TextStyle(
        fontSize: 12,
      ),),
    );
  }

  static setNormalTitle(String msg){
    if(msg == "null"){
      msg = "NA";
    }
    return Padding(
      padding: const EdgeInsets.only(left: 10,top: 5),
      child: Text(msg,style:TextStyle(
        color: Colors.black,
        fontSize: 15,
      ),),
    );
  }


}