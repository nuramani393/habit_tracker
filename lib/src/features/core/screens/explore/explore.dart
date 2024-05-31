import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:habit_tracker/src/common_widgets/bottomNavBarWidget.dart';
import 'package:habit_tracker/src/constants/colors.dart';
import 'package:habit_tracker/src/features/core/controllers/habit_controller.dart';
import 'package:habit_tracker/src/features/core/screens/dashboard/dashboard.dart';
import 'package:habit_tracker/src/features/core/screens/explore/video_Details.dart';
import 'package:habit_tracker/src/features/core/screens/habits/AddHabitPage.dart';
import 'package:habit_tracker/src/features/core/screens/settings/settings.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:habit_tracker/src/features/core/screens/explore/video_model.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';

class Explore extends StatefulWidget {
  const Explore({super.key});

  @override
  State<Explore> createState() => _ExploreState();
}

class _ExploreState extends State<Explore> {
  final videoUrls = [
    'https://www.youtube.com/watch?v=Ej5GTNpNjmw&t=21s&pp=ygUTZ29vZCBoYWJpdHMgaW5zaWxhbQ%3D%3D',
    'https://www.youtube.com/watch?v=hEjcSy2sQ98&pp=ygUTZ29vZCBoYWJpdHMgaW5zaWxhbQ%3D%3D',
    'https://www.youtube.com/watch?v=Uy0qFMAW6qw&pp=ygUTZ29vZCBoYWJpdHMgaW5zaWxhbQ%3D%3D',
    'https://www.youtube.com/watch?v=7QWxKyfeanE&pp=ygUTZ29vZCBoYWJpdHMgaW5zaWxhbQ%3D%3D',
    'https://www.youtube.com/watch?v=Gbu6FKzjTaE&pp=ygUTZ29vZCBoYWJpdHMgaW5zaWxhbQ%3D%3D',
    'https://www.youtube.com/watch?v=1AyWJWv5H90&pp=ygUTZ29vZCBoYWJpdHMgaW5zaWxhbQ%3D%3D',
    'https://www.youtube.com/watch?v=P6t4hemfa-A'
  ];

  late YoutubeExplode yt;
  List<Map<String, String>> videoDataList = [];
  bool isLoading = true;
  bool hasError = false;
  String errorMessage = '';

  @override
  void initState() {
    super.initState();
    yt = YoutubeExplode();
    fetchAllVideoMetadata();
  }

  Future<void> fetchAllVideoMetadata() async {
    try {
      print("Fetching video metadata...");
      List<Map<String, String>> fetchedData = [];
      for (var videoUrl in videoUrls) {
        final videoId = YoutubePlayer.convertUrlToId(videoUrl)!;
        print("Fetching metadata for video ID: $videoId");
        final video = await yt.videos.get(videoId);
        fetchedData.add({
          'title': video.title,
          'author': video.author,
          'videoId': videoId,
          'thumbnailUrl': YoutubePlayer.getThumbnail(videoId: videoId),
        });
      }
      setState(() {
        videoDataList = fetchedData;
        isLoading = false;
      });
      print("Fetched all video metadata successfully.");
    } catch (e) {
      print("Error fetching video metadata: $e");
      setState(() {
        hasError = true;
        errorMessage = e.toString();
        isLoading = false;
      });
    }
  }

  String capitalizeEachWord(String input) {
    return input
        .split(' ')
        .map((word) => word.isNotEmpty
            ? '${word[0].toUpperCase()}${word.substring(1).toLowerCase()}'
            : '')
        .join(' ');
  }

  @override
  void dispose() {
    yt.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      appBar: appbarSettings(context),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : hasError
              ? Center(child: Text('Error: $errorMessage'))
              : Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      search(context),
                      SizedBox(height: 20),
                      Expanded(
                        child: ListView.builder(
                          itemCount: videoDataList.length,
                          itemBuilder: (context, index) {
                            final videoData = videoDataList[index];
                            return GestureDetector(
                              onTap: () {
                                Get.to(() => VideoDetailsPage(
                                      videoData: videoData,
                                    ));
                              },
                              child: Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(25, 10, 25, 0),
                                child: Container(
                                  padding: EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: darkColor,
                                  ),
                                  child: Row(
                                    children: [
                                      SizedBox(
                                        width: 150,
                                        height: 100,
                                        child: Image.network(
                                          videoData['thumbnailUrl']!,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      const SizedBox(width: 8.0),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              capitalizeEachWord(
                                                  videoData['title']!
                                                      .toString()),
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .titleMedium
                                                  ?.copyWith(color: whiteColor),
                                              maxLines: 2,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                            const SizedBox(height: 8.0),
                                            Text(
                                              videoData['author']!,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .labelSmall
                                                  ?.copyWith(
                                                      color: whiteColor,
                                                      fontWeight:
                                                          FontWeight.w300),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
      bottomNavigationBar: CustomBottomNavBar(selectedIndex: 1),
    );
  }

  AppBar appbarSettings(BuildContext context) {
    return AppBar(
      backgroundColor: bgColor,
      elevation: Theme.of(context).appBarTheme.elevation ?? 0,
      automaticallyImplyLeading: false,
      centerTitle: true,
      title: Padding(
        padding: const EdgeInsets.fromLTRB(15, 30, 15, 0),
        child: Text(
          "Explore",
          style: Theme.of(context).textTheme.headlineLarge,
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  Padding search(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(30, 30, 30, 0),
      child: TextField(
        style: Theme.of(context).textTheme.headlineMedium!.copyWith(
              color: darkColor,
              fontWeight: FontWeight.w400,
            ),
        decoration: InputDecoration(
          prefixIcon: Icon(
            Icons.search,
            color: darkColor,
            size: 30,
          ),
          hintText: 'Search',
          hintStyle: TextStyle(color: darkColor),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
            borderSide: BorderSide.none,
          ),
          filled: true,
          fillColor: midColor,
          contentPadding: EdgeInsets.symmetric(vertical: 15.0),
        ),
      ),
    );
  }
}
