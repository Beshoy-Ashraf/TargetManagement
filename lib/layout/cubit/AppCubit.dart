import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:target_manangment/layout/cubit/AppStates.dart';
import 'package:target_manangment/models/datamodel.dart';
import 'package:target_manangment/models/initialModel.dart';
import 'package:target_manangment/models/total.dart';
import 'package:target_manangment/modules/Achievement/Achievement.dart';
import 'package:target_manangment/modules/KPI&Award/KPI&Award.dart';
import 'package:target_manangment/modules/Setting/Setting.dart';
import 'package:target_manangment/modules/knowledge/knowledge.dart';
import 'package:target_manangment/shared/constant/constant.dart';

class Appcubit extends Cubit<AppStates> {
  Appcubit() : super(AppInitialState());
  static Appcubit get(context) => BlocProvider.of(context);

  Future<Database> initializeDB() async {
    return openDatabase(
      join(await getDatabasesPath(), 'db.db'),
      onCreate: (db, version) {
        return db.execute(
          '''
        CREATE TABLE targets(
          day TEXT PRIMARY KEY, 
          point INTEGER, 
          GA INTEGER,
          orange_cash INTEGER, 
          adsl INTEGER, 
          home4g INTEGER, 
          devices INTEGER
        )
        ''',
        );
      },
      version: 1,
    );
  }

