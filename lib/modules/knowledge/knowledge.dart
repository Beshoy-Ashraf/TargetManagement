import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_file_downloader/flutter_file_downloader.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:target_manangment/layout/cubit/AppCubit.dart';
import 'package:target_manangment/layout/cubit/AppStates.dart';
import 'package:target_manangment/shared/constant/constant.dart';

class KnowledgeScreen extends StatefulWidget {
  final String title;
  KnowledgeScreen({required this.title});
  @override
  _KnowledgeScreenState createState() => _KnowledgeScreenState(title: title);
}

class _KnowledgeScreenState extends State<KnowledgeScreen> {
  double progress = 0;
  final String title;
  _KnowledgeScreenState({required this.title});
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<Appcubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var knowledgeList = Appcubit.get(context).knowladge;

        return Scaffold(
          appBar: AppBar(
            title: Text(title),
            centerTitle: true,
            backgroundColor: Colors.white,
          ),
          body: ConditionalBuilder(
            condition: knowledgeList.isNotEmpty,
            fallback: (context) => Center(child: CircularProgressIndicator()),
            builder: (context) {
              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: ListView.separated(
                  itemCount: knowledgeList.length,
                  separatorBuilder: (context, index) => SizedBox(height: 10),
                  itemBuilder: (context, index) {
                    var item = knowledgeList[index];
                    return buildKnowledgeItem(
                      context: context,
                      title: item.title,
                      subtitle: item.description,
                      url: item.pdf,
                    );
                  },
                ),
              );
            },
          ),
        );
      },
    );
  }

  Widget buildKnowledgeItem({
    required BuildContext context,
    required String title,
    required String subtitle,
    required String url,
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
              subtitle,
              textDirection: TextDirection.rtl,
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[600],
              ),
              textAlign: TextAlign.justify,
            ),
            SizedBox(height: 12),
            progress > 0
                ? LinearProgressIndicator(value: progress)
                : ElevatedButton.icon(
                    onPressed: () {
                      _downloadFile(url: url, title: title);
                    },
                    icon: Icon(Icons.picture_as_pdf, color: Colors.white),
                    label: Text('Download PDF',
                        style: TextStyle(color: Colors.white)),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: c,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
          ],
        ),
      ),
    );
  }

  void _downloadFile({required String url, required String title}) {
    FileDownloader.downloadFile(
      url: url,
      name: title,
      onDownloadCompleted: (filePath) {
        setState(() {
          progress = 0;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Downloaded: $filePath'),
            backgroundColor: Colors.green,
          ),
        );
      },
      onProgress: (name, value) {
        setState(() {
          progress = value / 100;
        });
      },
    );
  }
}
