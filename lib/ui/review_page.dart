import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/constants/references.dart';
import 'package:restaurant_app/provider/restaurants_provider.dart';
import 'package:restaurant_app/widgets/platform_widget.dart';
import 'package:http/http.dart' as http;

class ReviewsPage extends StatefulWidget {
  static const String reviewsTitle = 'Review';

  const ReviewsPage({Key? key, required this.id}) : super(key: key);
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
      );

      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }

  Widget _buildAndroid(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(ReviewsPage.reviewsTitle),
      ),
      body: SingleChildScrollView(child: _buildList(context)),
    );
  }

  Widget _buildIos(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        middle: Text(ReviewsPage.reviewsTitle),
      ),
      child: _buildList(context),
    );
  }

  Widget _buildList(BuildContext context) {
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
                            Text(
                              review.review,
                              style: Theme.of(context).textTheme.labelLarge,
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
                        // Handle the submission of the review
                        String reviewText = reviewController.text;

                        if (reviewText.isNotEmpty) {
                          // Post the review to the API
                          bool success =
                              await postReview(reviewText, widget.id, 'Anonim');

                          if (success) {
                            // Update the state to trigger a reload of reviews
                            state.fetchDetailRestaurant(widget.id);

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
        } else {
          return const Text('null');
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
