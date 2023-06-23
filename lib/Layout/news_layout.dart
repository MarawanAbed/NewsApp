import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/Modules/search/search.dart';
import 'package:news_app/Shared/cubit/news_cubit.dart';

class NewsLayout extends StatelessWidget {
  const NewsLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit, NewsState>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = NewsCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title: const Text('News App'),
            actions: [
              IconButton(
                  onPressed: ()
                  {
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>SearchScreen()));
                  },
                  icon: const Icon(Icons.search)
              ),
              IconButton(
                  onPressed: ()
                  {
                    NewsCubit.get(context).changeAppMode();
                  },
                  icon: const Icon(Icons.brightness_4_outlined)
              ),
            ],
          ),
          body: cubit.screens[cubit.currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: cubit.currentIndex,
            items: cubit.bottomItems,
            onTap: (index) {
            cubit.changeBottomNav(index);
            },
          ),
        );
      },
    );
  }
}
