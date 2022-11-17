import 'package:explore/features/home/presentation/viewmodels/home_viewmodel.dart';
import 'package:explore/features/movie_details/presentation/screens/movie_details.dart';

import 'package:explore/shared/utils/export.dart';
import 'package:explore/shared/widgets/export.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MovieTabView extends StatelessWidget {
  const MovieTabView({super.key});

  @override
  Widget build(BuildContext context) {
    final homeViewmodel = context.watch<HomeViewModel>();
    final data = homeViewmodel.listOfMovies.data;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: hPadding),
      child: homeViewmodel.listOfMovies.isLoading
          ? SizedBox(
              width: 40,
              height: 40,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(
                    color: appColors.secondaryColor,
                    strokeWidth: 2,
                  ),
                ],
              ),
            )
          : ListView.builder(
              itemCount: data?.itemCount ?? 0,
              physics: const BouncingScrollPhysics(),
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 25.0),
                  child: GestureDetector(
                    onTap: () {
                      homeViewmodel.fetchMovieDetails(
                          data?.items?[index].id.toString() ?? '');
                      push(
                        context,
                        screen: MoviesDetails(
                          data: data!.items![index],
                        ),
                      );
                    },
                    child: AppNetworkImage(
                      imageUrl: data?.items?[index].fullImagePath ?? '',
                    ),
                  ),
                );
              },
            ),
    );
  }
}
