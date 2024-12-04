import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class LeaderboardScreen extends StatefulWidget {
  @override
  _LeaderboardScreenState createState() => _LeaderboardScreenState();
}

class _LeaderboardScreenState extends State<LeaderboardScreen> {
  Future<List<Map<String, dynamic>>> getAllScores() async {
    try {
      final querySnapshot = await FirebaseFirestore.instance
          .collection('quiz_scores')
          .orderBy('score', descending: true)
          .get();

      return querySnapshot.docs.map((doc) {
        return {
          'name': doc['name'],
          'score': doc['score'],
        };
      }).toList();
    } catch (e) {
      print('Error fetching all scores: $e');
      return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Leaderboard'),
        centerTitle: true,
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: getAllScores(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error loading scores'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No scores found'));
          }

          final scores = snapshot.data!;
          return Column(
            children: [
              // Top 3 Users
              Container(
                padding: EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 70),
                      child: _buildTopUser(scores, 1, Colors.grey.shade300),
                    ),
                    _buildTopUser(scores, 0, Colors.yellow),
                    Padding(
                      padding: const EdgeInsets.only(top: 70),
                      child: _buildTopUser(scores, 2, Colors.grey.shade500),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: scores.length - 3,
                  itemBuilder: (context, index) {
                    final user = scores[index + 3];
                    return ListTile(
                      leading: CircleAvatar(
                        child: Text('${index + 4}'),
                      ),
                      title: Text(user['name']),
                      trailing: Text('${user['score']}/10'),
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildTopUser(
      List<Map<String, dynamic>> scores, int index, Color crownColor) {
    if (index >= scores.length) return SizedBox.shrink();

    final user = scores[index];
    return Column(
      children: [
        Stack(
          alignment: Alignment.topCenter,
          children: [
            CircleAvatar(
              radius: 40,
              backgroundColor: Colors.teal.shade100,
              child: Text(
                user['name'][0], // أول حرف من اسم المستخدم
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
        SizedBox(height: 8),
        Text(
          user['name'],
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        Text('${user['score']}/10'),
      ],
    );
  }
}
