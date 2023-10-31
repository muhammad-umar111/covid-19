import 'package:covid_19/Model/WorldCovidSituationModel.dart';
import 'package:covid_19/View/CountriesListScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:provider/provider.dart';

import '../bloc/world_covid_situation_bloc.dart';



class WorldStatesScreen extends StatefulWidget {
  const WorldStatesScreen({super.key});
  static const pageName='/WorldStates';

  @override
  State<WorldStatesScreen> createState() => _WorldStatesScreenState();
}
 final _colorList=<Color>[
   const Color.fromARGB(255, 45, 118, 243),
   const Color.fromARGB(255, 70, 164, 73),
   const Color.fromARGB(255, 247, 59, 45)
  ];
class _WorldStatesScreenState extends State<WorldStatesScreen> with TickerProviderStateMixin{
  late final AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    context.read<WorldCovidSituationBloc>().add(FetchWorldCovidSituationEvent());
     _animationController=AnimationController(
      duration: const Duration(seconds: 4),
      vsync:this);
  }
  @override
  void dispose() {
  _animationController.dispose();
   super.dispose();
  }
 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(115, 162, 156, 156),
      body: SafeArea(
        child:BlocBuilder<WorldCovidSituationBloc,WorldCovidSituationState>(
          builder: (context, state) {
            if (state is WorldCovidSituationLoadingState||state is WorldCovidSituationInitial) {
              return Center(
              child:SpinKitFadingCircle(
                 color: Color.fromARGB(255, 250, 248, 248),
                         size: 50.0,
                        controller: _animationController,
              ) ,
            );
            } else if(state is FetchWorldCovidSituationState){
              return WorldCovidSituation(worldCovidSituationModel: state.worldCovidSituationModel);
               }else{
                  return  ErrorState(errorMessage:(state as WorldCovidSituationErrorState).errorMessage) ;
               }
          
          },
        )
 
 
          ));           
        }
      }
//              THE  .............................................................. END
class ReusableRow extends StatelessWidget {
 final String title,value;
  const ReusableRow({super.key,required this.title,required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left:10,right: 10,top: 8,bottom: 5),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(title,style: const TextStyle(color: Colors.white),),
            Text(value,style: const TextStyle(color: Colors.white),)
          ],
          ),
          const SizedBox(height: 5,),
          const Divider()
        ],
      ),
    );
  }
}
class WorldCovidSituation extends StatelessWidget {
   const WorldCovidSituation({super.key,required this.worldCovidSituationModel});
 final WorldCovidSituationModel worldCovidSituationModel;
  @override
  Widget build(BuildContext context) {
    final width=MediaQuery.sizeOf(context).width;
    return  Column(
              children: [
                Expanded(flex: 3,
                child:PieChart(dataMap: {
                'Total':double.parse(worldCovidSituationModel.cases!.toString()),
                'Recovered':double.parse(worldCovidSituationModel.recovered!.toString()),
                'Death':double.parse(worldCovidSituationModel.deaths!.toString())
              },
              animationDuration: const Duration(milliseconds: 1250),
              chartValuesOptions: const ChartValuesOptions(
                showChartValuesInPercentage: true,
                
              ),
              ringStrokeWidth: 15,
              colorList: _colorList,
              legendOptions: const LegendOptions(
                legendPosition: LegendPosition.left
              ),
              chartType: ChartType.ring,
              chartRadius: width/3.2,)),
              const SizedBox(height: 15,),
              Expanded(flex: 7,child:
              Card(
                color: Color.fromARGB(255, 57, 56, 56),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                    Expanded(flex: 1,
                    child: ReusableRow(title: 'Total', value:worldCovidSituationModel.cases.toString())),
                         Expanded(flex:1,child: ReusableRow(title: 'Death', value:worldCovidSituationModel.deaths.toString())),
                    Expanded(flex: 1,child: ReusableRow(title: 'Recovered', value:worldCovidSituationModel.recovered.toString())),
                    Expanded(flex: 1,child: ReusableRow(title: 'Active', value:worldCovidSituationModel.active.toString())),
                    Expanded(flex: 1,child: ReusableRow(title: 'Critical', value:worldCovidSituationModel.critical.toString())),
                    Expanded(flex: 1,child: ReusableRow(title: 'Today Deaths', value:worldCovidSituationModel.todayDeaths.toString())),
                     
                    ],
                  ),
                ),
              )
               )
               ,
               const SizedBox(height: 5,),
                Expanded(
            flex: 1,
             child: Padding(
               padding: const EdgeInsets.all(10.0),
               child: InkWell(
                onTap: () {
                  Navigator.push(context,MaterialPageRoute(builder: (context) {
                    return const CountriesListScreen();
                  },));
                },
                 child: Container(
                  height: 50,
                  decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 69, 165, 72),
                  borderRadius: BorderRadius.circular(10)
                 ),child: const Center(child: Text('Track Countries',
                 style: TextStyle(color: Colors.white),)),),
               ),
             ),
           ),
              const SizedBox(height: 8,)
              ]);
              }
  }
class ErrorState extends StatelessWidget {
  final errorMessage;
  const ErrorState({super.key,required this.errorMessage});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(errorMessage.toString(),style: TextStyle(color: Colors.red,fontWeight: FontWeight.bold),)
    );
  }
}