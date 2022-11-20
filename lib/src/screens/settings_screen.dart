import 'package:flutter/material.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  PreferredSizeWidget get _appBar => AppBar(
        title: const Text('Settings'),
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: double.infinity,
                  height: 54,
                  margin: const EdgeInsets.only(left: 16, right: 16, top: 16),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: const Color(0xFF222222),
                  ),
                  child: TextButton(
                    onPressed: () {
                      Navigator.of(context).pushNamed('unknown_route');
                    },
                    child: const Text('Unknown Route'),
                  ),
                ),
                ...List.generate(
                  8,
                  (index) {
                    return Container(
                      width: double.infinity,
                      height: 54,
                      margin:
                          const EdgeInsets.only(left: 16, right: 16, top: 16),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: const Color(0xFF222222),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
