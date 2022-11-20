part of 'setup_flow.dart';

class WaitingPage extends StatefulWidget {
  final String message;
  final VoidCallback onWaitComplete;

  const WaitingPage({
    Key? key,
    required this.message,
    required this.onWaitComplete,
  }) : super(key: key);

  @override
  State<WaitingPage> createState() => _WaitingPageState();
}

class _WaitingPageState extends State<WaitingPage> {
  @override
  void initState() {
    super.initState();
    _startWaiting();
  }

  Future<void> _startWaiting() async {
    await Future<dynamic>.delayed(const Duration(seconds: 5));

    if (mounted) {
      widget.onWaitComplete();
    }
  }

  @override
  Widget build(BuildContext context) => _WaitingPageView(controller: this);
}

class _WaitingPageView extends StatelessWidget {
  final _WaitingPageState controller;

  const _WaitingPageView({
    Key? key,
    required this.controller,
  }) : super(key: key);

  WaitingPage get widget => controller.widget;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const CircularProgressIndicator.adaptive(),
                const SizedBox(height: 32),
                Text(widget.message),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
