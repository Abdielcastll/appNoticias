import 'package:flutter/material.dart';
import 'package:noticiasapp/src/services/news_services.dart';
import 'package:noticiasapp/src/widgets/lista_noticias.dart';
import 'package:provider/provider.dart';

class Tab1Page extends StatefulWidget  {
  
  @override
  _Tab1PageState createState() => _Tab1PageState();
}

class _Tab1PageState extends State<Tab1Page> with  AutomaticKeepAliveClientMixin{
 
  @override
  Widget build(BuildContext context) {

    final newsServices = Provider.of<NewsServices>(context);

    return Scaffold(
      body: (newsServices.headlines.length == 0)
          ? Center(child: CircularProgressIndicator())
          : ListaNoticias(newsServices.headlines)
    );
  }

  @override
  bool get wantKeepAlive => true;
}
