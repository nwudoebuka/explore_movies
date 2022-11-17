import 'package:explore/features/home/presentation/screens/export.dart';
import 'package:explore/features/home/presentation/viewmodels/home_viewmodel.dart';
import 'package:explore/shared/utils/dimension.dart';
import 'package:explore/shared/utils/themes.dart';
import 'package:explore/shared/widgets/app_tab_widget.dart';
import 'package:explore/shared/widgets/app_text_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  late TabController _controller;
  int selectedIndex = 0;

  late HomeViewModel _homeViewModel;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timestamp) {
      _homeViewModel.fetchMovieList();
    });
    _controller = TabController(length: 2, vsync: this);
    _controller.addListener(() {
      setState(() {
        selectedIndex = _controller.index;
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _homeViewModel = context.read<HomeViewModel>();
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            YBox(20.dy),
            Padding(
              padding: const EdgeInsets.only(left: hPadding),
              child: AppTextWidget(
                text: 'Explore',
                fontSize: 40.sp,
                fontWeight: FontWeight.w500,
                textColor: appColors.white,
              ),
            ),
            YBox(20.dy),
            SizedBox(
              width: 230.dx,
              child: TabBar(
                controller: _controller,
                indicatorPadding: EdgeInsets.zero,
                labelPadding: EdgeInsets.zero,
                labelColor: Colors.white,
                indicatorSize: TabBarIndicatorSize.label,
                physics: const BouncingScrollPhysics(),
                indicatorWeight: 2,
                indicatorColor: appColors.secondaryColor,
                padding: EdgeInsets.zero,
                tabs: [
                  AppTabBar(
                    index: 0,
                    tabTitle: 'Movies',
                    selectedIndex: selectedIndex,
                  ),
                  AppTabBar(
                    index: 1,
                    tabTitle: 'Favorites',
                    selectedIndex: selectedIndex,
                  ),
                ],
              ),
            ),
            YBox(20.dy),
            Expanded(
              child: TabBarView(
                controller: _controller,
                children: const [MovieTabView(), FaveTabView()],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
