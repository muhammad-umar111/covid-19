import 'package:covid_19/View/WorldStatesScreen.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CountriesDetail extends StatefulWidget {
  String image,name;
  int? totalCases,totalDeaths,totalRecovered,active,critical,todayDeaths;

  CountriesDetail({super.key
  ,required this.image,
  required this.name,
  required this.totalCases,
  required this.totalRecovered,
  required this.totalDeaths,
  required this.active,
  required this.critical,
  required this.todayDeaths
  });

  @override
  State<CountriesDetail> createState() => _CountriesDetailState();
}

class _CountriesDetailState extends State<CountriesDetail> {
  @override
  Widget build(BuildContext context) {
    final height=MediaQuery.sizeOf(context).height;

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 36, 35, 35),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 53, 52, 52),
        title: Text(widget.name,style: const TextStyle(color: Colors.white),),
      centerTitle: true,),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
       Stack(
        alignment: Alignment.topCenter,
        children: [
           
         Padding(
          padding:EdgeInsets.only(top: height*0.074),
          child:Card(
            color: const Color.fromARGB(255, 51, 51, 51),
            child: Padding(
              padding: const EdgeInsets.only(top: 32,left: 8,right: 8),
              child: Column(
                children: [
                  ReusableRow(title: 'Cases', value: widget.totalCases.toString()),
                  ReusableRow(title: 'TotalRecovered', value: widget.totalRecovered.toString()),
                  ReusableRow(title: 'TotalDeaths', value: widget.totalDeaths.toString()),
                  ReusableRow(title: 'Active', value: widget.active.toString()),
            
                  ReusableRow(title: 'Critical', value: widget.critical.toString()),
                  ReusableRow(title: 'TodayDeaths', value: widget.todayDeaths.toString()),

                
                ],
              ),
            ),
          ) , ),

         CircleAvatar(
            radius: 50,
            backgroundImage: NetworkImage(widget.image),
          ),
        ],
       )
        ],
      ),
    );
  }
}
