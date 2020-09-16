import 'package:flutter/material.dart';
import 'package:noticiasapp/src/pages/detalle_page.dart';
import 'package:noticiasapp/src/pages/tabs_page.dart';
import 'package:noticiasapp/src/services/news_services.dart';
import 'package:noticiasapp/src/theme/tema.dart';
import 'package:provider/provider.dart';
 
void main() => runApp(MyApp());
 
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => NewsServices()),
      ],
      child: MaterialApp(
        theme: miTema,
        debugShowCheckedModeBanner: false,
        title: 'Material App',
        initialRoute: 'tabs',
        routes: {
          'tabs'    : (context) => TabsPage(),
          'detalle' : (context) => DetallePage(),
        },
        home: TabsPage()
      ),
    );
  }
}