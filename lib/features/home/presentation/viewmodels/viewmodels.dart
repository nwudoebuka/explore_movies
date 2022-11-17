import 'package:explore/features/home/presentation/viewmodels/home_viewmodel.dart';
import 'package:explore/service_locator.dart';
import 'package:provider/provider.dart';

final List homeViewModels = [
  ChangeNotifierProvider<HomeViewModel>(
    create: (_) => HomeViewModel(movieListService: sl()),
  ),
];
