part of 'world_list_bloc.dart';

@immutable
sealed class WorldListState {}

final class WorldListInitial extends WorldListState {}
class WorldListLoadingState extends WorldListState {
  
}
class FetchWorldListState extends WorldListState {
 final List<CountriesListModel> countriesListModel;
FetchWorldListState({required this.countriesListModel});
 }
 class WorldListErrorState extends WorldListState {
   final String errorMessage;
   WorldListErrorState({required this.errorMessage});
 }