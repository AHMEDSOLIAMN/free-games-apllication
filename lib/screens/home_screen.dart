// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, sized_box_for_whitespace

import 'package:flutter/material.dart';
import 'package:free_to_game/core/app_colors.dart';
import 'package:free_to_game/providers/app_provider.dart';
import 'package:free_to_game/screens/browser_games_see_more_screen.dart';
import 'package:free_to_game/screens/categories_games_see_more_screen.dart';
import 'package:free_to_game/screens/game_details_screen.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'all_games_see_more_screen.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ApplicationProvider>(
      builder: (context, controller, child) {
        return Scaffold(
          appBar: AppBar(
            title: Text(
              'FreeToGame',
              style: GoogleFonts.acme(),
            ),
            centerTitle: true,
            actions: [
              // IconButton(
              //   onPressed: () {
              //     controller.changeAppTheme();
              //   },
              //   icon: controller.isDark
              //       ? Icon(
              //           Icons.light_mode,
              //         )
              //       : Icon(
              //           Icons.dark_mode,
              //         ),
              // ),
            ],
          ),
          body: FutureBuilder(
            future: Future.wait([
              controller.getAllGamesData(),
              controller.getBrowserGamesData(),
              controller.getGamesByCategoriesData(categories: 'racing'),
              controller.getGamesByCategoriesData(categories: 'open-world'),
              controller.getGamesByCategoriesData(categories: 'battle-royale'),
              controller.getGamesByCategoriesData(categories: 'zombie'),
            ]),
            builder: (context, snapshot) {
              List? data = snapshot.data;
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
                padding: const EdgeInsets.only(
                  top: 15,
                  bottom: 15,
                  left: 10,
                  right: 10,
                ),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      // ShaderMask(
                      //   shaderCallback: (rect) {
                      //     return LinearGradient(
                      //       begin: Alignment.topCenter,
                      //       end: Alignment.bottomCenter,
                      //       colors: [Colors.black, Colors.transparent],
                      //     ).createShader(
                      //         Rect.fromLTRB(0, 0, rect.width, rect.height));
                      //   },
                      //   blendMode: BlendMode.dstIn,
                      //   child: Container(
                      //     clipBehavior: Clip.antiAliasWithSaveLayer,
                      //     decoration: BoxDecoration(
                      //       borderRadius: BorderRadius.circular(10),
                      //     ),
                      //     child: Stack(
                      //       alignment: Alignment.center,
                      //       children: [
                      //         Image(
                      //           image: AssetImage(
                      //               'assets/photos/shoulder-view-woman-streaming-first-person-shooter-doing-victory-hand-gesture-after-win-tournament-african-american-gamer-girl-surprised-after-winning-online-competition-gaming-pc.jpg'),
                      //         ),
                      //         Text(
                      //           'Explore the best free games',
                      //           style: GoogleFonts.acme(
                      //             color: Colors.white,
                      //             fontWeight: FontWeight.bold,
                      //             fontSize: 24,
                      //           ),
                      //         )
                      //       ],
                      //     ),
                      //   ),
                      // ),
                      Container(
                        height: 200,
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            Image(
                              image: AssetImage(
                                'assets/photos/gaming-setup-with-controller-headphones.jpg',
                              ),
                              fit: BoxFit.cover,
                              width: double.infinity,
                            ),
                            Container(
                              color: Colors.indigo.withOpacity(0.5),
                              height: 250,
                              width: double.infinity,
                            ),
                            Text(
                              'Explore the best free games',
                              style: GoogleFonts.acme(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 26,
                              ),
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Row(
                        children: [
                          Text(
                            'Free Games',
                            style: GoogleFonts.acme(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Spacer(),
                          InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => AllGamesSeeMoreScreen(),
                                ),
                              );
                            },
                            child: Row(
                              children: [
                                Text(
                                  'See All Games',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                  ),
                                ),
                                Icon(
                                  Icons.keyboard_arrow_right,
                                  color: Colors.white,
                                  size: 22,
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      SizedBox(
                        height: 171,
                        child: ListView.separated(
                          // itemScrollController: itemScrollController,
                          physics: ClampingScrollPhysics(),
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) {
                            return InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => GameDetailsScreen(
                                      gameId: snapshot.data![0][index]['id'],
                                    ),
                                  ),
                                );
                              },
                              child: Card(
                                clipBehavior: Clip.antiAliasWithSaveLayer,
                                elevation: 5,
                                margin: EdgeInsets.zero,
                                color: MyColors().cardColor,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10)),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Image(
                                      image: NetworkImage(
                                          '${snapshot.data![0][index]['thumbnail']}'),
                                      height: 140,
                                      width: 230,
                                      fit: BoxFit.fill,
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(
                                            left: 5,
                                          ),
                                          child: SizedBox(
                                            width: 165,
                                            child: Text(
                                              '${snapshot.data![0][index]['title']}',
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                              style: GoogleFonts.acme(
                                                color: Colors.white,
                                                fontSize: 16,
                                              ),
                                            ),
                                          ),
                                        ),
                                        // SizedBox(
                                        //   width: 45,
                                        // ),
                                        Container(
                                          height: 20,
                                          width: 45,
                                          decoration: BoxDecoration(
                                              color: MyColors().primaryColor,
                                              borderRadius:
                                                  BorderRadius.circular(5)),
                                          child: Center(
                                            child: Text(
                                              'Free',
                                              style: TextStyle(
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                          separatorBuilder: (context, index) => SizedBox(
                            width: 10,
                          ),
                          itemCount: 15,
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Container(
                        height: 1,
                        width: double.infinity,
                        color: MyColors().primaryColor,
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Row(
                        children: [
                          Text(
                            'Free Browser  Games',
                            style: GoogleFonts.acme(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Spacer(),
                          InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      BrowserGamesSeeMoreScreen(),
                                ),
                              );
                            },
                            child: Row(
                              children: [
                                Text(
                                  'See All Games',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                  ),
                                ),
                                Icon(
                                  Icons.keyboard_arrow_right,
                                  color: Colors.white,
                                  size: 22,
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      SizedBox(
                        height: 171,
                        child: ListView.separated(
                          physics: BouncingScrollPhysics(),
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) {
                            return InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => GameDetailsScreen(
                                      gameId: snapshot.data![1][index]['id'],
                                    ),
                                  ),
                                );
                              },
                              child: Card(
                                clipBehavior: Clip.antiAliasWithSaveLayer,
                                elevation: 5,
                                margin: EdgeInsets.zero,
                                color: MyColors().cardColor,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10)),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Image(
                                      image: NetworkImage(
                                          '${snapshot.data![1][index]['thumbnail']}'),
                                      height: 140,
                                      width: 230,
                                      fit: BoxFit.fill,
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(
                                            left: 5,
                                          ),
                                          child: SizedBox(
                                            width: 165,
                                            child: Text(
                                              '${snapshot.data![1][index]['title']}',
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                              style: GoogleFonts.acme(
                                                color: Colors.white,
                                                fontSize: 16,
                                              ),
                                            ),
                                          ),
                                        ),
                                        // SizedBox(
                                        //   width: 45,
                                        // ),
                                        Container(
                                          height: 20,
                                          width: 45,
                                          decoration: BoxDecoration(
                                              color: MyColors().primaryColor,
                                              borderRadius:
                                                  BorderRadius.circular(5)),
                                          child: Center(
                                            child: Text(
                                              'Free',
                                              style: TextStyle(
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                          separatorBuilder: (context, index) => SizedBox(
                            width: 10,
                          ),
                          itemCount: 15,
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Container(
                        height: 1,
                        width: double.infinity,
                        color: MyColors().primaryColor,
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Row(
                        children: [
                          Text(
                            'Free Racing  Games',
                            style: GoogleFonts.acme(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Spacer(),
                          InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      CategoriesGamesSeeMoreScreen(
                                    categories: 'racing',
                                    title: 'Free Racing Games',
                                  ),
                                ),
                              );
                            },
                            child: Row(
                              children: [
                                Text(
                                  'See All Games',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                  ),
                                ),
                                Icon(
                                  Icons.keyboard_arrow_right,
                                  color: Colors.white,
                                  size: 22,
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      SizedBox(
                        height: 171,
                        child: ListView.separated(
                          physics: BouncingScrollPhysics(),
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) {
                            return InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => GameDetailsScreen(
                                      gameId: snapshot.data![2][index]['id'],
                                    ),
                                  ),
                                );
                              },
                              child: Card(
                                clipBehavior: Clip.antiAliasWithSaveLayer,
                                elevation: 5,
                                margin: EdgeInsets.zero,
                                color: MyColors().cardColor,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10)),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Image(
                                      image: NetworkImage(
                                          '${data![2][index]['thumbnail']}'),
                                      height: 140,
                                      width: 230,
                                      fit: BoxFit.fill,
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(
                                            left: 5,
                                          ),
                                          child: SizedBox(
                                            width: 165,
                                            child: Text(
                                              '${data![2][index]['title']}',
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                              style: GoogleFonts.acme(
                                                color: Colors.white,
                                                fontSize: 16,
                                              ),
                                            ),
                                          ),
                                        ),
                                        // SizedBox(
                                        //   width: 45,
                                        // ),
                                        Container(
                                          height: 20,
                                          width: 45,
                                          decoration: BoxDecoration(
                                              color: MyColors().primaryColor,
                                              borderRadius:
                                                  BorderRadius.circular(5)),
                                          child: Center(
                                            child: Text(
                                              'Free',
                                              style: TextStyle(
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                          separatorBuilder: (context, index) => SizedBox(
                            width: 10,
                          ),
                          itemCount: data![2].length,
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      // ShaderMask(
                      //   shaderCallback: (rect) {
                      //     return LinearGradient(
                      //       begin: Alignment.topCenter,
                      //       end: Alignment.bottomCenter,
                      //       colors: [Colors.black, Colors.transparent],
                      //     ).createShader(
                      //         Rect.fromLTRB(0, 0, rect.width, rect.height));
                      //   },
                      //   blendMode: BlendMode.dstIn,
                      //   child:
                      // ),
                      Container(
                        height: 200,
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            Image(
                              image: AssetImage(
                                  'assets/photos/content-creator-playing-video-games-tournament-computer-celebrating-win-female-player-winning-action-gaming-championship-having-fun-with-online-gameplay-competition-pc.jpg'),
                              fit: BoxFit.cover,
                              width: double.infinity,
                            ),
                            Container(
                              color: Colors.indigo.withOpacity(0.5),
                              height: 250,
                              width: double.infinity,
                            ),
                            Text(
                              'More different games',
                              style: GoogleFonts.acme(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 26,
                              ),
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Row(
                        children: [
                          Text(
                            'Free Open-World  Games',
                            style: GoogleFonts.acme(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Spacer(),
                          InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      CategoriesGamesSeeMoreScreen(
                                    categories: 'open-world',
                                    title: 'Free Open-World Games',
                                  ),
                                ),
                              );
                            },
                            child: Row(
                              children: [
                                Text(
                                  'See All Games',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                  ),
                                ),
                                Icon(
                                  Icons.keyboard_arrow_right,
                                  color: Colors.white,
                                  size: 22,
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      SizedBox(
                        height: 171,
                        child: ListView.separated(
                          physics: BouncingScrollPhysics(),
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) {
                            return InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => GameDetailsScreen(
                                      gameId: snapshot.data![3][index]['id'],
                                    ),
                                  ),
                                );
                              },
                              child: Card(
                                clipBehavior: Clip.antiAliasWithSaveLayer,
                                elevation: 5,
                                margin: EdgeInsets.zero,
                                color: MyColors().cardColor,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10)),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Image(
                                      image: NetworkImage(
                                          '${data[3][index]['thumbnail']}'),
                                      height: 140,
                                      width: 230,
                                      fit: BoxFit.fill,
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(
                                            left: 5,
                                          ),
                                          child: SizedBox(
                                            width: 165,
                                            child: Text(
                                              '${data[3][index]['title']}',
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                              style: GoogleFonts.acme(
                                                color: Colors.white,
                                                fontSize: 16,
                                              ),
                                            ),
                                          ),
                                        ),
                                        // SizedBox(
                                        //   width: 45,
                                        // ),
                                        Container(
                                          height: 20,
                                          width: 45,
                                          decoration: BoxDecoration(
                                              color: MyColors().primaryColor,
                                              borderRadius:
                                                  BorderRadius.circular(5)),
                                          child: Center(
                                            child: Text(
                                              'Free',
                                              style: TextStyle(
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                          separatorBuilder: (context, index) => SizedBox(
                            width: 10,
                          ),
                          itemCount: 15,
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Container(
                        height: 1,
                        width: double.infinity,
                        color: MyColors().primaryColor,
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Row(
                        children: [
                          Text(
                            'Free Battle-Royale Games',
                            style: GoogleFonts.acme(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Spacer(),
                          InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      CategoriesGamesSeeMoreScreen(
                                    categories: 'battle-royale',
                                    title: 'Free Battle-Royale Games',
                                  ),
                                ),
                              );
                            },
                            child: Row(
                              children: [
                                Text(
                                  'See All Games',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                  ),
                                ),
                                Icon(
                                  Icons.keyboard_arrow_right,
                                  color: Colors.white,
                                  size: 22,
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      SizedBox(
                        height: 171,
                        child: ListView.separated(
                          physics: BouncingScrollPhysics(),
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) {
                            return InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => GameDetailsScreen(
                                      gameId: snapshot.data![4][index]['id'],
                                    ),
                                  ),
                                );
                              },
                              child: Card(
                                clipBehavior: Clip.antiAliasWithSaveLayer,
                                elevation: 5,
                                margin: EdgeInsets.zero,
                                color: MyColors().cardColor,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10)),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Image(
                                      image: NetworkImage(
                                          '${data[4][index]['thumbnail']}'),
                                      height: 140,
                                      width: 230,
                                      fit: BoxFit.fill,
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(
                                            left: 5,
                                          ),
                                          child: SizedBox(
                                            width: 165,
                                            child: Text(
                                              '${data[4][index]['title']}',
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                              style: GoogleFonts.acme(
                                                color: Colors.white,
                                                fontSize: 16,
                                              ),
                                            ),
                                          ),
                                        ),
                                        // SizedBox(
                                        //   width: 45,
                                        // ),
                                        Container(
                                          height: 20,
                                          width: 45,
                                          decoration: BoxDecoration(
                                              color: MyColors().primaryColor,
                                              borderRadius:
                                                  BorderRadius.circular(5)),
                                          child: Center(
                                            child: Text(
                                              'Free',
                                              style: TextStyle(
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                          separatorBuilder: (context, index) => SizedBox(
                            width: 10,
                          ),
                          itemCount: 15,
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Container(
                        height: 1,
                        width: double.infinity,
                        color: MyColors().primaryColor,
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Row(
                        children: [
                          Text(
                            'Free Zombie Games',
                            style: GoogleFonts.acme(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Spacer(),
                          InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      CategoriesGamesSeeMoreScreen(
                                    categories: 'zombie',
                                    title: 'Free Zombie Games',
                                  ),
                                ),
                              );
                            },
                            child: Row(
                              children: [
                                Text(
                                  'See All Games',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                  ),
                                ),
                                Icon(
                                  Icons.keyboard_arrow_right,
                                  color: Colors.white,
                                  size: 22,
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      SizedBox(
                        height: 171,
                        child: ListView.separated(
                          physics: BouncingScrollPhysics(),
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) {
                            return InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => GameDetailsScreen(
                                      gameId: snapshot.data![5][index]['id'],
                                    ),
                                  ),
                                );
                              },
                              child: Card(
                                clipBehavior: Clip.antiAliasWithSaveLayer,
                                elevation: 5,
                                margin: EdgeInsets.zero,
                                color: MyColors().cardColor,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10)),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Image(
                                      image: NetworkImage(
                                          '${data[5][index]['thumbnail']}'),
                                      height: 140,
                                      width: 230,
                                      fit: BoxFit.fill,
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(
                                            left: 5,
                                          ),
                                          child: SizedBox(
                                            width: 165,
                                            child: Text(
                                              '${data[5][index]['title']}',
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                              style: GoogleFonts.acme(
                                                color: Colors.white,
                                                fontSize: 16,
                                              ),
                                            ),
                                          ),
                                        ),
                                        // SizedBox(
                                        //   width: 45,
                                        // ),
                                        Container(
                                          height: 20,
                                          width: 45,
                                          decoration: BoxDecoration(
                                              color: MyColors().primaryColor,
                                              borderRadius:
                                                  BorderRadius.circular(5)),
                                          child: Center(
                                            child: Text(
                                              'Free',
                                              style: TextStyle(
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                          separatorBuilder: (context, index) => SizedBox(
                            width: 10,
                          ),
                          itemCount: 15,
                        ),
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
