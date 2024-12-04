import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:target_manangment/layout/cubit/AppCubit.dart';
import 'package:target_manangment/layout/cubit/AppStates.dart';
import 'package:target_manangment/modules/knowledge/knowledge.dart';
import 'package:target_manangment/shared/components/components.dart';

class Knowledgelist extends StatelessWidget {
  const Knowledgelist({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<Appcubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var fromCubit = Appcubit.get(context);

        return Scaffold(
          body: ConditionalBuilder(
            condition: true, // Replace with actual condition
            fallback: (context) => Center(child: CircularProgressIndicator()),
            builder: (context) {
              return Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 16.0, vertical: 20.0),
                child: GridView.count(
                  crossAxisCount: 2,
                  mainAxisSpacing: 20,
                  crossAxisSpacing: 20,
                  children: [
                    buildMenuItem(
                      context,
                      fromCubit,
                      title: 'Premier',
                      type: 'premier',
                      icon: Icons.star,
                    ),
                    buildMenuItem(
                      context,
                      fromCubit,
                      title: 'MNP',
                      type: 'mnp',
                      icon: Icons.swap_horiz,
                    ),
                    buildMenuItem(
                      context,
                      fromCubit,
                      title: 'Postpaid',
                      type: 'postpaid',
                      icon: Icons.phone_android,
                    ),
                    buildMenuItem(
                      context,
                      fromCubit,
                      title: 'Prepaid',
                      type: 'prepaid',
                      icon: Icons.sim_card,
                    ),
                    buildMenuItem(
                      context,
                      fromCubit,
                      title: 'Orange Cash',
                      type: 'orangecash',
                      icon: Icons.account_balance_wallet,
                    ),
                    buildMenuItem(
                      context,
                      fromCubit,
                      title: 'Corporate',
                      type: 'corporate',
                      icon: Icons.business,
                    ),
                    buildMenuItem(
                      context,
                      fromCubit,
                      title: 'Home 4G',
                      type: 'home4G',
                      icon: Icons.wifi,
                    ),
                    buildMenuItem(
                      context,
                      fromCubit,
                      title: 'DSL',
                      type: 'dsl',
                      icon: Icons.network_check,
                    ),
                  ],
                ),
              );
            },
          ),
        );
      },
    );
  }

  Widget buildMenuItem(
    BuildContext context,
    Appcubit fromCubit, {
    required String title,
    required String type,
    required IconData icon,
  }) {
    return Hero(
      tag: type,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            fromCubit.getknowladge(type: type);
            navigateTo(
              context,
              KnowledgeScreen(title: type.toUpperCase()),
            );
          },
          splashColor: Colors.deepOrangeAccent.withOpacity(0.2),
          borderRadius: BorderRadius.circular(15),
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
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(icon, size: 40, color: Colors.deepOrange),
                SizedBox(height: 10),
                Text(
                  title,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
