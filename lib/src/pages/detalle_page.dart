import 'package:flutter/material.dart';
import 'package:noticiasapp/src/models/news_models.dart';

class DetallePage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    
    final Article noticia = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          children: [
            _FotoNoticia(noticia.urlToImage),
            _CuerpoNoticia(noticia)
          ],
        ),
      ),
    );
  }
}

class _FotoNoticia extends StatelessWidget {
  
  final String foto;

  const _FotoNoticia(this.foto);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: FadeInImage(
        placeholder: AssetImage('assets/img/giphy.gif'), 
        image: NetworkImage(foto)
      ),
    );
  }
}

class _CuerpoNoticia extends StatelessWidget {
  final Article noticia;

  const _CuerpoNoticia(this.noticia);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Text(noticia.source.name),
            SizedBox(height: 5.0),
            Text(noticia.title,
            style: TextStyle(
              fontSize: 30.0,
              fontWeight: FontWeight.bold
            ),),
            SizedBox(height: 5.0),
            Text((noticia.content==null)?'':noticia.content,
              style: TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.bold
            )
            )
          ],
        ),
      ),
    );
  }
}