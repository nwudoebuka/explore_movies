import 'dart:developer';
import 'package:explore/features/home/data/local/models/list_of_movies_model.dart';
import 'package:explore/features/movie_details/presentation/widgets.dart/export.dart';
import 'package:explore/shared/utils/export.dart';
import 'package:explore/shared/widgets/export.dart';
import 'package:flutter/material.dart';

class MoviesDetails extends StatelessWidget {
  const MoviesDetails({super.key, required this.data});

  final MovieList data;

  @override
  Widget build(BuildContext context) {
    log(data.fullImagePath);
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: hPadding),
              sliver: SliverAppBar(
                flexibleSpace: AppNetworkImage(imageUrl: data.fullImagePath),
                expandedHeight: context.deviceHeight / 1.5,
                floating: true,
                snap: true,
              ),
            ),
            CustomList(data: data),
          ],
        ),
      ),
    );
  }
}
