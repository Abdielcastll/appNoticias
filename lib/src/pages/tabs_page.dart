import 'package:flutter/material.dart';
import 'package:noticiasapp/src/pages/tabs1_page.dart';
import 'package:noticiasapp/src/pages/tabs2_page.dart';
import 'package:noticiasapp/src/services/news_services.dart';
import 'package:provider/provider.dart';

class TabsPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
          create: (_) => _NavegacionModel(),
          child: Scaffold(
        body: _Paginas(),
        bottomNavigationBar: _Navegacion(),
      ),
    );
  }
}

class _Navegacion extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    
    final navegacionModel = Provider.of<_NavegacionModel>(context);

    return BottomNavigationBar(
      currentIndex: navegacionModel.paginaActual,
      onTap: (value) {
        if (value == 1){
          final newsServices = Provider.of<NewsServices>(context, listen: false);
          newsServices.getArticleByCategory('business');
        }
        navegacionModel.paginaActual = value;
      },
      items: [
        BottomNavigationBarItem(title: Text('Titulares'), icon: Icon(Icons.public)),
        BottomNavigationBarItem(title: Text('Categorias'), icon: Icon(Icons.public)),
      ]
    );
  }
}

class _Paginas extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    
    final navegacionModel = Provider.of<_NavegacionModel>(context);

    return PageView(
      controller: navegacionModel._pageController,
      physics: NeverScrollableScrollPhysics(),
      children: [
        Tab1Page(),
        Tab2Page()
      ],
    );
  }
}

class _NavegacionModel with ChangeNotifier{
  int _paginaActual = 0;
  PageController _pageController = new PageController();

  int get paginaActual => this._paginaActual;

  set paginaActual(int valor){
    this._paginaActual = valor;
    _pageController.animateToPage(valor, duration: Duration(milliseconds: 250), curve: Curves.easeInOut);
    notifyListeners();
  }
}