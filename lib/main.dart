import 'package:flutter/material.dart';
import 'package:flutter_api_project_mvvm/utils/routes/routes.dart';
import 'package:flutter_api_project_mvvm/utils/routes/routes_name.dart';
import 'package:flutter_api_project_mvvm/view_model/user_view_model.dart';
import 'package:flutter_api_project_mvvm/view_model/auth_view_model.dart';
import 'package:provider/provider.dart';

import 'view/login_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(providers: [
      ChangeNotifierProvider(create: (_)=>AuthViewModel()),
      ChangeNotifierProvider(create: (_)=>UserViewModel())
    ],
    child: MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: RoutesName.splash,
      onGenerateRoute: Routes.generateRoute,
    )
    );
  }
}

