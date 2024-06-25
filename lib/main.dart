import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
 @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ClickSettingsScreen(),
    );
  }
}

class ClickSettingsScreen extends StatefulWidget {
  @override
  _ClickSettingsScreenState createState() => _ClickSettingsScreenState();
}

class _ClickSettingsScreenState extends State<ClickSettingsScreen> {
  final TextEditingController clicksController = TextEditingController();
  final TextEditingController delayController = TextEditingController();
  final TextEditingController roundDelayController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Auto Clicker Settings')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: clicksController,
              decoration: InputDecoration(labelText: 'Number of Clicks'),
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: delayController,
              decoration: InputDecoration(labelText: 'Delay Between Clicks (ms)'),
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: roundDelayController,
              decoration: InputDecoration(labelText: 'Delay Between Rounds (ms)'),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                int clicks = int.parse(clicksController.text);
                int delay = int.parse(delayController.text);
                int roundDelay = int.parse(roundDelayController.text);
                
                AutoClicker().startAutoClick(clicks, delay, roundDelay);
              },
              child: Text('Start Auto Clicking'),
            ),
          ],
        ),
      ),
    );
  }
}

class AutoClicker {
  static const platform = MethodChannel('com.example.auto_click_app/click');

  Future<void> startAutoClick(int clicks, int delay, int roundDelay) async {
    try {
      await platform.invokeMethod('startAutoClick', {
        'clicks': clicks,
        'delay': delay,
        'roundDelay': roundDelay,
      });
    } on PlatformException catch (e) {
      print("Failed to start auto click: '${e.message}'.");
    }
  }
}