import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DeleteOfferScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Delete Offers'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('offers')
            .orderBy('createdAt', descending: true)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return Center(child: Text('No offers available.'));
          } else {
            // Extract data from Firestore
            var offers = snapshot.data!.docs;

            return ListView.builder(
              itemCount: offers.length,
              itemBuilder: (context, index) {
                var offer = offers[index].data() as Map<String, dynamic>;
                return buildOfferItem(
                  context: context,
                  offerId: offers[index].id,
                  title: offer['title'],
                  description: offer['description'],
                  images: List<String>.from(offer['images']),
                );
              },
            );
          }
        },
      ),
    );
  }

  // بناء واجهة العرض لكل عرض
  Widget buildOfferItem({
    required BuildContext context,
    required String offerId,
    required String title,
    required String description,
    required List<String> images,
  }) {
    return Card(
      elevation: 8,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Text(
                title,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(height: 10),
            Text(
              description,
              textDirection: TextDirection.rtl,
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[600],
              ),
              textAlign: TextAlign.justify,
            ),
            SizedBox(height: 12),
            // عرض الصور إذا كانت موجودة
            if (images.isNotEmpty)
              SizedBox(
                height: 200,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: images.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.network(
                          images[index],
                          fit: BoxFit.cover,
                        ),
                      ),
                    );
                  },
                ),
              ),
            SizedBox(height: 10),
            // زر مسح العرض
            Align(
              alignment: Alignment.centerRight,
              child: IconButton(
                icon: Icon(Icons.delete, color: Colors.red),
                onPressed: () {
                  _deleteOffer(context, offerId);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _deleteOffer(BuildContext context, String offerId) async {
    try {
      await FirebaseFirestore.instance
          .collection('offers')
          .doc(offerId)
          .delete();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Offer deleted successfully')),
      );
    } catch (e) {
      print('Failed to delete offer: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to delete offer')),
      );
    }
  }
}
