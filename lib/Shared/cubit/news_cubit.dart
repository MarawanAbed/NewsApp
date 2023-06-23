
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:news_app/Modules/Business/business.dart';
import 'package:news_app/Modules/Science/science.dart';
import 'package:news_app/Modules/Sport/sport.dart';
import 'package:news_app/Shared/Network/local/shared_preference.dart';
import 'package:news_app/Shared/Network/remotely/dio_helper.dart';

part 'news_state.dart';

class NewsCubit extends Cubit<NewsState> {
  NewsCubit() : super(NewsInitial());

  var searchController = TextEditingController();
  static NewsCubit get(context)=>BlocProvider.of(context);
  int currentIndex=0;
  List<BottomNavigationBarItem>bottomItems=[
    const BottomNavigationBarItem(
      icon: Icon(Icons.business),
      label: 'Business'
    ),
    const BottomNavigationBarItem(
      icon: Icon(Icons.sports),
      label: 'Sports'
    ),
    const BottomNavigationBarItem(
      icon: Icon(Icons.science),
      label: 'Science'
    ),
  ];
  List<Widget>screens=[
    const BusinessScreen(),
    const SportScreen(),
    const ScienceScreen(),
  ];
  changeBottomNav(int index)
  {
    currentIndex=index;
    emit(ChangeBottomNavigationBar());
  }

  List<dynamic>? business;

  getBuinsess()
  {
    emit(NewsGetBusinessLoading());
    DioHelper.getData(
        url: 'v2/top-headlines',
        query:
        {
          'country':'eg',
          'category':'business',
          'apiKey':'1ee68e89880d49c5b49615c6273d0cfb',
        }
    ).then((value)
    {
      business=value.data['articles'];
      emit(NewsGetBusinessSuccess());
    }
    ).catchError((er)
    {
      debugPrint(er.toString());
      emit(NewsGetBusinessError(er.toString()));
    }
    );
  }
  List<dynamic>? sport;
  getSport()
  {
    emit(NewsGetSportLoading());
    DioHelper.getData(
        url: 'v2/top-headlines',
        query:
        {
          'country':'eg',
          'category':'sports',
          'apiKey':'1ee68e89880d49c5b49615c6273d0cfb',
        }
    ).then((value)
    {
      sport=value.data['articles'];
      emit(NewsGetSportSuccess());
    }
    ).catchError((er)
    {
      debugPrint(er.toString());
      emit(NewsGetSportError(er.toString()));
    }
    );
  }

  List<dynamic>? scinece;
  getScience()
  {
    emit(NewsGetScienceLoading());
    DioHelper.getData(
        url: 'v2/top-headlines',
        query:
        {
          'country':'eg',
          'category':'Science',
          'apiKey':'1ee68e89880d49c5b49615c6273d0cfb',
        }
    ).then((value)
    {
      scinece=value.data['articles'];
      emit(NewsGetScienceSuccess());
    }
    ).catchError((er)
    {
      debugPrint(er.toString());
      emit(NewsGetScienceError(er.toString()));
    }
    );
  }
  List<dynamic>? search;
  searchItem({required String key})
  {
    emit(NewsSearchLoading());
    DioHelper.getData(
        url: 'v2/everything',
        query:
        {
          'q':key,
          'apiKey':'1ee68e89880d49c5b49615c6273d0cfb',
        }
    ).then((value)
    {
      search=value.data['articles'];
      emit(NewsSearchSuccess());
    }
    ).catchError((er)
    {
      debugPrint(er.toString());
      emit(NewsSearchError(er.toString()));
    }
    );
  }
  ThemeMode appMode=ThemeMode.dark;
  bool isDark=false;
  changeAppMode({bool ? fromShared})
  {
    if(fromShared !=null)
    {
      isDark=fromShared;
      emit(NewsChangeAppTheme());
    }else {
      isDark=!isDark;
      CacheHelper.putData(key: 'isDark', value: isDark).then((value)
      {
        emit(NewsChangeAppTheme());
      }
      );
    }
    //when i press it will take data and i give it value after i edit it isdark after =!
    //now i need to get from shared
  }
}
