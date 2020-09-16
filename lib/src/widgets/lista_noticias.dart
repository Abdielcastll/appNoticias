import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:noticiasapp/src/models/news_models.dart';
import 'package:noticiasapp/src/theme/tema.dart';

class ListaNoticias extends StatelessWidget {
  final List<Article> noticias;
  
  const ListaNoticias( this.noticias );
  
  @override
  Widget build(BuildContext context) {
    
    return ListView.builder(
      physics: BouncingScrollPhysics(),
      itemCount: this.noticias.length,
      itemBuilder: (BuildContext context, int index) {
      
        return _Noticia(
          noticia: this.noticias[index],
          index: index,
        );
      },
    );
  }
}

class _Noticia extends StatelessWidget {
  
  final Article noticia;
  final int index;

  const _Noticia({
    @required this.noticia,
    @required this.index,
  });
  
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _TarjetaTopBar(noticia, index),
        SizedBox(height: 10.0,),
        _TarjetaTitulo(noticia),
        _TarjetaImagen(noticia),
        _TarjetaBody(noticia),
        SizedBox(height: 10.0,),
        _Botones(noticia),
        SizedBox(height: 20.0,),
        Divider(color: miTema.accentColor,)

      ],
    );
  }
}

class _TarjetaTopBar extends StatelessWidget {
  
  final Article noticia;
  final int index;

  const _TarjetaTopBar(this.noticia, this.index);
  
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.0),
      margin: EdgeInsets.only(top: 10.0),
      child: Row(
        children: [
          Text('${index + 1} ', style: TextStyle(color: miTema.accentColor, fontWeight: FontWeight.bold, fontSize: 16.0)),
          Text('${noticia.source.name}'),
        ],
      ),
    );
  }
}

class _TarjetaTitulo extends StatelessWidget {
  final Article noticia;

  const _TarjetaTitulo( this.noticia );
  
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 17.0),
      child: Text(noticia.title, 
        style: TextStyle( 
          fontSize: 20.0, 
          fontWeight: FontWeight.bold
        ),
      )
    );
  }
}

class _TarjetaImagen extends StatelessWidget {
  final Article noticia;

  const _TarjetaImagen(this.noticia);
  
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10.0),
      child: ClipRRect(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(50.0),
          bottomLeft:Radius.circular(50.0),
        ),
        child: Container(
          height: 200.0,
          width: double.infinity,
          child: (noticia.urlToImage != null)
            ?  
            FadeInImage(
            fit: BoxFit.cover,
            placeholder: AssetImage('assets/img/giphy.gif'), 
            image: NetworkImage(noticia.urlToImage)
            )
            :
            Image(
              image: AssetImage('assets/img/no-image.png'),
              fit: BoxFit.cover,
            )
        ),
      ),
    );
  }
}

class _TarjetaBody extends StatelessWidget {
  final Article noticia;

  const _TarjetaBody(this.noticia);
  
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.0) ,
      child: Text((noticia.description != null) ? noticia.description : ''),
    );
  }
}

class _Botones extends StatelessWidget {
  final Article noticia;

  const _Botones(this.noticia);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _boton(miTema.accentColor, FontAwesomeIcons.bookReader, (){
            Navigator.pushNamed(context, 'detalle', arguments: noticia);
          }),
         // _boton(Colors.lightGreen, Icons.account_balance, (){}),
         // _boton(Colors.lightBlue, Icons.account_balance_wallet, (){}),
        ],
      ),
    );
  }

  Widget _boton(Color color, IconData icon, Function callback) {
    return RawMaterialButton(
      padding: EdgeInsets.symmetric(horizontal: 50.0, vertical: 8.0),
      onPressed: callback,
      fillColor: color,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
      child: Icon(icon),
    );
  }
}