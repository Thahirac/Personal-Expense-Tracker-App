import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:personal_expense_tracker_app/provider/auth_provider.dart';
import 'package:personal_expense_tracker_app/provider/expense_provider.dart';
import 'package:personal_expense_tracker_app/view/splash_screen.dart';
import 'package:provider/provider.dart';
import 'database/hive_database.dart';
import 'helpers/notificationservice.dart';
import 'modal/user.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  NotificationService.init();

  /// initialize Hive
  await Hive.initFlutter();

  /// open a Hive Box
  await Hive.openBox("expense_database");
  Hive.registerAdapter(UserAdapter());
  await Hive.openBox('users');
  await Hive.openBox('notificationTypeDb');


  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});


  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => ExpenseProvider(),

        ),
        ChangeNotifierProvider(
          create: (context) => AuthProvider(authService: HiveDataBase()),
        ),
      ],
      builder: (context, child) => MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: SplashscreenPage(),
      ),
    );
  }
}

