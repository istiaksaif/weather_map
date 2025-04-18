import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get_storage/get_storage.dart';
import 'utils/session_manager.dart';
import 'view/screen/home/home_screen.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await GetStorage.init();
  SessionManager.init();
  runApp(ProviderScope(child: const MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    super.dispose();
    WidgetsBinding.instance.removeObserver(this);
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(430, 932),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MediaQuery(
          data: MediaQuery.of(
            context,
          ).copyWith(textScaler: const TextScaler.linear(1)),
          child: Builder(
            builder: (context) {
              return MaterialApp(
                navigatorKey: navigatorKey,
                builder: FToastBuilder(),
                debugShowCheckedModeBanner: false,
                home: HomeScreen(),
                theme: ThemeData(
                  textSelectionTheme: TextSelectionThemeData(
                    cursorColor: Colors.black,
                    selectionHandleColor: Colors.black,
                    selectionColor: Colors.black38,
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }

  bool _isBackgrounded = false;

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    if (state == AppLifecycleState.paused) {
      _isBackgrounded = true;
    } else if (state == AppLifecycleState.detached) {
      if (_isBackgrounded) {
        _restartApp();
      }
      _isBackgrounded = false;
    }
  }

  Future<void> _restartApp() async {
    runApp(const MyApp());
  }
}
