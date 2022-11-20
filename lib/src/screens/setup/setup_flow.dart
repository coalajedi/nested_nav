import 'package:flutter/material.dart';

import '../../routes.dart';

part 'finished_page.dart';
part 'select_device_page.dart';
part 'waiting_page.dart';

@immutable
class SetupFlow extends StatefulWidget {
  final String setupPageRoute;

  const SetupFlow({
    Key? key,
    required this.setupPageRoute,
  }) : super(key: key);

  @override
  State<SetupFlow> createState() => _SetupFlowState();
}

class _SetupFlowState extends State<SetupFlow> {
  final _navigatorKey = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) => _SetupFlowView(controller: this);

  Future<void> _onExitPressed() async {
    final isConfirmed = await _isExitDesired();

    if (isConfirmed && mounted) {
      _exitSetup();
    }
  }

  Future<bool> _isExitDesired() async {
    return await showDialog<bool>(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: const Text('Are you sure?'),
                content: const Text(
                    'If you exit device setup, your progress will be lost.'),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop(true);
                    },
                    child: const Text('Leave'),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop(false);
                    },
                    child: const Text('Stay'),
                  ),
                ],
              );
            }) ??
        false;
  }

  void _exitSetup() {
    Navigator.of(context).pop();
  }

  void _onDiscoveryComplete() {
    _navigatorKey.currentState!.pushNamed(routeDeviceSetupSelectDevicePage);
  }

  void _onDeviceSelected(String deviceId) {
    _navigatorKey.currentState!.pushNamed(routeDeviceSetupConnectingPage);
  }

  void _onConnectionEstablished() {
    _navigatorKey.currentState!.pushNamed(routeDeviceSetupFinishedPage);
  }

  Route _onGenerateRoute(RouteSettings settings) {
    late Widget page;
    switch (settings.name) {
      case routeDeviceSetupStartPage:
        page = WaitingPage(
          message: 'Searching for nearby bulb...',
          onWaitComplete: _onDiscoveryComplete,
        );
        break;
      case routeDeviceSetupSelectDevicePage:
        page = SelectDevicePage(
          onDeviceSelected: _onDeviceSelected,
        );
        break;
      case routeDeviceSetupConnectingPage:
        page = WaitingPage(
          message: 'Connecting...',
          onWaitComplete: _onConnectionEstablished,
        );
        break;
      case routeDeviceSetupFinishedPage:
        page = FinishedPage(
          onFinishPressed: _exitSetup,
        );
        break;
    }

    return MaterialPageRoute<dynamic>(
      settings: settings,
      builder: (context) => page,
    );
  }
}

class _SetupFlowView extends StatelessWidget {
  final _SetupFlowState controller;

  const _SetupFlowView({
    Key? key,
    required this.controller,
  }) : super(key: key);

  SetupFlow get widget => controller.widget;

  PreferredSizeWidget get _appBar => AppBar(
        leading: IconButton(
          onPressed: controller._onExitPressed,
          icon: const Icon(Icons.chevron_left),
        ),
        title: const Text('Bulb Setup'),
      );

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: controller._isExitDesired,
      child: Scaffold(
        appBar: _appBar,
        body: Navigator(
          key: controller._navigatorKey,
          initialRoute: widget.setupPageRoute,
          onGenerateRoute: controller._onGenerateRoute,
        ),
      ),
    );
  }
}
