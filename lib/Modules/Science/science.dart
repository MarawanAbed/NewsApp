import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/Shared/Components/components.dart';
import 'package:news_app/Shared/cubit/news_cubit.dart';

class ScienceScreen extends StatelessWidget {
  const ScienceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit,NewsState>(
      listener: (context, state) {
      },
      builder: (context, state) {
        var cubit=NewsCubit.get(context);
        return ConditionalBuilder(
          condition: state is! NewsGetScienceLoading,
          builder: (BuildContext context) {
            return ListView.separated(
              itemBuilder: (context, index) {
                return buildNewsItem(cubit.scinece![index],context);
              },
              itemCount: cubit.scinece?.length ?? 0,
              separatorBuilder: (BuildContext context, int index) {
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
            );
          },
          fallback: (BuildContext context)
          {
            return const Center(child: CircularProgressIndicator(),);
          },
        );
      },
    );
  }
}
