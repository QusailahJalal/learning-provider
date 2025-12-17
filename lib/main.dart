import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
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
    return  ChangeNotifierProvider(
      create: (context) => HomeViewProvider(),

      child :Scaffold(
        appBar: AppBar(
          title: Text('Home View'),
        ),
        body: Center(
          child: Consumer<HomeViewProvider>(builder: (context, homeProvider, child) => Column(
            children: [
              SizedBox(height: 30,),
              Text(homeProvider.helloMessage),
              SizedBox(height: 30,),
              ElevatedButton(onPressed: () {
                    homeProvider.updateMessage('Hello again, World!');
              }, child: Text('Next View'))
            ],
          ),)
        ),
      ),
    );
  }
}

class HomeViewProvider extends ChangeNotifier{
  String helloMessage = "Hello, World!";
  void updateMessage(String newMessage){
    helloMessage = newMessage;
    notifyListeners();
  }
}
