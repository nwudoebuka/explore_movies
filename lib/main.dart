import 'package:explore/core/utils/export.dart';
import 'package:explore/features/home/presentation/screens/home_screen.dart';
import 'package:explore/features/home/presentation/viewmodels/viewmodels.dart';
import 'package:explore/shared/utils/export.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AppConfig.initDependencies();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ...homeViewModels,
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: appTheme,
        debugShowCheckedModeBanner: false,
        home: Builder(
          builder: (context) {
            final media = MediaQuery.of(context);
            Dims.setSize(media);
            return MediaQuery(
              data: MediaQuery.of(context).copyWith(
                textScaleFactor: 1,
              ),
              child: const HomeScreen(),
            );
          },
        ),
      ),
    );
  }
}
