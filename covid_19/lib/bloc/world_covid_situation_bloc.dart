import 'package:bloc/bloc.dart';
import 'package:covid_19/Apis/WorldCovidSituationApiProvider.dart';
import 'package:covid_19/Model/WorldCovidSituationModel.dart';
import 'package:meta/meta.dart';

part 'world_covid_situation_event.dart';
part 'world_covid_situation_state.dart';

class WorldCovidSituationBloc extends Bloc<WorldCovidSituationEvent, WorldCovidSituationState> {
  WorldCovidSituationBloc() : super(WorldCovidSituationInitial()) {
    on<FetchWorldCovidSituationEvent>((event, emit) async{
      WorldCovidSituationApiProvider worldCovidSituationApiProvider=WorldCovidSituationApiProvider();
      emit(WorldCovidSituationLoadingState());
      try {
       WorldCovidSituationModel worldCovidSituationModel =await worldCovidSituationApiProvider.fetchWorldCases();
        emit(FetchWorldCovidSituationState(worldCovidSituationModel:worldCovidSituationModel ));
      } catch (e) {
        emit(WorldCovidSituationErrorState(errorMessage: e.toString()));
      }
    });
  }
}
