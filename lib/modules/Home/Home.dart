import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:target_manangment/layout/cubit/AppCubit.dart';
import 'package:target_manangment/layout/cubit/AppStates.dart';
import 'package:target_manangment/models/dashboard.dart';
import 'package:target_manangment/modules/Achievement/Achievement.dart';
import 'package:target_manangment/modules/KPI&Award/KPI&Award.dart';
import 'package:target_manangment/modules/KpiAndAword/KpiAndAword.dart';
import 'package:target_manangment/modules/instructions/instructions.dart';
import 'package:target_manangment/modules/instructions/instructionsdisplay.dart';
import 'package:target_manangment/modules/knowledge/knowledge.dart';
import 'package:target_manangment/modules/offers/offers.dart';
import 'package:target_manangment/shared/components/components.dart';
import 'package:target_manangment/shared/constant/constant.dart';
import 'package:target_manangment/shared/cubit/appcubit.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Appcubit.get(context).getprofiledata(userId);
    return BlocConsumer<Appcubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = Appcubit.get(context);

        return FutureBuilder<List<Map<String, dynamic>>>(
          future: cubit.getAllScores(),
          builder: (context, scoreSnapshot) {
            if (scoreSnapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (scoreSnapshot.hasError) {
              return Center(
                child: Text(
                  'Error: ${scoreSnapshot.error}',
                  style: const TextStyle(color: Colors.red, fontSize: 16),
                ),
              );
            } else if (!scoreSnapshot.hasData || scoreSnapshot.data!.isEmpty) {
              return const Center(
                child: Text(
                  'No scores available.',
                  style: TextStyle(color: Colors.grey, fontSize: 16),
                ),
              );
            } else {
              return FutureBuilder<List<String>>(
                future: cubit.getAllOfferImages(),
                builder: (context, imageSnapshot) {
                  if (imageSnapshot.connectionState ==
                      ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (imageSnapshot.hasError) {
                    return Center(
                      child: Text(
                        'Error: ${imageSnapshot.error}',
                        style: const TextStyle(color: Colors.red, fontSize: 16),
                      ),
                    );
                  } else if (!imageSnapshot.hasData ||
                      imageSnapshot.data!.isEmpty) {
                    return const Center(
                      child: Text(
                        'No images available.',
                        style: TextStyle(color: Colors.grey, fontSize: 16),
                      ),
                    );
                  } else {
                    return _productsBuilder(
                      images: imageSnapshot.data!,
                      data: scoreSnapshot.data!,
                      context: context,
                      dashboard: cubit.dashBoard,
                      knowledge: cubit.knowledge,
                    );
                  }
                },
              );
            }
          },
        );
      },
    );
  }

  Widget _productsBuilder({
    required List<String> images,
    required BuildContext context,
    DashBoard? dashboard,
    required List<Map<String, dynamic>> data,
    required bool knowledge,
  }) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 50, left: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Welcome',
                        style: Theme.of(context).textTheme.headline6!.copyWith(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            )),
                    Text(Appcubit.get(context).profileData!.username.toString(),
                        style: Theme.of(context).textTheme.headline6!.copyWith(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            )),
                  ],
                ),
              ),
              const Spacer(),
              if (Appcubit.get(context).profileData!.image != null)
                Padding(
                  padding: const EdgeInsets.only(top: 50, left: 20, right: 20),
                  child: CircleAvatar(
                    radius: 20,
                    backgroundImage: NetworkImage(
                      Appcubit.get(context).profileData!.image.toString(),
                    ),
                  ),
                ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: CarouselSlider(
              items: images.map(
                (imageUrl) {
                  return ClipRRect(
                    borderRadius: BorderRadius.circular(15.0),
                    child: Stack(
                      children: [
                        Image.network(
                          imageUrl,
                          width: double.infinity,
                          fit: BoxFit.fill,
                          loadingBuilder: (context, child, loadingProgress) {
                            if (loadingProgress == null) return child;
                            return Center(
                              child: CircularProgressIndicator(
                                value: loadingProgress.expectedTotalBytes !=
                                        null
                                    ? loadingProgress.cumulativeBytesLoaded /
                                        loadingProgress.expectedTotalBytes!
                                    : null,
                              ),
                            );
                          },
                          errorBuilder: (context, error, stackTrace) {
                            return Center(
                              child: Icon(
                                Icons.error,
                                color: Colors.red,
                                size: 50,
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  );
                },
              ).toList(),
              options: CarouselOptions(
                height: 230.0,
                viewportFraction: 0.4,
                autoPlay: true,
                autoPlayInterval: const Duration(seconds: 3),
                enlargeCenterPage: true,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 30, left: 30),
            child: Container(
              height: 60,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 255, 255, 255),
                borderRadius: BorderRadius.all(
                  Radius.circular(10),
                ),
                border: Border.all(
                  color: c,
                  width: 2,
                ),
                boxShadow: [
                  BoxShadow(
                    blurRadius: 0,
                    spreadRadius: 0.5,
                  ),
                ],
              ),
              child: Row(
                children: [
                  SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: Container(
                      width: 100,
                      height: 40,
                      decoration: BoxDecoration(
                        color: (knowledge) ? Colors.white : c,
                        borderRadius: BorderRadius.all(
                          Radius.circular(10),
                        ),
                        border: Border.all(
                          color: c,
                          width: 1,
                        ),
                      ),
                      child: MaterialButton(
                        onPressed: () {
                          Appcubit.get(context).changepage(
                            true,
                          );
                        },
                        child: Text(
                          'knowledge',
                          style: TextStyle(
                            color: (knowledge) ? c : Colors.white,
                            fontSize: 10,
                            fontFamily: 'poppins-medium',
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: Container(
                      width: 100,
                      height: 40,
                      decoration: BoxDecoration(
                        color: (!knowledge) ? Colors.white : c,
                        borderRadius: BorderRadius.all(
                          Radius.circular(10),
                        ),
                        border: Border.all(
                          color: c,
                          width: 1,
                        ),
                      ),
                      child: MaterialButton(
                        onPressed: () {
                          Appcubit.get(context).changepage(
                            false,
                          );
                        },
                        child: Text(
                          'Kpi & offers',
                          style: TextStyle(
                            color: (!knowledge) ? c : Colors.white,
                            fontSize: 10,
                            fontFamily: 'poppins-medium',
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                ],
              ),
            ),
          ),
          if (knowledge)
            Column(
              children: [
                knowledgelist(
                  type: 'Postpaid',
                  onTap: () {
                    Appcubit.get(context).getknowladge(type: 'postpaid');
                    navigateTo(
                      context,
                      KnowledgeScreen(title: 'Postpaid'),
                    );
                  },
                ),
                knowledgelist(
                  type: 'Prepaid',
                  onTap: () {
                    Appcubit.get(context).getknowladge(type: 'prepaid');
                    navigateTo(
                      context,
                      KnowledgeScreen(title: 'Prepaid'),
                    );
                  },
                ),
                knowledgelist(
                  type: 'DSL',
                  onTap: () {
                    Appcubit.get(context).getknowladge(type: 'dsl');

                    navigateTo(
                      context,
                      KnowledgeScreen(title: 'DSL'),
                    );
                  },
                ),
                knowledgelist(
                  type: 'Home 4G ',
                  onTap: () {
                    Appcubit.get(context).getknowladge(type: 'home4G');
                    navigateTo(
                      context,
                      KnowledgeScreen(title: 'Home 4G '),
                    );
                  },
                ),
                knowledgelist(
                  type: 'Corporate',
                  onTap: () {
                    Appcubit.get(context).getknowladge(type: 'corporate');
                    navigateTo(
                      context,
                      KnowledgeScreen(title: 'Corporate'),
                    );
                  },
                ),
                knowledgelist(
                  type: 'Premier',
                  onTap: () {
                    Appcubit.get(context).getknowladge(type: 'premier');
                    navigateTo(
                      context,
                      KnowledgeScreen(title: 'Premier'),
                    );
                  },
                ),
                knowledgelist(
                  type: 'FreeMAX',
                  onTap: () {
                    Appcubit.get(context).getknowladge(type: 'freemax');
                    navigateTo(
                      context,
                      KnowledgeScreen(title: 'FreeMAX'),
                    );
                  },
                ),
                knowledgelist(
                  type: 'Orange Cash',
                  onTap: () {
                    Appcubit.get(context).getknowladge(type: 'orangecash');
                    navigateTo(
                      context,
                      KnowledgeScreen(title: 'Orange Cash'),
                    );
                  },
                ),
                knowledgelist(
                  type: 'MNP',
                  onTap: () {
                    Appcubit.get(context).getknowladge(type: 'mnp');
                    navigateTo(
                      context,
                      KnowledgeScreen(title: 'MNP'),
                    );
                  },
                ),
                knowledgelist(
                  type: 'Siebel Features',
                  onTap: () {
                    Appcubit.get(context).getknowladge(type: 'siebelFeatures');
                    navigateTo(
                      context,
                      KnowledgeScreen(title: 'Siebel Features'),
                    );
                  },
                ),
              ],
            ),
          if (!knowledge)
            Column(
              children: [
                knowledgelist(
                  type: 'KPI',
                  onTap: () {
                    navigateTo(
                      context,
                      KPIListScreen(),
                    );
                  },
                ),
                knowledgelist(
                  type: 'Offers',
                  onTap: () {
                    navigateTo(
                      context,
                      OfferListScreen(),
                    );
                  },
                ),
                knowledgelist(
                    type: 'instructions',
                    onTap: () {
                      navigateTo(
                        context,
                        instructionsScreen(),
                      );
                    }),
              ],
            ),
        ],
      ),
    );
  }

  Widget knowledgelist({
    required String type,
    required Function onTap,
  }) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Container(
        height: 80,
        width: double.infinity,
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: () {
              onTap();
            },
            borderRadius: BorderRadius.circular(10),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    spreadRadius: 2,
                    blurRadius: 5,
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Row(
                  children: [
                    Icon(
                      Icons.file_copy,
                      color: c,
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Text(
                      type,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                      ),
                    ),
                    Spacer(),
                    Icon(
                      Icons.arrow_forward_ios,
                      color: c,
                    ),
                    SizedBox(
                      width: 20,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
