import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'comm/c.dart';
import 'bloc/bloc_provider.dart';
import 'bloc/index_bloc.dart';
import 'generated/i18n.dart';
import 'ui/page/SplashPage.dart';

void main() => runApp(BlocProvider<ApplicationBloc>(
      bloc: ApplicationBloc(),
      child: MyApp(),
    ));

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return MyAppState();
  }
}

class MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      debugShowCheckedModeBanner: false,
      home: new SplashPage(),
      theme: ThemeData.dark().copyWith(
        primaryColor: C.app_main,
        accentColor: C.app_accent,
        indicatorColor: Colors.white,
        highlightColor: Colors.transparent,
      ),
      localizationsDelegates: const [
        S.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: S.delegate.supportedLocales,
    );
  }
}
