import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:newsapi/custom_url/custom_url.dart';
import 'package:newsapi/screen/news_details.dart';
import 'package:shimmer/shimmer.dart';

import '../const/const.dart';
import '../news_model.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int pageNo = 3;
  String sortBy = 'popularity';
  @override
  Widget build(BuildContext context) {
    return AsyncSnapshot.nothing() == ConnectionState.waiting
        ? CircularProgressIndicator()
        : Scaffold(
            // backgroundColor: Colo,
            appBar: AppBar(
              title: Text(
                'The Daily Star',
                style: GoogleFonts.nunito(
                    fontSize: 20,
                    color: Colors.black87,
                    fontWeight: FontWeight.w800),
              ),
              centerTitle: true,
              backgroundColor: Colors.transparent,
              elevation: 0,
            ),
            body: Container(
                padding: EdgeInsets.all(16),
                child: Column(
                  children: [
                    Expanded(
                      child: FutureBuilder<List<Articles>>(
                        future: CustomUrl().fetchAllNewsData(
                            pageNo: pageNo.toString(), sortBy: sortBy),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return Center(
                                child: Image.network(
                                    'https://1.bp.blogspot.com/-0mSJp2OVAYU/X-YBaWXhp6I/AAAAAAAALWQ/9Pf-N_CxQMMxDc1j-Bc1HHDr0OoBcIWUgCPcBGAYYCw/s293/daily%2Bstar%2Blogo_jobeduexam.jpg'));
                          } else if (snapshot.hasError) {
                            return Text('Something Error');
                          } else if (snapshot.data == null) {
                            return Text('Data is null');
                          }
                          return ListView.separated(
                              physics: BouncingScrollPhysics(),
                              shrinkWrap: true,
                              itemBuilder: (context, index) => Card(
                                    child: GestureDetector(
                                      onTap: () => Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                DetailsNewsPage(
                                                    articles:
                                                        snapshot.data![index]),
                                          )),
                                      child: ListTile(
                                        leading: Image.network(
                                          snapshot.data![index].urlToImage
                                              .toString(),
                                        ),
                                        title: Text(
                                            snapshot.data![index].title
                                                .toString(),
                                            style: myStyle(18, Colors.black),
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis),
                                        subtitle: Text(
                                            snapshot.data![index].description
                                                .toString(),
                                            textAlign: TextAlign.left,
                                            maxLines: 3,
                                            overflow: TextOverflow.ellipsis,
                                            style: myStyle(12, Colors.black,
                                                FontWeight.w400)),
                                      ),
                                    ),
                                  ),
                              separatorBuilder: (context, index) =>
                                  SizedBox(height: 20),
                              itemCount: snapshot.data!.length);
                        },
                      ),
                    ),
                    Row(
                      children: [
                        ElevatedButton(
                            onPressed: () {
                              if (pageNo > 1) {
                                pageNo--;
                                setState(() {});
                              }
                            },
                            child: Text('Pre')),
                        Flexible(
                            child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: List.generate(
                              5,
                              (index) => GestureDetector(
                                  onTap: () {
                                    pageNo = (index + 1);
                                    setState(() {});
                                  },
                                  child: Container(
                                    padding: EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                          color: index == pageNo - 1
                                              ? Colors.red
                                              : Colors.blue,
                                        ),
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: Text(
                                      (index + 1).toString(),
                                      style: GoogleFonts.nunito(
                                        fontSize: index == pageNo - 1 ? 20 : 12,
                                        color: index == pageNo - 1
                                            ? Colors.red
                                            : Colors.black,
                                      ),
                                    ),
                                  ))),
                        )),
                        ElevatedButton(
                            onPressed: () {
                              if (pageNo < 5) {
                                pageNo++;
                                setState(() {});
                              }
                            },
                            child: Text('NEXT')),
                      ],
                    )
                  ],
                )),
          );
  }
}
