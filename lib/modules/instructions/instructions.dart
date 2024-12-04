import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class instructions extends StatefulWidget {
  @override
  _instructionsState createState() => _instructionsState();
}

class _instructionsState extends State<instructions> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  List<File> _imageFiles = [];

  Future<void> _pickImages() async {
    final picker = ImagePicker();
    final pickedFiles = await picker.pickMultiImage();
    if (pickedFiles != null) {
      setState(() {
        _imageFiles = pickedFiles.map((file) => File(file.path!)).toList();
      });
    }
  }

  Future<List<String>> _uploadImages(List<File> images) async {
    List<String> imageUrls = [];

    for (var image in images) {
      try {
        String fileName = DateTime.now().millisecondsSinceEpoch.toString();
        Reference storageRef =
            FirebaseStorage.instance.ref().child('instructions/$fileName');
        UploadTask uploadTask = storageRef.putFile(image);
        TaskSnapshot taskSnapshot = await uploadTask;
        String imageUrl = await taskSnapshot.ref.getDownloadURL();
        imageUrls.add(imageUrl);
      } catch (e) {
        print('Failed to upload image: $e');
      }
    }
    return imageUrls;
  }

  Future<void> _submitinstruction() async {
    String title = _titleController.text;
    String description = _descriptionController.text;

    if (title.isEmpty || description.isEmpty || _imageFiles.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please fill in all fields and upload images')),
      );
      return;
    }

    // رفع الصور
    List<String> imageUrls = await _uploadImages(_imageFiles);

    // تخزين البيانات في Firebase Firestore
    try {
      await FirebaseFirestore.instance.collection('instructions').add({
        'title': title,
        'description': description,
        'images': imageUrls,
        'createdAt': Timestamp.now(),
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('instruction added successfully')),
      );
      Navigator.pop(context); // العودة بعد نشر العرض
    } catch (e) {
      print('Failed to add instruction: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to add instruction')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add instruction'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextField(
                controller: _titleController,
                decoration: InputDecoration(
                  labelText: 'Title',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 10),
              TextField(
                controller: _descriptionController,
                decoration: InputDecoration(
                  labelText: 'Description',
                  border: OutlineInputBorder(),
                ),
                maxLines: 4,
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _pickImages,
                child: Text('Pick Images'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepOrange,
                ),
              ),
              SizedBox(height: 20),
              if (_imageFiles.isNotEmpty)
                GridView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                  ),
                  itemCount: _imageFiles.length,
                  itemBuilder: (context, index) {
                    return Image.file(
                      _imageFiles[index],
                      fit: BoxFit.cover,
                    );
                  },
                ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _submitinstruction,
                child: Text('Submit instruction'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepOrange,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
