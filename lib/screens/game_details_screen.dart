import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:free_to_game/core/app_colors.dart';
import 'package:free_to_game/providers/app_provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/link.dart';

class GameDetailsScreen extends StatelessWidget {
  final gameId;

  const GameDetailsScreen({Key? key, this.gameId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<ApplicationProvider>(
      builder: (context, controller, child) {
        return Scaffold(
          appBar: AppBar(),
          body: FutureBuilder(
            future: controller.getGameDetails(gameId: "${gameId}"),
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
              if (snapshot.data['minimum_system_requirements'] == null) {
                return Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Stack(
                          children: [
                            ShaderMask(
                              shaderCallback: (rect) {
                                return LinearGradient(
                                  end: Alignment.bottomLeft,
                                  colors: [
                                    MyColors().primaryColor,
                                    Colors.transparent
                                  ],
                                ).createShader(Rect.fromLTRB(0, 0, 200, 200));
                              },
                              blendMode: BlendMode.dstIn,
                              child: Container(
                                height: 200,
                                clipBehavior: Clip.antiAliasWithSaveLayer,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Image(
                                  image: NetworkImage(
                                    '${snapshot.data['thumbnail']}',
                                  ),
                                  fit: BoxFit.cover,
                                  width: double.infinity,
                                ),
                              ),
                            ),
                            Row(
                              children: [
                                Spacer(),
                                Link(
                                  target: LinkTarget.self,
                                  uri: Uri.parse('${snapshot.data['game_url']}'),
                                  builder: (context, followLink) {
                                    return InkWell(
                                      onTap: followLink,
                                      child: ElevatedButton(
                                        style: ButtonStyle(
                                            backgroundColor:
                                            MaterialStatePropertyAll(
                                                MyColors()
                                                    .primaryColor
                                                    .withOpacity(0.7))),
                                        onPressed: followLink,
                                        child: Text('Game Website'),
                                      ),
                                    );
                                  },
                                )
                              ],
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Row(
                          children: [
                            SizedBox(
                              width: 150,
                              child: Text(
                                '${snapshot.data['title']}',
                                maxLines: 2,
                                style: GoogleFonts.acme(
                                  color: Colors.white,
                                  fontSize: 20,
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            CircleAvatar(
                              radius: 3,
                              backgroundColor: Colors.red,
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Container(
                              width: 80,
                              height: 26,
                              decoration: BoxDecoration(
                                color: MyColors().primaryColor,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Center(
                                child: Text(
                                  '${snapshot.data['release_date']}',
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            CircleAvatar(
                              radius: 3,
                              backgroundColor: Colors.red,
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Container(
                              width: 90,
                              height: 26,
                              decoration: BoxDecoration(
                                color: MyColors().primaryColor,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Center(
                                child: Text(
                                  '${snapshot.data['genre']}',
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            Image(
                              image: AssetImage('assets/photos/system.png'),
                              height: 30,
                              width: 30,
                              color: MyColors().primaryColor,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              '${snapshot.data['platform']}',
                              style: TextStyle(color: Colors.white),
                            )
                          ],
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Row(
                          children: [
                            Image(
                              image: AssetImage('assets/photos/coding.png'),
                              height: 30,
                              width: 30,
                              color: MyColors().primaryColor,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              '${snapshot.data['developer']}',
                              style: TextStyle(color: Colors.white),
                            )
                          ],
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Row(
                          children: [
                            Image(
                              image: AssetImage('assets/photos/right.png'),
                              height: 30,
                              width: 30,
                              color: MyColors().primaryColor,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            SizedBox(
                                width: 330,
                                child: Text(
                                  '${snapshot.data['publisher']}',
                                  style: TextStyle(color: Colors.white),
                                ))
                          ],
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Text(
                          '${snapshot.data['description']}',
                          style: TextStyle(
                            color: Colors.grey[400],
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        // Row(
                        //   children: [
                        //     Container(
                        //       width: 40,
                        //       height: 1,
                        //       color: MyColors().primaryColor,
                        //     ),
                        //     SizedBox(
                        //       width: 2,
                        //     ),
                        //     Text(
                        //       'Minimum System Requirements',
                        //       style: TextStyle(color: MyColors().primaryColor),
                        //     ),
                        //     SizedBox(
                        //       width: 2,
                        //     ),
                        //     Container(
                        //       width: 119,
                        //       height: 1,
                        //       color: MyColors().primaryColor,
                        //     ),
                        //   ],
                        // ),
                        // SizedBox(
                        //   height: 10,
                        // ),
                        // Row(
                        //   children: [
                        //     Text(
                        //       'Operating System:  ',
                        //       style: TextStyle(
                        //         color: Colors.white,
                        //         fontWeight: FontWeight.bold,
                        //         fontSize: 16,
                        //       ),
                        //     ),
                        //     SizedBox(
                        //       width: 220,
                        //       child: Text(
                        //         '${snapshot.data['minimum_system_requirements']['os']}',
                        //         style: TextStyle(color: Colors.white),
                        //       ),
                        //     ),
                        //   ],
                        // ),
                        // SizedBox(
                        //   height: 10,
                        // ),
                        // Row(
                        //   children: [
                        //     Text(
                        //       'Processor:  ',
                        //       style: TextStyle(
                        //         color: Colors.white,
                        //         fontWeight: FontWeight.bold,
                        //         fontSize: 16,
                        //       ),
                        //     ),
                        //     Text(
                        //       '${snapshot.data['minimum_system_requirements']['processor']}',
                        //       style: TextStyle(color: Colors.white),
                        //     ),
                        //   ],
                        // ),
                        // SizedBox(
                        //   height: 10,
                        // ),
                        // Row(
                        //   children: [
                        //     Text(
                        //       'Memory:  ',
                        //       style: TextStyle(
                        //         color: Colors.white,
                        //         fontWeight: FontWeight.bold,
                        //         fontSize: 16,
                        //       ),
                        //     ),
                        //     Text(
                        //       '${snapshot.data['minimum_system_requirements']['memory']}',
                        //       style: TextStyle(color: Colors.white),
                        //     ),
                        //   ],
                        // ),
                        // SizedBox(
                        //   height: 10,
                        // ),
                        // Row(
                        //   children: [
                        //     Text(
                        //       'GPU:  ',
                        //       style: TextStyle(
                        //         color: Colors.white,
                        //         fontWeight: FontWeight.bold,
                        //         fontSize: 16,
                        //       ),
                        //     ),
                        //     SizedBox(
                        //       width: 320,
                        //       child: Text(
                        //         '${snapshot.data['minimum_system_requirements']['graphics']}',
                        //         maxLines: 2,
                        //         style: TextStyle(color: Colors.white),
                        //       ),
                        //     ),
                        //   ],
                        // ),
                        // SizedBox(
                        //   height: 10,
                        // ),
                        // Row(
                        //   children: [
                        //     Text(
                        //       'Storage:  ',
                        //       style: TextStyle(
                        //         color: Colors.white,
                        //         fontWeight: FontWeight.bold,
                        //         fontSize: 16,
                        //       ),
                        //     ),
                        //     Text(
                        //       '${snapshot.data['minimum_system_requirements']['storage']}',
                        //       maxLines: 2,
                        //       style: TextStyle(color: Colors.white),
                        //     ),
                        //   ],
                        // ),
                        CarouselSlider(
                          options: CarouselOptions(
                            height: 250,
                            aspectRatio: 16 / 9,
                            viewportFraction: 0.8,
                            initialPage: 0,
                            enableInfiniteScroll: true,
                            reverse: false,
                            autoPlay: true,
                            autoPlayInterval: Duration(seconds: 5),
                            autoPlayAnimationDuration:
                                Duration(milliseconds: 1000),
                            autoPlayCurve: Curves.fastOutSlowIn,
                            enlargeCenterPage: true,
                            enlargeFactor: 0.3,
                            scrollDirection: Axis.horizontal,
                          ),
                          items: [0, 1, 2].map((i) {
                            return Builder(
                              builder: (BuildContext context) {
                                return Container(
                                  child: Image(
                                      image: NetworkImage(
                                          '${snapshot.data['screenshots'][i]['image']}')),
                                );
                              },
                            );
                          }).toList(),
                        ),
                      ],
                    ),
                  ),
                );
              }
              return Padding(
                padding: const EdgeInsets.all(10.0),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Stack(
                        alignment: Alignment.bottomRight,
                        children: [
                          ShaderMask(
                            shaderCallback: (rect) {
                              return LinearGradient(
                                end: Alignment.bottomLeft,
                                colors: [
                                  MyColors().primaryColor,
                                  Colors.transparent
                                ],
                              ).createShader(Rect.fromLTRB(0, 0, 200, 200));
                            },
                            blendMode: BlendMode.dstIn,
                            child: Container(
                              height: 200,
                              clipBehavior: Clip.antiAliasWithSaveLayer,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Image(
                                image: NetworkImage(
                                  '${snapshot.data['thumbnail']}',
                                ),
                                fit: BoxFit.cover,
                                width: double.infinity,
                              ),
                            ),
                          ),
                          Row(
                            children: [
                              Spacer(),
                              Link(
                                target: LinkTarget.self,
                                uri: Uri.parse('${snapshot.data['game_url']}'),
                                builder: (context, followLink) {
                                  return InkWell(
                                    onTap: followLink,
                                    child: ElevatedButton(
                                      style: ButtonStyle(
                                          backgroundColor:
                                              MaterialStatePropertyAll(
                                                  MyColors()
                                                      .primaryColor
                                                      .withOpacity(0.7))),
                                      onPressed: followLink,
                                      child: Text('Game Website'),
                                    ),
                                  );
                                },
                              )
                            ],
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        children: [
                          SizedBox(
                            width: 150,
                            child: Text(
                              '${snapshot.data['title']}',
                              maxLines: 2,
                              style: GoogleFonts.acme(
                                color: Colors.white,
                                fontSize: 20,
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            '${snapshot.data['release_date']}',
                            style: TextStyle(color: Colors.white),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          CircleAvatar(
                            radius: 3,
                            backgroundColor: Colors.red,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            '${snapshot.data['genre']}',
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          Image(
                            image: AssetImage('assets/photos/system.png'),
                            height: 30,
                            width: 30,
                            color: MyColors().primaryColor,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            '${snapshot.data['platform']}',
                            style: TextStyle(color: Colors.white),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Row(
                        children: [
                          Image(
                            image: AssetImage('assets/photos/coding.png'),
                            height: 30,
                            width: 30,
                            color: MyColors().primaryColor,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            '${snapshot.data['developer']}',
                            style: TextStyle(color: Colors.white),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Row(
                        children: [
                          Image(
                            image: AssetImage('assets/photos/right.png'),
                            height: 30,
                            width: 30,
                            color: MyColors().primaryColor,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          SizedBox(
                              width: 330,
                              child: Text(
                                '${snapshot.data['publisher']}',
                                style: TextStyle(color: Colors.white),
                              ))
                        ],
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Text(
                        '${snapshot.data['description']}',
                        style: TextStyle(
                          color: Colors.grey[400],
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Row(
                        children: [
                          Container(
                            width: 40,
                            height: 1,
                            color: MyColors().primaryColor,
                          ),
                          SizedBox(
                            width: 2,
                          ),
                          Text(
                            'Minimum System Requirements',
                            style: TextStyle(color: MyColors().primaryColor),
                          ),
                          SizedBox(
                            width: 2,
                          ),
                          Container(
                            width: 119,
                            height: 1,
                            color: MyColors().primaryColor,
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          Text(
                            'Operating System:  ',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          if(snapshot.data['minimum_system_requirements']['os'] != null)
                            SizedBox(
                            width: 220,
                            child: Text(
                              '${snapshot.data['minimum_system_requirements']['os']}',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                          if(snapshot.data['minimum_system_requirements']['os'] == null)
                            SizedBox(
                              width: 220,
                              child: Text(
                                'Soon',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          Text(
                            'CPU:  ',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          if(snapshot.data['minimum_system_requirements']['processor'] != null)
                            Text(
                            '${snapshot.data['minimum_system_requirements']['processor']}',
                            style: TextStyle(color: Colors.white),
                          ),
                          if(snapshot.data['minimum_system_requirements']['processor'] == null)
                            SizedBox(
                              width: 220,
                              child: Text(
                                'Soon',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          Text(
                            'Memory:  ',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          if(snapshot.data['minimum_system_requirements']['memory'] != null)
                            Text(
                            '${snapshot.data['minimum_system_requirements']['memory']}',
                            style: TextStyle(color: Colors.white),
                          ),
                          if(snapshot.data['minimum_system_requirements']['memory'] == null)
                            SizedBox(
                              width: 220,
                              child: Text(
                                'Soon',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          Text(
                            'GPU:  ',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          if(snapshot.data['minimum_system_requirements']['graphics'] != null)
                            SizedBox(
                            width: 320,
                            child: Text(
                              '${snapshot.data['minimum_system_requirements']['graphics']}',
                              maxLines: 2,
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                          if(snapshot.data['minimum_system_requirements']['graphics'] == null)
                            SizedBox(
                              width: 220,
                              child: Text(
                                'Soon',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          Text(
                            'Storage:  ',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          if(snapshot.data['minimum_system_requirements']['storage'] != null)
                            Text(
                            '${snapshot.data['minimum_system_requirements']['storage']}',
                            maxLines: 2,
                            style: TextStyle(color: Colors.white),
                          ),
                          if(snapshot.data['minimum_system_requirements']['storage'] == null)
                            SizedBox(
                              width: 220,
                              child: Text(
                                'Soon',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                        ],
                      ),
                      CarouselSlider(
                        options: CarouselOptions(
                          height: 250,
                          aspectRatio: 16 / 9,
                          viewportFraction: 0.8,
                          initialPage: 0,
                          enableInfiniteScroll: true,
                          reverse: false,
                          autoPlay: true,
                          autoPlayInterval: Duration(seconds: 5),
                          autoPlayAnimationDuration:
                              Duration(milliseconds: 1000),
                          autoPlayCurve: Curves.fastOutSlowIn,
                          enlargeCenterPage: true,
                          enlargeFactor: 0.3,
                          scrollDirection: Axis.horizontal,
                        ),
                        items: [0, 1, 2].map((i) {
                          return Builder(
                            builder: (BuildContext context) {
                              return Container(
                                child: Image(
                                    image: NetworkImage(
                                        '${snapshot.data['screenshots'][i]['image']}')),
                              );
                            },
                          );
                        }).toList(),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }
}
