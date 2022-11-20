import 'package:flutter/material.dart';

import 'routes.dart';

class App extends StatelessWidget {
  final String appTitle = 'Nested Nav';

  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: appTitle,
      theme: ThemeData.dark(useMaterial3: true),
      onGenerateRoute: onGenerateRoutes,
    );
  }
}
