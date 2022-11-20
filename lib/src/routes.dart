import 'package:flutter/material.dart';

import 'screens/screens.dart';

/// TOP LEVEL NAVIGATION
const routeHome = '/';
const routeSettings = '/settings';

/// NESTED NAVIGATION IN [setup] ROUTE
const routePrefixDeviceSetup = '/setup/';
const routeDeviceSetupStart =
    '$routePrefixDeviceSetup$routeDeviceSetupStartPage';
const routeDeviceSetupStartPage = 'find_devices';
const routeDeviceSetupSelectDevicePage = 'select_device';
const routeDeviceSetupConnectingPage = 'connecting';
const routeDeviceSetupFinishedPage = 'finished';

Route<dynamic>? onGenerateRoutes(RouteSettings settings) {
  late Widget page;
  if (settings.name == routeHome) {
    page = const HomeScreen();
  } else if (settings.name == routeSettings) {
    page = const SettingsScreen();
  } else if (settings.name!.startsWith(routePrefixDeviceSetup)) {
    final subRoute = settings.name!.substring(routePrefixDeviceSetup.length);
    page = SetupFlow(
      setupPageRoute: subRoute,
    );
  } else {
    page = const RouteNotFoundScreen();
  }

  return MaterialPageRoute<dynamic>(
    settings: settings,
    builder: (context) => page,
  );
}
