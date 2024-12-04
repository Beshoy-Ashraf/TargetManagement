import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class QuizScreen extends StatefulWidget {
  final UserName;
  const QuizScreen({super.key, this.UserName});

  @override
  State<QuizScreen> createState() => _QuizScreenState(UserName: UserName);
}

class _QuizScreenState extends State<QuizScreen> {
  List<Question> _questions = [];
  final Map<int, int> _selectedAnswers = {};
  bool _isLoading = true;
  int _remainingTime = 600; // Quiz duration in seconds (e.g., 5 minutes)
  Timer? _timer;
  final UserName;
  _QuizScreenState({this.UserName});

  @override
  void initState() {
    super.initState();
    _fetchQuestions();
    _startTimer();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  Future<void> _fetchQuestions() async {
    try {
      final querySnapshot =
          await FirebaseFirestore.instance.collection('quizzes').limit(1).get();

      if (querySnapshot.docs.isNotEmpty) {
        final quizDoc = querySnapshot.docs.first;
        final data = quizDoc.data();
        final questions = (data['questions'] as List<dynamic>)
            .map((q) => Question.fromMap(q))
            .toList();

        setState(() {
          _questions = questions;
          _isLoading = false;
        });
      } else {
        setState(() {
          _isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (_remainingTime > 0) {
          _remainingTime--;
        } else {
          _timer?.cancel();
          _autoSubmit();
        }
      });
    });
  }

  void _autoSubmit() {
    final score = _calculateScore();
    _saveScore(score, UserName);
  }

  int _calculateScore() {
    int score = 0;
    for (int i = 0; i < _questions.length; i++) {
      if (_selectedAnswers[i] == _questions[i].correctAnswer) {
        score++;
      }
    }
    return score;
  }

  void _saveScore(int score, String name) async {
    await FirebaseFirestore.instance.collection('quiz_scores').add({
      'name': name,
      'score': score,
      'total': _questions.length,
      'timestamp': FieldValue.serverTimestamp(),
    });

    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    final minutes = _remainingTime ~/ 60;
    final seconds = _remainingTime % 60;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          'remaining time : $minutes:${seconds.toString().padLeft(2, '0')}',
          style: const TextStyle(fontSize: 18),
        ),
        centerTitle: true,
        backgroundColor: Colors.grey,
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : Directionality(
              textDirection: TextDirection.rtl, // Set RTL for entire body
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [],
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: _questions.length,
                      itemBuilder: (context, index) {
                        final question = _questions[index];
                        return Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16.0, vertical: 8.0),
                          child: Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            elevation: 4,
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    question.question,
                                    style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    textDirection: TextDirection.rtl,
                                  ),
                                  const SizedBox(height: 12),
                                  ...List.generate(
                                    question.options.length,
                                    (optionIndex) => RadioListTile<int>(
                                      title: Text(
                                        question.options[optionIndex],
                                        textDirection: TextDirection.rtl,
                                      ),
                                      value: optionIndex,
                                      groupValue: _selectedAnswers[index],
                                      onChanged: (value) {
                                        setState(() {
                                          _selectedAnswers[index] = value!;
                                        });
                                      },
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
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ElevatedButton(
          onPressed: () {
            _timer?.cancel(); // Stop the timer
            final score = _calculateScore();
            _saveScore(score, UserName);
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.grey,
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
          ),
          child: const Text(
            "إرسال",
            style: TextStyle(fontSize: 18),
          ),
        ),
      ),
    );
  }
}

class Question {
  final String question;
  final List<String> options;
  final int correctAnswer;

  Question({
    required this.question,
    required this.options,
    required this.correctAnswer,
  });

  factory Question.fromMap(Map<String, dynamic> map) {
    return Question(
      question: map['question'],
      options: List<String>.from(map['options']),
      correctAnswer: map['correctAnswer'],
    );
  }
}
