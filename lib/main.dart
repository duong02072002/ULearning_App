import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_ulearning_app/common/routes/routes.dart';
import 'package:flutter_ulearning_app/common/services/http_until.dart';
import 'package:flutter_ulearning_app/common/utils/app_styles.dart';

import 'global.dart';

Future<void> main() async {
  await Global.init();
  //HttpUtil().post("api/login");

  runApp(const ProviderScope(child: MyApp()));
}

final GlobalKey<NavigatorState> navKey = GlobalKey<NavigatorState>();

// var routesMap = {
//   "/": (context) => Welcome(),
//   "/signIn": (context) => SignIn(),
//   "/register": (context) => SignUp(),
//   "/application": (context) => Application(),
// };

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: navKey,
      title: 'Flutter Demo',
      theme: AppTheme.appThemeData,
      initialRoute: "/",
      debugShowCheckedModeBanner: false,
      //routes: routesMap,
      onGenerateRoute: AppPages.generateRouteSettings,
      //home: Welcome(), // initial routine "/"
    );
  }
}

final appCount = StateProvider<int>((ref) {
  return 2;
});

class MyHomePage extends ConsumerWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    int count = ref.watch(appCount);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,

        title: Text("Riverpod App"),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text('You have pushed the button this many times:'),
            Text(
              count.toString(),
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          FloatingActionButton(
            heroTag: "one",
            onPressed: () {
              navRoute(context);
            },
            tooltip: 'Increment',
            child: const Icon(Icons.arrow_right_rounded),
          ),
          FloatingActionButton(
            heroTag: "two",
            onPressed: () => ref.read(appCount.notifier).state++,
            // onPressed:()=> myFunc(),
            tooltip: 'Increment',
            child: const Icon(Icons.add),
          ),
        ],
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

void myFunc() {
  print("object");
}

void navRoute(BuildContext context) {
  Navigator.of(context).push(
    MaterialPageRoute(builder: (BuildContext context) => const SecondPage()),
  );
}

class SecondPage extends ConsumerWidget {
  const SecondPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    int count = ref.watch(appCount);
    return Scaffold(
      appBar: AppBar(),
      body: Center(child: Text("$count", style: TextStyle(fontSize: 30))),
    );
  }
}
