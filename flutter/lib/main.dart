import 'package:flutter/material.dart';
import 'home_page.dart';
import 'pages/startup_page.dart';
import 'services/storage_service.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Kuba UI Hub',
      theme: ThemeData(
        // Material 3 design system with brand colors
        // All components automatically use Material 3 styling:
        // - DropdownMenu, DatePickerDialog, CalendarDatePicker
        // - FilledButton, OutlinedButton, TextButton
        // - AppBar, TextField, BottomSheet
        useMaterial3: true,
        colorScheme: ColorScheme(
          brightness: Brightness.light,
          // Primary colors (Purple)
          primary: const Color(0xFF93328E), // Primary
          onPrimary: Colors.white,
          primaryContainer: const Color(0xFF9E4799), // Primary Tint
          onPrimaryContainer: Colors.white,
          // Secondary colors (Orange/Amber)
          secondary: const Color(0xFFF1B434), // Secondary
          onSecondary: Colors.black87,
          secondaryContainer: const Color(0xFFF2BC48), // Secondary Tint
          onSecondaryContainer: Colors.black87,
          // Error colors
          error: Colors.red,
          onError: Colors.white,
          errorContainer: Colors.red.shade100,
          onErrorContainer: Colors.red.shade900,
          // Surface colors
          surface: Colors.white,
          onSurface: Colors.black87,
          surfaceVariant: Colors.grey.shade100,
          onSurfaceVariant: Colors.black87,
          // Background colors
          background: Colors.white,
          onBackground: Colors.black87,
          // Outline colors
          outline: Colors.grey.shade400,
          outlineVariant: Colors.grey.shade300,
          // Shadow
          shadow: Colors.black26,
          // Surface tint
          surfaceTint: const Color(0xFF93328E),
        ),
      ),
      home: const _AppInitializer(),
    );
  }
}

class _AppInitializer extends StatefulWidget {
  const _AppInitializer();

  @override
  State<_AppInitializer> createState() => _AppInitializerState();
}

class _AppInitializerState extends State<_AppInitializer> {
  bool _isLoading = true;
  bool _hasReviewer = false;

  @override
  void initState() {
    super.initState();
    _checkReviewer();
  }

  Future<void> _checkReviewer() async {
    final hasReviewer = await StorageService.hasReviewer();
    setState(() {
      _hasReviewer = hasReviewer;
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    return _hasReviewer ? const HomePage() : const StartupPage();
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // TRY THIS: Try changing the color here to a specific color (to
        // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
        // change color while the other colors stay the same.
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          //
          // TRY THIS: Invoke "debug painting" (choose the "Toggle Debug Paint"
          // action in the IDE, or press "p" in the console), to see the
          // wireframe for each widget.
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text('You have pushed the button this many times:'),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
