import 'package:flutter/material.dart';
import 'package:noticiasapp/src/models/category_model.dart';
import 'package:noticiasapp/src/services/news_services.dart';
import 'package:noticiasapp/src/theme/tema.dart';
import 'package:noticiasapp/src/widgets/lista_noticias.dart';
import 'package:provider/provider.dart';


class Tab2Page extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    final category = Provider.of<NewsServices>(context);

    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            _ListaCategoria(),
            Divider(),
            Expanded(
              child : (category.getArticleCatSelec.length > 0)
                    ? ListaNoticias(category.getArticleCatSelec)
                    : Center(child: CircularProgressIndicator())
            )
          ],
        ),
      ),
    );
  }
}

class _ListaCategoria extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {

    final categoria = Provider.of<NewsServices>(context).categories;

    return Container(
      width: double.infinity,
      height: 90.0,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        physics: BouncingScrollPhysics(),
        itemCount: categoria.length,
        itemBuilder: (BuildContext context, int index) {
        
          final cName = categoria[index].name;

          return Container(
            width: 100.0,
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                children: [
                  _CategoryBoton(categoria[index]),
                  SizedBox(height: 5.0,),
                  Text('${cName[0].toUpperCase()}${cName.substring(1)}'),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class _CategoryBoton extends StatelessWidget {
  final Category category;

  const _CategoryBoton(this.category);

  @override
  Widget build(BuildContext context) {
    
    final newsServices = Provider.of<NewsServices>(context);
    
    return GestureDetector(
      onTap: (){
        final newsServices = Provider.of<NewsServices>(context, listen: false);
        newsServices.selectedCategory = category.name;
      },
      child: Container(
        height: 50.0,
        width: 50.0,
        decoration: BoxDecoration(
          border: Border.all(
            width: 2.5,
            color: (newsServices.selectedCategory == this.category.name)
              ? miTema.accentColor
              : Colors.white
          ),
          color: Colors.white,
          shape: BoxShape.circle
        ),
        child: Icon(category.icon, 
          color: (newsServices.selectedCategory == this.category.name)
              ? miTema.accentColor
              : Colors.black54
        )
      ),
    );
  }
}