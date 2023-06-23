part of 'news_cubit.dart';

@immutable
abstract class NewsState {}

class NewsInitial extends NewsState {}

class ChangeBottomNavigationBar extends NewsState{}

class NewsGetBusinessLoading extends NewsState{}
class NewsGetBusinessSuccess extends NewsState{}
class NewsGetBusinessError extends NewsState{
  final String error;

  NewsGetBusinessError(this.error);
}

class NewsGetSportLoading extends NewsState{}
class NewsGetSportSuccess extends NewsState{}
class NewsGetSportError extends NewsState{
  final String error;

  NewsGetSportError(this.error);

}


class NewsGetScienceLoading extends NewsState{}
class NewsGetScienceSuccess extends NewsState{}
class NewsGetScienceError extends NewsState{
  final String error;

  NewsGetScienceError(this.error);


}

class NewsSearchLoading extends NewsState{}
class NewsSearchSuccess extends NewsState{}
class NewsSearchError extends NewsState{
  final String error;

  NewsSearchError(this.error);

}

class NewsChangeAppTheme extends NewsState{}