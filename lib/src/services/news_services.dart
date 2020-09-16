import 'package:flutter/material.dart';
import 'package:noticiasapp/src/models/category_model.dart';
import 'package:noticiasapp/src/models/news_models.dart';
import 'package:http/http.dart' as http;
import 'package:font_awesome_flutter/font_awesome_flutter.dart';


const _URL_NEWS = 'http://newsapi.org/v2';
const _API_KEY = 'fe1b289695f04a5a989f30a75044fa9e';

class NewsServices with ChangeNotifier {
  
  List<Article> headlines = [];
  String _selectedCategory = 'business';


  List<Category> categories = [
    Category(FontAwesomeIcons.building, 'business'),
    Category(FontAwesomeIcons.tv, 'entertainment'),
    Category(FontAwesomeIcons.addressCard, 'general'),
    Category(FontAwesomeIcons.headSideVirus, 'health'),
    Category(FontAwesomeIcons.vials, 'science'),
    Category(FontAwesomeIcons.volleyballBall, 'sports'),
    Category(FontAwesomeIcons.memory, 'technology'),
  ];

  Map<String, List<Article>> categoryArticles = {};

  NewsServices() {
    
    this.getTopHeadlines();

    categories.forEach((item) {
      this.categoryArticles[item.name] = new List();
    });
  }

  get selectedCategory => this._selectedCategory;

  set selectedCategory(String value){
    this._selectedCategory = value;
    this.getArticleByCategory(value);
    notifyListeners();
  }

  List<Article> get getArticleCatSelec => this.categoryArticles[_selectedCategory];

  getTopHeadlines() async {
    
    final url = '$_URL_NEWS/top-headlines?apiKey=$_API_KEY&country=ve';
    final resp = await http.get(url);

    final newsResponse = newsResponseFromJson(resp.body);
    this.headlines.addAll(newsResponse.articles);
    notifyListeners();
  }

  getArticleByCategory( String category) async {

    if ( categoryArticles[category].length > 0){
        return categoryArticles[category];
    }

    final url = '$_URL_NEWS/top-headlines?apiKey=$_API_KEY&country=ve&category=$category';
    final resp = await http.get(url);

    final newsResponse = newsResponseFromJson(resp.body);
    this.categoryArticles[category].addAll(newsResponse.articles);
    notifyListeners();
  }
}