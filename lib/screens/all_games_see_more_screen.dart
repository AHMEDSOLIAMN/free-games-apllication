import 'package:flutter/material.dart';
import 'package:free_to_game/providers/app_provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../core/app_colors.dart';
import 'game_details_screen.dart';

class AllGamesSeeMoreScreen extends StatelessWidget {
  const AllGamesSeeMoreScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<ApplicationProvider>(
      builder: (context, controller, child) {
        return Scaffold(
          appBar: AppBar(
            title: Text(
              'Free Games',
              style: GoogleFonts.acme(),
            ),
            centerTitle: true,
          ),
          body: FutureBuilder(
            future: controller.getAllGamesData(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (snapshot.hasError) {
                return Center(
                  child: Text(
                    'Error!',
                    style: TextStyle(color: Colors.white),
                  ),
                );
              }
              return Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  children: [
                    Expanded(
                      child: ListView.separated(
                        itemBuilder: (context, index) {
                          return  InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => GameDetailsScreen(
                                      gameId: snapshot.data[index]['id']),
                                ),
                              );
                            },
                            child: Card(
                              margin: EdgeInsets.zero,
                              color: MyColors().cardColor,
                              clipBehavior: Clip.antiAliasWithSaveLayer,
                              elevation: 5,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    clipBehavior: Clip.antiAliasWithSaveLayer,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Image(
                                      image: NetworkImage(
                                          '${snapshot.data[index]['thumbnail']}'),
                                      height: 130,
                                      width: 130,
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(5.0),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        SizedBox(
                                          width: 220,
                                          child: Text(
                                            '${snapshot.data[index]['title']}',
                                            maxLines: 1,
                                            style: GoogleFonts.acme(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 22,
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          width: 220,
                                          child: Text(
                                            '${snapshot.data[index]['short_description']}',
                                            maxLines: 3,
                                            style: TextStyle(
                                                fontSize: 16, color: Colors.grey[400]),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Row(
                                          children: [
                                            Container(
                                              width: 120,
                                              height: 26,
                                              decoration: BoxDecoration(
                                                color: MyColors().scaffoldColor,
                                                borderRadius: BorderRadius.circular(10),
                                              ),
                                              child: Center(
                                                child: Text(
                                                  '${snapshot.data[index]['platform']}',
                                                  style: TextStyle(color: Colors.white),
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            Container(
                                              width: 90,
                                              height: 26,
                                              decoration: BoxDecoration(
                                                color: MyColors().scaffoldColor,
                                                borderRadius: BorderRadius.circular(10),
                                              ),
                                              child: Center(
                                                child: Text(
                                                  '${snapshot.data[index]['genre']}',
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                        separatorBuilder: (context, index) => SizedBox(height: 15,),
                        itemCount: snapshot.data.length,
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        );
      },
    );
  }
}
