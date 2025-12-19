import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    DevicePreview(
      builder: (context) {
        return const MyApp();
      },
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        useMaterial3: false,

        colorScheme: .fromSeed(seedColor: Colors.deepPurple),
      ),
      home: HomeView(),
    );
  }
}

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => HomeViewProvider(),

      child: Scaffold(
        appBar: AppBar(title: Text('Home View')),
        body: Center(
          child: Column(
            mainAxisAlignment: .center,
            children: [
              Selector<HomeViewProvider, int>(
                builder: (context, value, child) {
                  print('Incrementing Counter1');
                  return Text(
                    value.toString(),
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  );
                },
                selector: (context, provider) => provider.counter1,
              ),
              Selector<HomeViewProvider, int>(
                builder: (context, value, child) {
                  print('Incrementing Counter2');
                  return Text(
                    value.toString(),
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  );
                },
                selector: (context, provider) => provider.counter2,
              ),
              Divider(thickness: 2, color: Colors.black),
              Selector<HomeViewProvider, int>(
                builder: (context, value, child) {
                  print('Updating Total Counter');
                  return Text(
                    'Total Counter: $value',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  );
                },
                selector: (context, provider) => provider.totalCounter,
              ),
              SizedBox(height: 20),
              Consumer(
                builder: (context, HomeViewProvider provider, child) {
                  return Row(
                    mainAxisAlignment: .center,
                    children: [
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.deepPurple,
                          padding: EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 24,
                          ),
                        ),
                        onPressed: () {
                          provider.incrementCounter1();
                        },
                        child: Text('Increment Counter1'),
                      ),
                      SizedBox(width: 20),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.deepPurple,
                          padding: EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 24,
                          ),
                        ),
                        onPressed: () {
                          provider.incrementCounter2();
                        },
                        child: Text('Increment Counter2'),
                      ),
                    ],
                  );
                },
              ),
              SizedBox(height: 20),
              Consumer<HomeViewProvider>(
                builder: (context, provider, child) {
                  return ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      padding: EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 24,
                      ),
                    ),
                    onPressed: () {
                      provider.resetCounters();
                    },
                    child: Text('Reset Counters'),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class HomeViewProvider extends ChangeNotifier {
  int counter1 = 0;
  int counter2 = 0;
  int get totalCounter => counter1 + counter2;

  void incrementCounter1() {
    counter1++;
    notifyListeners();
  }

  void incrementCounter2() {
    counter2++;
    notifyListeners();
  }

  void resetCounters() {
    counter1 = 0;
    counter2 = 0;
    notifyListeners();
  }
}
