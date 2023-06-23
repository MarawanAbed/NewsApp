import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:news_app/Layout/news_layout.dart';
import 'package:news_app/Shared/Network/local/shared_preference.dart';
import 'package:news_app/Shared/Network/remotely/dio_helper.dart';
import 'package:news_app/Shared/bloc_observer.dart';
import 'package:news_app/Shared/cubit/news_cubit.dart';

void main() async {
  Bloc.observer = MyBlocObserver();
  WidgetsFlutterBinding.ensureInitialized();
  await DioHelper.init();
  await CacheHelper.init();

  bool? isDark = CacheHelper.getData(key: 'isDark') ?? false;

  runApp(NewsApp(isDark:isDark));
}

class NewsApp extends StatelessWidget {
  const NewsApp({super.key, required this.isDark});
  final bool? isDark;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => NewsCubit()
        ..changeAppMode(
          fromShared: isDark
        )
        ..getBuinsess()
        ..getSport()
        ..getScience(),
      child: BlocConsumer<NewsCubit, NewsState>(
        listener: (context, state) {
        },
        builder: (context, state) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              primarySwatch: Colors.deepOrange,
              primaryColor: Colors.deepOrange,
              scaffoldBackgroundColor: Colors.white,
              appBarTheme: const AppBarTheme(
                titleSpacing: 20.0,
                systemOverlayStyle: SystemUiOverlayStyle(
                    //to allow me to customize my system app
                    statusBarColor: Colors.white,
                    statusBarBrightness: Brightness.dark),
                backgroundColor: Colors.white,
                elevation: 0.0,
                titleTextStyle: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
                iconTheme: IconThemeData(color: Colors.black),
              ),
              bottomNavigationBarTheme: const BottomNavigationBarThemeData(
                backgroundColor: Colors.white,
                unselectedItemColor: Colors.grey,
                type: BottomNavigationBarType.fixed,
                selectedItemColor: Colors.deepOrange,
              ),
              textTheme: const TextTheme(
                bodyLarge: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 18.0,
                    color: Colors.black),
              ),
            ),
            darkTheme: ThemeData(
              primarySwatch: Colors.deepOrange,
              primaryColor: Colors.deepOrange,
              scaffoldBackgroundColor: HexColor('333739'),
              appBarTheme: AppBarTheme(
                titleSpacing: 20.0,
                systemOverlayStyle: SystemUiOverlayStyle(
                    //to allow me to customize my system app
                    statusBarColor: HexColor('333739'),
                    statusBarBrightness: Brightness.light),
                backgroundColor: HexColor('333739'),
                elevation: 0.0,
                titleTextStyle: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
                iconTheme: const IconThemeData(color: Colors.white),
              ),
              bottomNavigationBarTheme: BottomNavigationBarThemeData(
                backgroundColor: HexColor('333739'),
                unselectedItemColor: Colors.grey,
                type: BottomNavigationBarType.fixed,
                selectedItemColor: Colors.deepOrange,
              ),
              textTheme: const TextTheme(
                bodyLarge: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 18.0,
                    color: Colors.white),
              ),
            ),
            themeMode: NewsCubit.get(context).isDark
                ? ThemeMode.dark
                : ThemeMode.light,
            title: 'News App',
            home: const NewsLayout(),
          );
        },
      ),
    );
  }
}


//when i get from pref when i go to app i get data and send it to news app and
//بناء علي الnews app هيبدا يحط قيمة
//after i get isDark maybe it be null when i open application for first time
//it didnt store nothing so that i check in theme mode
//i will send it in cubit to check