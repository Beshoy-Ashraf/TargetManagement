import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class QuizSetupScreen extends StatefulWidget {
  const QuizSetupScreen({super.key});

  @override
  State<QuizSetupScreen> createState() => _QuizSetupScreenState();
}

class _QuizSetupScreenState extends State<QuizSetupScreen> {
  final TextEditingController _quizTitleController = TextEditingController();
  final List<QuestionInput> _questions = [];
  bool _isSaving = false;

  void _addQuestion() {
    setState(() {
      _questions.add(QuestionInput());
    });
  }

  Future<void> _saveQuiz() async {
    if (_quizTitleController.text.isEmpty || _questions.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please fill all fields")),
      );
      return;
    }

    // Validate all questions
    for (var question in _questions) {
      if (!question.isValid()) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Please fill all question fields")),
        );
        return;
      }
    }

    setState(() {
      _isSaving = true;
    });

    try {
      // Build the quiz data
      final quizData = {
        "title": _quizTitleController.text,
        "questions": _questions.map((q) => q.toMap()).toList(),
      };

      // Save to Firebase
      await FirebaseFirestore.instance.collection('quizzes').add(quizData);

      // Show success message
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Quiz saved successfully!")),
      );

      // Clear the form
      _quizTitleController.clear();
      setState(() {
        _questions.clear();
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error saving quiz: $e")),
      );
    } finally {
      setState(() {
        _isSaving = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Quiz Setup"),
      ),
      body: _isSaving
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextField(
                      controller: _quizTitleController,
                      decoration: const InputDecoration(
                        labelText: "Quiz Title",
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 16),
                    ListView.builder(
                      itemCount: _questions.length,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        return _questions[index];
                      },
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton.icon(
                      onPressed: _addQuestion,
                      icon: const Icon(Icons.add),
                      label: const Text("Add Question"),
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: _saveQuiz,
                      child: const Text("Save Quiz"),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}

class QuestionInput extends StatefulWidget {
  final TextEditingController questionController = TextEditingController();
  final List<TextEditingController> optionControllers =
      List.generate(4, (_) => TextEditingController());
  final ValueNotifier<int?> correctAnswerNotifier = ValueNotifier<int?>(null);

  QuestionInput({super.key});

  bool isValid() {
    return questionController.text.isNotEmpty &&
        optionControllers.every((controller) => controller.text.isNotEmpty) &&
        correctAnswerNotifier.value != null;
  }

  Map<String, dynamic> toMap() {
    return {
      "question": questionController.text,
      "options":
          optionControllers.map((controller) => controller.text).toList(),
      "correctAnswer": correctAnswerNotifier.value,
    };
  }

  @override
  State<QuestionInput> createState() => _QuestionInputState();
}

class _QuestionInputState extends State<QuestionInput> {
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: widget.questionController,
              decoration: const InputDecoration(
                labelText: "Question",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 8),
            ...List.generate(
              4,
              (index) => Padding(
                padding: const EdgeInsets.symmetric(vertical: 4.0),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: widget.optionControllers[index],
                        decoration: InputDecoration(
                          labelText: "Option ${index + 1}",
                          border: const OutlineInputBorder(),
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    ValueListenableBuilder<int?>(
                      valueListenable: widget.correctAnswerNotifier,
                      builder: (context, correctAnswer, _) {
                        return Radio<int>(
                          value: index,
                          groupValue: correctAnswer,
                          onChanged: (value) {
                            widget.correctAnswerNotifier.value = value;
                          },
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
