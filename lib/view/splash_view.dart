
import 'package:flutter/material.dart';
import 'package:flutter_api_project_mvvm/utils/splash_service.dart';

class SplashView extends StatefulWidget {
  const SplashView({Key? key}) : super(key: key);

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  SplashService sps=SplashService();
  @override
  void initState() {
    super.initState();
    sps.checkAuth(context);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('Splash Screen', style: Theme.of(context).textTheme.labelLarge),
      ),
    );
  }
}