  Future<void> insertData(String day, int point, int GA, int orangeCash,
      int adsl, int home4g, int devices) async {
    final Database db = await initializeDB();

    await db.insert(
      'targets',
      {
        'day': day,
        'point': point,
        'GA': GA,
        'orange_cash': orangeCash,
        'adsl': adsl,
        'home4g': home4g,
        'devices': devices,
      },
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<Map<String, dynamic>>> retrieveData() async {
    final Database db = await initializeDB();

    return await db.query('targets');
  }

  Future<String> getDatabasePath() async {
    return join(await getDatabasesPath(), 'db');
  }

  Future<void> deleteOldDatabase() async {
    String dbPath = await getDatabasePath();
    await deleteDatabase(dbPath);
    print("Database deleted successfully.");
  }

  Future<void> updateData(String day, int point, int GA, int orangeCash,
      int adsl, int home4g, int devices) async {
    final Database db = await initializeDB();

    await db.update(
      'targets',
      {
        'point': point,
        'GA': GA,
        'orange_cash': orangeCash,
        'adsl': adsl,
        'home4g': home4g,
        'devices': devices,
      },
      where: "day = ?",
      whereArgs: [day],
    );
  }

/////////////////////////////////////////////////firebase////////////////////////////////////////////
  void setUserData({
    required String day,
    required int point,
    required int GA,
    required int oc,
    required int dsl,
    required int home4g,
    required int devices,
  }) {
    Target instarget = Target(
      point: point,
      GA: GA,
      orangeCash: oc,
      adsl: dsl,
      devices: devices,
      day: day,
      home4g: home4g,
    );
    FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .collection('target')
        .doc(day)
        .set(instarget.toMap())
        .then((value) {
      calculateTotaltotal(userId).then((value) {
        print('done');
        emit(SetDataSuccessful());
      }).catchError((error) {
        emit(SetDataError());
      });
    }).catchError((error) {
      emit(SetDataError());
    });
  }

  void UpdateUserData({
    required String day,
    required int point,
    required int GA,
    required int oc,
    required int dsl,
    required int home4g,
    required int devices,
  }) {
    Target instarget = Target(
      point: point,
      GA: GA,
      orangeCash: oc,
      adsl: dsl,
      devices: devices,
      day: day,
      home4g: home4g,
    );
    FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .collection('target')
        .doc(day)
        .set(instarget.toMap(), SetOptions(merge: true))
        .then((value) {
      calculateTotaltotal(userId).then((value) {
        print('done');
        emit(SetDataSuccessful());
      }).catchError((error) {
        emit(SetDataError());
      });
    }).catchError((error) {
      emit(SetDataError());
    });
  }

  Target? target;
  Future<Target?> getTargetDataForDay(String userId, String day) async {
    try {
      DocumentSnapshot documentSnapshot = await FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .collection('target')
          .doc(day)
          .get();

      if (documentSnapshot.exists) {
        Map<String, dynamic>? data =
            documentSnapshot.data() as Map<String, dynamic>?;

        if (data != null) {
          target = Target.fromMap(data);

          emit(GetDataSuccessful());
          return target;
        } else {
          print('Data is null for day: $day');
          emit(NoDataFound());
          return null;
        }
      } else {
        print('No target data found for day: $day');
        emit(NoDataFound());
        return null;
      }
    } catch (error) {
      print('Error getting target data for day: $error');
      emit(GetDataError());
      return null;
    }
  }

  void setInatioalTarget({
    required int point,
    required int pointper,
    required int GA,
    required int GAper,
    required int oc,
    required int ocper,
    required int dsl,
    required int dslper,
    required int home4g,
    required int home4gper,
    required int devices,
    required int devicesper,
  }) {
    initialTarget instarget = initialTarget(
      point: point,
      GA: GA,
      orangeCash: oc,
      adsl: dsl,
      devices: devices,
      home4g: home4g,
      pointper: pointper,
      GAper: GAper,
      adslper: dslper,
      devicesper: devicesper,
      orangeCashper: ocper,
      home4gper: home4gper,
    );
    FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .collection('initialTarget')
        .doc('initial')
        .set(instarget.toMap())
        .then((value) {
      print('done');
      emit(SetDataSuccessful());
    }).catchError((error) {
      emit(SetDataError());
    });
  }
  /////////////////////////////////////////

  Future<Object> calculateTotaltotal(String userId) async {
    int totalPoints = 0;
    int totalGA = 0;
    int totalOC = 0;
    int totalHome4G = 0;
    int totalDevices = 0;
    int totalDsl = 0;

    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .collection('target')
          .get();

      for (var doc in querySnapshot.docs) {
        if (doc.exists) {
          Map<String, dynamic>? data = doc.data() as Map<String, dynamic>?;
          int? points = data?['points'] as int?;
          int? GA = data?['GA'] as int?;
          int? OC = data?['orangeCash'] as int?;
          int? DSL = data?['adsl'] as int?;
          int? Devices = data?['devices'] as int?;
          int? Home4G = data?['home4g'] as int?;

          if (points != null) {
            totalPoints += points;
          }
          if (GA != null) {
            totalGA += GA;
          }
          if (OC != null) {
            totalOC += OC;
          }
          if (Devices != null) {
            totalDevices += Devices;
          }
          if (DSL != null) {
            totalDsl += DSL;
          }
          if (Home4G != null) {
            totalHome4G += Home4G;
          }
        }
      }
      Map<String, dynamic> m = {
        'totalPoints': totalPoints,
        'totalGA': totalGA,
        'totalOC': totalOC,
        'totalDevices': totalDevices,
        'totalDsl': totalDsl,
        'totalHome4G': totalHome4G,
      };
      FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .collection('totaltarget')
          .doc('total')
          .set(m)
          .then((value) {
        print('done');
        emit(SetDataSuccessful());
      }).catchError((error) {
        emit(SetDataError());
      });
      return m;
    } catch (error) {
      print('Error calculating total points: $error');
      return 0;
    }
  }

  Total? total;
  Future<void> getTotalachievement(String userId) async {
    try {
      DocumentSnapshot documentSnapshot = await FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .collection('totaltarget')
          .doc('total')
          .get();

      if (documentSnapshot.exists) {
        Map<String, dynamic>? data =
            documentSnapshot.data() as Map<String, dynamic>?;

        if (data != null) {
          total = Total.fromMap(data);

          emit(GetDataSuccessful());
        } else {
          emit(NoDataFound());
        }
      } else {
        emit(NoDataFound());
      }
    } catch (error) {
      print('Error getting target data for day: $error');
      emit(GetDataError());
    }
  }

  initialTarget? InitTarget;
  Future<void> getInitTarget(String userId) async {
    try {
      DocumentSnapshot documentSnapshot = await FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .collection('initialTarget')
          .doc('initial')
          .get();

      if (documentSnapshot.exists) {
        Map<String, dynamic>? data =
            documentSnapshot.data() as Map<String, dynamic>?;

        if (data != null) {
          InitTarget = initialTarget.fromMap(data);

          emit(GetDataSuccessful());
        } else {
          emit(NoDataFound());
        }
      } else {
        emit(NoDataFound());
      }
    } catch (error) {
      print('Error getting target data for day: $error');
      emit(GetDataError());
    }
  }
}
