import 'package:firebasebasic/src/component/listnewscard.dart';
import 'package:firebasebasic/src/utility/dataTransfer.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewsScreen extends StatelessWidget {
  final List<dynamic> politicNews;

  NewsScreen({this.politicNews});

  @override
  Widget build(BuildContext context) {
    ScrollController _scrollController = ScrollController();

    Widget _pageListNews(List<dynamic> news) {
      return SliverPadding(
          padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
          sliver: SliverList(
            delegate: SliverChildListDelegate(
              List.generate(20, (index) {
                String headLine = news[index]['title']['__cdata']
                    .replaceAll(RegExp(r"[\\]+"), "");
                String imageurl;
                try {
                  imageurl = news[index]['media\$content']['url'];
                } catch (e) {
                  imageurl = 'empty';
                }
                String time = news[index]['pubDate']['\$t'].split(',')[1];
                String newsTime = time.split(" ")[2] +
                    '.' +
                    getMonthToNumber(month: time.split(" ")[1]) +
                    '.' +
                    isPlusZero(day: time.split(" ")[0]) +
                    ' ' +
                    DateFormat.jm().format(
                        DateFormat("hh:mm:ss").parse(time.split(" ")[3]));

                String newsContents = news[index]['description']['__cdata'];

                return ListNewsCard(
                  news: news,
                  imageUrl: imageurl,
                  headline: headLine,
                  newsTime: newsTime,
                  newsContents: newsContents,
                );
              }),
            ),
          ));
    }

    Widget _bodyWidget() {
      return CustomScrollView(
        controller: _scrollController,
        slivers: [
          SliverList(
            delegate: SliverChildListDelegate([_pageListNews(politicNews)]),
          )
        ],
      );
    }

    return Scaffold(
      body: _bodyWidget(),
    );
  }
}
