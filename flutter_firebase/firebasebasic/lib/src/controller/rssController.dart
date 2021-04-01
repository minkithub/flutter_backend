import 'dart:convert';

import 'package:firebasebasic/src/model/rss_model.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:xml2json/xml2json.dart';

class RssControlleer extends GetxController {
  RssNews rssNews;

  // ignore: missing_return
  Future<List> rssToJson(String category) async {
    String rssUrl = 'http://rss.kmib.co.kr/data/kmib';
    var client = http.Client();
    final myTransformer = Xml2Json();
    try {
      return await client.get(rssUrl + category + 'Rss.xml').then((response) {
        return utf8.decode(response.bodyBytes);
      }).then((bodyString) {
        print('bodyString : $bodyString');
        myTransformer.parse(bodyString);
        var json = myTransformer.toGData();
        return jsonDecode(json)['rss']['channel']['item'];
      });
    } catch (e) {
      print('에러가 발생했습니다. $e');
    }
  }

  getKmibData() async {
    rssNews = RssNews(
      politic: await rssToJson('Pol'),
      economy: await rssToJson('Eco'),
      society: await rssToJson('Soc'),
      international: await rssToJson('Int'),
      entertainment: await rssToJson('Cul'),
      sports: await rssToJson('Spo'),
    );
    update();

    return rssNews;
  }
}
