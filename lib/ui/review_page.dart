import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:resto_mana/constants/references.dart';
import 'package:resto_mana/provider/restaurants_provider.dart';
import 'package:resto_mana/widgets/platform_widget.dart';
import 'package:http/http.dart' as http;

class ReviewsPage extends StatefulWidget {
  static const String reviewsTitle = 'Review';

  const ReviewsPage({super.key, required this.id});
  final String id;

  @override
  State<ReviewsPage> createState() => _ReviewsPageState();
}

class _ReviewsPageState extends State<ReviewsPage> {
  TextEditingController reviewController = TextEditingController();

  Future<bool> postReview(String reviewText, String id, String name) async {
    const String apiUrl = '$baseUrl/review';

    Map<String, String> headers = {
      'Content-Type': 'application/json',
    };

    Map<String, String> reviewData = {
      'id': id,
      'name': name,
      'review': reviewText,
    };

    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: headers,
        body: json.encode(reviewData),
        encoding: const Utf8Codec(),
      );
      if (response.statusCode == 201) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }

  Widget _buildAndroid(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    ScrollController sc = ScrollController();
    return Scaffold(
      appBar: AppBar(
        title: const Text(ReviewsPage.reviewsTitle),
      ),
      body: Platform.isAndroid
          ? SingleChildScrollView(
              controller: sc,
              child: screenWidth > limitWidth ? _buildList(context, sc) : null)
          : SingleChildScrollView(
              child: screenWidth > limitWidth ? _buildList(context, sc) : null,
            ),
    );
  }

  Widget _buildIos(BuildContext context) {
    ScrollController sc = ScrollController();
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        middle: Text(ReviewsPage.reviewsTitle),
      ),
      child: _buildList(context, sc),
    );
  }

  Widget _buildList(BuildContext context, ScrollController sc) {
    const String imgPath =
        "https://cdn.pixabay.com/photo/2018/11/13/21/43/avatar-3814049_1280.png";
    return Consumer<DetailRestaurantsProvider>(
      builder: (context, state, _) {
        if (state.state == ResultState.loading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state.state == ResultState.hasData) {
          var reviews = state.result.restaurant.customerReviews;
          return Column(
            children: [
              ListView.builder(
                controller: Platform.isAndroid || Platform.isIOS ? sc : null,
                shrinkWrap: true,
                itemCount: reviews.length,
                itemBuilder: (context, index) {
                  var review = reviews[index];
                  return ListTile(
                    tileColor: Theme.of(context).listTileTheme.tileColor,
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 16.0,
                      vertical: 8.0,
                    ),
                    leading: Image.network(
                      imgPath,
                      width: 100,
                      fit: BoxFit.cover,
                    ),
                    title: Text(
                      review.name,
                      style: Theme.of(context).textTheme.labelLarge,
                    ),
                    subtitle: Column(
                      children: [
                        Row(
                          children: [
                            const Icon(
                              Icons.calendar_month,
                              size: 12,
                            ),
                            const SizedBox(width: 3),
                            Text(review.date,
                                style: const TextStyle(fontSize: 12)),
                          ],
                        ),
                        Row(
                          children: [
                            SizedBox(
                              width: MediaQuery.of(context).size.width - 150,
                              child: Text(
                                review.review,
                                style: Theme.of(context).textTheme.labelLarge,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 4,
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  );
                },
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Your Review',
                      style: TextStyle(
                          fontSize: 18.0, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8.0),
                    TextField(
                      controller: reviewController,
                      maxLines: 5,
                      decoration: const InputDecoration(
                        hintText: 'Write your review here...',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 16.0),
                    ElevatedButton(
                      onPressed: () async {
                        String reviewText = reviewController.text;

                        if (reviewText.isNotEmpty) {
                          bool success =
                              await postReview(reviewText, widget.id, 'Anonim');

                          if (success) {
                            state.fetchDetailRestaurant(widget.id);

                            reviewController.clear();
                            // ignore: use_build_context_synchronously
                            ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content:
                                        Text('Review posted successfully')));
                          } else {
                            // ignore: use_build_context_synchronously
                            ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content:
                                        Text('Failed to post the review')));
                          }
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text(
                                      'Please enter a review before posting')));
                        }
                      },
                      child: const Text('Post Review'),
                    ),
                  ],
                ),
              ),
            ],
          );
        } else if (state.state == ResultState.noData) {
          return Center(
            child: Material(
              child: Column(
                children: [
                  const SizedBox(
                    height: 200,
                  ),
                  Lottie.asset('assets/no_data.json'),
                  const Text("There is no data from server!"),
                ],
              ),
            ),
          );
        } else if (state.state == ResultState.error) {
          return Center(
            child: Material(
              child: Column(
                children: [
                  const SizedBox(
                    height: 200,
                  ),
                  Lottie.asset('assets/network_error.json'),
                  const Text("Check your connection or server status!"),
                ],
              ),
            ),
          );
        } else {
          return Center(
            child: Material(
              child: Column(
                children: [
                  const SizedBox(
                    height: 200,
                  ),
                  Lottie.asset('assets/network_error.json'),
                  const Text("Unknown Error"),
                ],
              ),
            ),
          );
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return PlatformWidget(
      androidBuilder: _buildAndroid,
      iosBuilder: _buildIos,
    );
  }
}
