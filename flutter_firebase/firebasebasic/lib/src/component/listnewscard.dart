import 'package:firebasebasic/src/screen/newsDetailScreen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ListNewsCard extends StatelessWidget {
  final List<dynamic> news;
  final String imageUrl;
  final String headline;
  final String newsTime;
  final String newsContents;

  ListNewsCard(
      {this.news,
      this.imageUrl,
      this.headline,
      this.newsTime,
      this.newsContents});

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> newsData = {};
    String _newsContents;

    return Padding(
      padding: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 20.0),
      child: Container(
        color: Colors.transparent,
        child: Column(
          children: [
            GestureDetector(
              onTap: () {
                _newsContents = newsContents
                    .replaceAll(
                        RegExp(
                            r"(<img src=){1}(\S+)?(\s+)*(\S+)?(\s+)*(\S+)?(\s+)*(\S+)?(\s+)*"),
                        "")
                    .replaceAll(RegExp(r"(\\n){1}(\s+)*(\\n){1}(\s+)*"), "\n")
                    .replaceAll(RegExp(r"(\\n){1}(\s+)*"), "\n")
                    .replaceAll("\\", "");

                newsData['press'] = '국민일보';
                newsData['headline'] = headline;
                newsData['time'] = newsTime;
                newsData['thumnail'] = imageUrl;
                newsData['contents'] = _newsContents;

                Route route = MaterialPageRoute(
                    builder: (context) => NewsDetailScreen(
                          newsData: newsData,
                        ));
                navigator.pushAndRemoveUntil(route, ModalRoute.withName('/'));
              },
              child: Row(
                children: [
                  Container(
                      margin: const EdgeInsets.fromLTRB(0.0, 0.0, 10.0, 0.0),
                      width: 82,
                      height: 56,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(3),
                          image: DecorationImage(
                              fit: BoxFit.cover,
                              image: imageUrl != 'empty'
                                  ? NetworkImage("$imageUrl")
                                  : AssetImage("assets/images/noimage.jpg")))),
                  Expanded(
                      child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${newsData['headline']}',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w400,
                          color: Colors.black,
                        ),
                        softWrap: true,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Row(
                        children: [
                          Text(
                            '${newsData['press']}',
                            style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w300,
                                color: Colors.black.withOpacity(0.5)),
                            softWrap: true,
                          ),
                          Container(
                            margin: const EdgeInsets.symmetric(horizontal: 5),
                            width: 1,
                            height: 10,
                            color: Colors.black.withOpacity(0.2),
                          ),
                          Text(
                            '${newsData['time']}',
                            style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w300,
                                color: Colors.black.withOpacity(0.5)),
                            softWrap: true,
                          )
                        ],
                      )
                    ],
                  )),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
