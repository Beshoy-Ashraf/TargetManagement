import 'package:flutter/material.dart';
import 'package:flutter_file_downloader/flutter_file_downloader.dart';

class KPIAndAward extends StatefulWidget {
  const KPIAndAward({super.key});

  @override
  State<KPIAndAward> createState() => _KPIAndAwardState();
}

class _KPIAndAwardState extends State<KPIAndAward> {
  @override
  Widget build(BuildContext context) {
    double progress = 0;
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 50, left: 20, right: 20),
        child: Container(
          width: double.infinity,
          child: Column(
            children: [
              Expanded(
                child: ListView.separated(
                  itemBuilder: (context, index) {
                    return itemBild(
                        context: context,
                        progress: progress,
                        title: 'Kpi ',
                        subtitle:
                            'modifay the kpi to be more clear and easy to understand',
                        url:
                            'https://www.w3.org/WAI/ER/tests/xhtml/testfiles/resources/pdf/dummy.pdf');
                  },
                  separatorBuilder: (context, index) {
                    return SizedBox(
                      height: 10,
                    );
                  },
                  itemCount: 5,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget itemBild({
    required BuildContext context,
    required double progress,
    required String title,
    required String subtitle,
    required String url,
  }) {
    return Card(
      color: Theme.of(context).cardTheme.color,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      elevation: 10,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Container(
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: double.infinity,
                child: Column(
                  children: [
                    Text(
                      title,
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.w700),
                    ),
                  ],
                ),
              ),
              Text(
                subtitle,
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.w300),
              ),
              SizedBox(
                height: 10,
              ),
              progress > 0
                  ? LinearProgressIndicator(
                      value: progress,
                    )
                  : InkWell(
                      onTap: () {
                        FileDownloader.downloadFile(
                          url: url,
                          name: title,
                          onDownloadCompleted: (value) {
                            print('Downloaded$value');
                            progress = 0;
                          },
                          onProgress: (name, value) {
                            progress = value;
                            setState(() {});
                          },
                        );
                      },
                      child: Card(
                        color: Theme.of(context).cardTheme.color,
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        elevation: 10,
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Container(
                            width: double.infinity,
                            child: Row(
                              children: [
                                Icon(
                                  Icons.picture_as_pdf,
                                  color: Colors.red,
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  'pdf',
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w700),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
