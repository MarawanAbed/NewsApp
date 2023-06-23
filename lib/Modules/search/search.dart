import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/Shared/Components/components.dart';
import 'package:news_app/Shared/cubit/news_cubit.dart';

class SearchScreen extends StatelessWidget {

  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit, NewsState>(
      listener: (context, state) {
      },
      builder: (context, state) {
        var list=NewsCubit.get(context).search;
        return Scaffold(
          appBar: AppBar(),
          body: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: defaultFormField(
                  controller: NewsCubit.get(context).searchController,
                  type: TextInputType.text,
                  onChange: (value) {
                    //for every value i will search
                    NewsCubit.get(context).searchItem(key: value);
                  },
                  validate: (value) {
                    if (value!.isEmpty) {
                      return 'Search must not be empty';
                    }
                    return null;
                  },
                  label: 'Search',
                  prefix: Icons.search,
                ),
              ),
              Expanded(
                child: ConditionalBuilder(
                  condition: state is! NewsSearchLoading,
                  builder: (BuildContext context)
                  {
                    return ListView.separated(
                      itemBuilder: (context,index)
                      {
                        return buildNewsItem(list![index], context);
                      },
                      separatorBuilder: (context,index)
                      {
                        return Padding(
                          padding: const EdgeInsetsDirectional.only(
                            start: 20.0,
                          ),
                          child: Container(
                            width: double.infinity,
                            height: 1.0,
                            color: Colors.grey[300],
                          ),
                        );
                      },
                      itemCount: list?.length ?? 0,
                    );
                  },
                  fallback: (BuildContext context)
                  {
                    return const Center(child: CircularProgressIndicator(),);
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
