import 'package:cached_network_image/cached_network_image.dart';
import 'package:explore/features/home/data/local/models/list_of_movies_model.dart';
import 'package:explore/features/home/presentation/viewmodels/home_viewmodel.dart';
import 'package:explore/features/movie_details/presentation/screens/export.dart';
import 'package:explore/shared/utils/dimension.dart';
import 'package:explore/shared/utils/navigation.dart';
import 'package:explore/shared/utils/themes.dart';
import 'package:explore/shared/widgets/app_text_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FaveTabView extends StatelessWidget {
  const FaveTabView({super.key});

  @override
  Widget build(BuildContext context) {
    final homeViewmodel = context.watch<HomeViewModel>();
    final data = homeViewmodel.listOfFavoriteMovies;


    return Container(
      padding: const EdgeInsets.symmetric(horizontal: hPadding),
      child: ListView.builder(
        itemCount: data.length,
        itemBuilder: (context, index) {
          final dataIndex = data[index];
          return GestureDetector(
            onTap: () {
              final movieData = MovieList().copyWith(
                int.parse(dataIndex.movieId),
                dataIndex.movieName,
                '/${dataIndex.imageUrl.split('/').last}',
                dataIndex.year,
                double.parse(dataIndex.averageRating),
              );
              homeViewmodel.fetchMovieDetails(data[index].movieId);
              push(
                context,
                screen: MoviesDetails(
                  data: movieData,
                ),
              );
            },
            child: Hero(
              tag: dataIndex.imageUrl,
              child: Stack(
                children: [
                  Container(
                    height: 180.dy,
                    margin: const EdgeInsets.only(bottom: 25),
                    width: context.deviceWidth,
                    child: CachedNetworkImage(
                      imageUrl: data[index].imageUrl,
                      errorWidget: (context, url, error) =>
                          const Icon(Icons.error),
                      fit: BoxFit.cover,
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    child: Container(
                      alignment: Alignment.centerLeft,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 40),
                      width: context.deviceWidth,
                      color: appColors.primaryColor.withOpacity(.5),
                      child: AppTextWidget(
                        text:  data[index].movieName,
                        textColor: appColors.white,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
