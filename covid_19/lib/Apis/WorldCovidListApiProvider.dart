import 'package:covid_19/Apis/ApiProvider.dart';
import 'package:covid_19/Model/CountriesListModel.dart';

class WorldCovidListApiProvider extends ApiProvider {
  @override
  // TODO: implement baseUrl
  String get baseUrl =>'https://disease.sh/v3/covid-19/countries';
  List<CountriesListModel> countriesList1=[];
  Future<List<CountriesListModel>> fetchCountriesList()async{
      List countriesList=await fetch();
    List<CountriesListModel> myCountriesList= countriesList.map((e) => CountriesListModel.fromJson(e)).toList();
    print(myCountriesList);
    return myCountriesList;
  
    
    
  }
}