import 'package:bloc/bloc.dart';
import 'package:covid_19/Apis/WorldCovidListApiProvider.dart';
import 'package:covid_19/Model/CountriesListModel.dart';
import 'package:meta/meta.dart';

part 'world_list_event.dart';
part 'world_list_state.dart';

class WorldListBloc extends Bloc<WorldListEvent, WorldListState> {
  WorldListBloc() : super(WorldListInitial()) {
   on<FetchWorldListEvent>((event, emit) async{
      WorldCovidListApiProvider worldListApiProvider=WorldCovidListApiProvider();
      emit(WorldListLoadingState());
      try {
      List<CountriesListModel> countriesListModel =await worldListApiProvider.fetchCountriesList();
        emit(FetchWorldListState(countriesListModel: countriesListModel));
      } catch (e) {
        emit(WorldListErrorState(errorMessage: e.toString()));
      }
    });
  }
}
