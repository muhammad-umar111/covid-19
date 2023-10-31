import 'package:covid_19/Model/CountriesListModel.dart';
import 'package:covid_19/View/CountriesDetailScreen.dart';
import 'package:covid_19/bloc/world_list_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';

class CountriesListScreen extends StatefulWidget {
  const CountriesListScreen({super.key});

  @override
  State<CountriesListScreen> createState() => _CountriesListScreenState();
}

class _CountriesListScreenState extends State<CountriesListScreen> {
  @override
  void initState() {
    super.initState();
  context.read<WorldListBloc>().add(FetchWorldListEvent());
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 49, 48, 48),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 49, 48, 48),

        elevation: 0,
        leading: const Icon(Icons.arrow_back,color: Colors.white,),
      ),
      
      
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                decoration: InputDecoration(
                  hintText: 'Search with country names',
                  helperStyle: const TextStyle(color: Color.fromARGB(255, 249, 244, 244)),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(50)
                  )
                ),
              ),
            ),
            Expanded(child: BlocBuilder<WorldListBloc,WorldListState>(builder: (context, state) {
              if (state is WorldListInitial||state is WorldListLoadingState) {
                return const ShimmerEffect();
              } else if(state is FetchWorldListState ){
                return CountriesList(countriesListModel1: state.countriesListModel);
              }
              else{
                return ErrorState(errorMessage: (state as WorldListErrorState).errorMessage);
              }
            },))
          ],
        ),
      ),
    );
  }
}
class CountriesList extends StatelessWidget {
   const CountriesList({super.key,required this.countriesListModel1});
 final List<CountriesListModel> countriesListModel1;
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: countriesListModel1.length,
      itemBuilder: (context, index) {
        return Column(
          children: [
            InkWell(
              onTap: () {
                Navigator.push(context,MaterialPageRoute(builder: (context) {
                  return  CountriesDetail(image:countriesListModel1[index].countryInfo!.flag.toString(),
                   name: countriesListModel1[index].country.toString(),
                    totalCases: countriesListModel1[index].cases,
                     totalDeaths:countriesListModel1[index].deaths,
                      active: countriesListModel1[index].active, 
                      critical:countriesListModel1[index].critical,
                       totalRecovered:countriesListModel1[index].recovered,
                       todayDeaths: countriesListModel1[index].todayDeaths,);
                },));
              },
              child: ListTile(
                title: Text(countriesListModel1[index].country.toString(),
                style: const TextStyle(color: Colors.white),),
                subtitle: Text(countriesListModel1[index].cases.toString(),
                style: const TextStyle(color: Colors.grey),),
                leading: Image(
                  width: 50,
                  height: 50,
                  image: NetworkImage(countriesListModel1[index].countryInfo!.flag.toString())),
              ),
            )
          ],
        );
      
    },); 
    
              
  }}

class ErrorState extends StatelessWidget {
  // ignore: prefer_typing_uninitialized_variables
  final errorMessage;
  const ErrorState({super.key,required this.errorMessage});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(errorMessage.toString(),style: const TextStyle(color: Colors.red,fontWeight: FontWeight.bold),)
    );
  }
}
class ShimmerEffect extends StatelessWidget {
   const ShimmerEffect({super.key,});
  @override
  Widget build(BuildContext context) {
    final width=MediaQuery.sizeOf(context).width;
    return SafeArea(
      child: ListView.builder(
        itemCount: 8,
        itemBuilder: (context, index) {
          return Shimmer.fromColors(
            baseColor: Colors.grey.shade500,
            highlightColor: Colors.grey.shade100,
            child: Column(
              children: [
                ListTile(
                  title: Container(width: width*0.6,height: 5,color: Colors.white,),
                  subtitle:Container(width: width*0.6,height: 5,color: Colors.white,) ,
                  leading: Container(height: 50,width: 50,color: Colors.white,),
                )
              ],
            ),
          );
    
      },),
    );              
  }}
