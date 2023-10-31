part of 'world_covid_situation_bloc.dart';

@immutable
sealed class WorldCovidSituationState {}

final class WorldCovidSituationInitial extends WorldCovidSituationState {}
class WorldCovidSituationLoadingState extends WorldCovidSituationState {
  
}
class FetchWorldCovidSituationState extends WorldCovidSituationState {
 final WorldCovidSituationModel worldCovidSituationModel;
FetchWorldCovidSituationState({required this.worldCovidSituationModel});
 }
 class WorldCovidSituationErrorState extends WorldCovidSituationState {
   final String errorMessage;
   WorldCovidSituationErrorState({required this.errorMessage});
 }
