import 'package:explore/features/home/data/local/local_storage/export.dart';
import 'package:explore/features/home/data/local/models/export.dart';
import 'package:explore/features/home/data/local/models/favorite_model.dart';
import 'package:explore/features/home/presentation/viewmodels/export.dart';
import 'package:explore/service_locator.dart';
import 'package:explore/shared/utils/export.dart';
import 'package:explore/shared/widgets/export.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CustomList extends StatelessWidget {
  CustomList({
    super.key,
    required this.data,
  });

  final MovieList data;

  final localStorage = sl<LocalStorage>();

  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        childCount: 1,
        (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: hPadding),
            child: Column(
              children: [
                YBox(30.dy),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: 190.dx,
                      child: AppTextWidget(
                        text: data.originalTitle ?? '',
                        textColor: appColors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Row(
                      children: [
                        const Icon(
                          Icons.star,
                          color: Colors.yellow,
                        ),
                        XBox(10.dx),
                        AppTextWidget(
                          text: data.voteAverage.toString(),
                          textColor: appColors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                        ),
                      ],
                    ),
                  ],
                ),
                YBox(10.dy),
                Consumer<HomeViewModel>(builder: (_, provider, __) {
                  return Column(
                    children: [
                      AppTextWidget(
                        text: provider.movieDetails.data?.overview ?? '',
                        textColor: appColors.white.withOpacity(.4),
                      ),
                      YBox(10.dy),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              AppTextWidget(
                                text: data.releaseDate?.split('-').first ??
                                    DateTime.now().toString(),
                                textColor: appColors.lightGrey,
                              ),
                              const XBox(8),
                              AppTextWidget(
                                text: provider.movieDetails.data
                                        ?.productionCountries?[0].name ??
                                    'U.S.A',
                                textColor: appColors.lightGrey,
                              ),
                            ],
                          ),
                          AppTextWidget(
                            text: provider.movieDetails.data
                                    ?.productionCompanies?[0].name ??
                                'IMDb',
                            textColor: appColors.lightGrey,
                          ),
                        ],
                      ),
                      YBox(20.dy),
                      Align(
                        alignment: Alignment.center,
                        child: ElevatedButton(
                          onPressed: provider.movieExists
                              ? () {
                                  provider.deleteFromFavoriteList(
                                      data.id.toString());
                                  localStorage
                                      .deleteMovie(data.id.toString())
                                      .whenComplete(() {
                                    showSuccessMessage(
                                      context,
                                      message: 'Movie deleted successfully',
                                    );
                                  });
                                }
                              : () {
                                  final model = FavoriteModel(
                                    averageRating: data.voteAverage.toString(),
                                    imageUrl: data.fullImagePath,
                                    movieId: data.id.toString(),
                                    year: data.releaseDate?.split('-').first ??
                                        DateTime.now().toString(),
                                    movieName: data.originalTitle ?? '',
                                  );
                                  provider.addToFavoriteList(model);
                                  localStorage.insertMovie(model).whenComplete(
                                    () {
                                      showSuccessMessage(
                                        context,
                                        message: 'Movie added successfully',
                                      );
                                    },
                                  );
                                },
                          child: Text(
                            provider.movieExists
                                ? 'Remove from favorite'
                                : 'Add to Favorite',
                            style: const TextStyle(
                              fontSize: 13,
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                }),
              ],
            ),
          );
        },
      ),
    );
  }
}
