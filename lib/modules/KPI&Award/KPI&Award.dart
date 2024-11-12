import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_file_downloader/flutter_file_downloader.dart';
import 'package:target_manangment/layout/cubit/AppCubit.dart';
import 'package:target_manangment/layout/cubit/AppStates.dart';

class KPIAndAward extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double progress = 0;
    return BlocConsumer<Appcubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          body: ConditionalBuilder(
            condition: Appcubit.get(context).kpi.isNotEmpty,
            builder: (context) {
              return Padding(
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
                                title: Appcubit.get(context).kpi[index].title,
                                subtitle: Appcubit.get(context)
                                    .kpi[index]
                                    .description,
                                url: Appcubit.get(context).kpi[index].pdf);
                          },
                          separatorBuilder: (context, index) {
                            return SizedBox(
                              height: 10,
                            );
                          },
                          itemCount: Appcubit.get(context).kpi.length,
                        ),
                      )
                    ],
                  ),
                ),
              );
            },
            fallback: (context) {
              return Center(child: CircularProgressIndicator());
            },
          ),
        );
      },
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
                textDirection: TextDirection.rtl,
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
