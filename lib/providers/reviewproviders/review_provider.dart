import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Review {
  final String review;
  final User? user;
  final String rating;
  final String createdAt;

  Review(
      {required this.review,
      this.user,
      required this.rating,
      required this.createdAt});

  factory Review.fromJson(Map<String, dynamic> json) {
    return Review(
      review: json['review'],
      user: json['user'] != null ? User.fromJson(json['user']) : null,
      rating: json['rating'],
      createdAt: json['createdAt'],
    );
  }
}

class User {
  final String id;
  final String name;
  final String email;

  User({required this.id, required this.name, required this.email});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['_id'],
      name: json['name'],
      email: json['email'],
    );
  }
}

class ReviewProvider with ChangeNotifier {
  List<Review> _reviews = [];
  int _totalReviews = 0;
  double _averageRating = 0.0;
  bool _isLoading = true;

  List<Review> get reviews => _reviews;
  int get totalReviews => _totalReviews;
  double get averageRating => _averageRating;
  bool get isLoading => _isLoading;

  Future<void> fetchReviews(String id) async {
    final url =
        Uri.parse('https://backmern.picknow.in/api/product/$id/reviews');

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);

        _reviews = (jsonResponse['reviews'] as List)
            .map((r) => Review.fromJson(r))
            .toList();
        _totalReviews = jsonResponse['totalReviews'];
        _averageRating = double.parse(jsonResponse['averageRating']);

        _isLoading = false;
        notifyListeners();
      } else {
        throw Exception('Failed to load reviews');
      }
    } catch (error) {
      debugPrint("Error fetching reviews: $error");
    }
  }
}
