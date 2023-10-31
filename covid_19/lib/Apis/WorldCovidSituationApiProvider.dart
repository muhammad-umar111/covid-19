import 'package:covid_19/Apis/ApiProvider.dart';
import 'package:covid_19/Model/WorldCovidSituationModel.dart';

class  WorldCovidSituationApiProvider extends ApiProvider{
  @override
  // TODO: implement baseUrl
  String get baseUrl => 'https://disease.sh/v3/covid-19/all';
  Future<WorldCovidSituationModel> fetchWorldCases()async{
    var countriesSituation=await fetch();
    return WorldCovidSituationModel.fromJson(countriesSituation);
  }
  
}