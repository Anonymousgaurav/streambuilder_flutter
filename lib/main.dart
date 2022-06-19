import 'package:flutter/material.dart';
//
// void main() => runApp(const MyApp());
//
// class MyApp extends StatelessWidget {
//   const MyApp({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) => const MaterialApp(
//     debugShowCheckedModeBanner: false,
//     home:  MainPage(),
//   );
// }
//
// class MainPage extends StatefulWidget {
//   const MainPage({Key? key}) : super(key: key);
//
//   @override
//   _MainPageState createState() => _MainPageState();
// }
//
// class _MainPageState extends State<MainPage> {
//   late Stream<int?> numbersStream;
//
//   @override
//   void initState() {
//     super.initState();
//
//     numbersStream = getNumbers();
//   }
//
//   Stream<int?> getNumbers() async* {
//     await Future.delayed(const Duration(seconds: 4));
//     yield 1;
//
//     await Future.delayed(const Duration(seconds: 1));
//     yield 2;
//
//     await Future.delayed(const Duration(seconds: 1));
//     yield 3;
//   }
//
//   @override
//   Widget build(BuildContext context) => Scaffold(
//     appBar: AppBar(
//       title: const Text('Stream Builder'),
//       centerTitle: true,
//     ),
//     floatingActionButton: FloatingActionButton(
//       child: const Icon(Icons.refresh),
//       onPressed: () {
//         setState(() {
//           numbersStream = getNumbers();
//         });
//       },
//     ),
//     body: Center(
//       child: StreamBuilder<int?>(
//         stream: numbersStream,
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return const Text('⌛ Wait');
//           } else if (snapshot.hasError) {
//             return Text('😞 ${snapshot.error}');
//           } else if (snapshot.hasData) {
//             int number = snapshot.data!;
//
//             return Text('🙋 $number');
//           } else {
//             return const Text('No data!');
//           }
//         },
//       ),
//     ),
//   );
// }






/// 2. Stream uses Connection State
import 'package:flutter/material.dart';
void main() => runApp(const MyApp());
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) => MaterialApp(
        debugShowCheckedModeBanner: false,
        home: const MainPage(),
      );
}
class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);
  @override
  _MainPageState createState() => _MainPageState();
}
class _MainPageState extends State<MainPage> {
  late Stream<int?> numbersStream;
  @override
  void initState() {
    super.initState();
    numbersStream = getNumbers();
  }
  Stream<int?> getNumbers() async* {
    await Future.delayed(const Duration(seconds: 4));
    yield 1;
    await Future.delayed(const Duration(seconds: 1));
    yield 2;
    await Future.delayed(const Duration(seconds: 1));
    yield 3;
  }
  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text('Stream Builder'),
          centerTitle: true,
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.refresh),
          onPressed: () {
            setState(() {
              numbersStream = getNumbers();
            });
          },
        ),
        body: Center(
          child: StreamBuilder<int?>(
            stream: numbersStream,
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Text('😞 ${snapshot.error}');
              }
              switch (snapshot.connectionState) {
                // Stream is null
                case ConnectionState.none:
                  return const Text(
                    'Stream is null',
                    textAlign: TextAlign.center,
                  );
                // Stream waits for first value
                case ConnectionState.waiting:
                  return const Text('⌛ Wait');
                // Stream got first value and has not yet finished
                case ConnectionState.active:
                  if (snapshot.hasData) {
                    int number = snapshot.data!;
                    return Text('🙋 $number');
                  } else {
                    return const Text('No data!');
                  }
                // Stream has finished
                case ConnectionState.done:
                  if (snapshot.hasData) {
                    int number = snapshot.data!;
                    return Text('✅ $number');
                  } else {
                    return const Text('No data!');
                  }
              }
            },
          ),
        ),
      );
}
