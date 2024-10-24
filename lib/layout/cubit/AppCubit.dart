import 'dart:ffi';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:target_manangment/layout/cubit/AppStates.dart';
import 'package:target_manangment/models/datamodel.dart';
import 'package:target_manangment/models/initialModel.dart';
import 'package:target_manangment/models/knowladgemodel.dart';
import 'package:target_manangment/models/total.dart';
import 'package:target_manangment/shared/constant/constant.dart';
import 'package:file_picker/file_picker.dart';

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
    required double home4gper,
    required int devices,
    required double devicesper,
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

  Future<Object> calculateAchie(String userId) async {
    double totalPoints = 0.0 as double;
    double totalGA = 0.0 as double;
    double totalOC = 0.0 as double;
    double totalHome4G = 0.0 as double;
    double totalDevices = 0.0 as double;
    double totalDsl = 0.0 as double;
    double pointKpi = 0.0 as double;
    double OCKpi = 0.0 as double;
    double DSLKpi = 0.0 as double;
    double GAKpi = 0.0 as double;
    double DevicesKpi = 0.0 as double;
    double Home4GKpi = 0.0 as double;
    double point = 0.0 as double;
    double GA = 0.0 as double;
    double OC = 0.0 as double;
    double DSL = 0.0 as double;
    double Home4G = 0.0 as double;
    double Devices = 0.0 as double;
    double pointper = 0.0 as double;
    double GAper = 0.0 as double;
    double OCper = 0.0 as double;
    double DSLper = 0.0 as double;
    double Home4Gper = 0.0 as double;
    double Devicesper = 0.0 as double;
    try {
      //   QuerySnapshot querySnapshot = await FirebaseFirestore.instance
      //       .collection('users')
      //       .doc(userId)
      //       .collection('initialTarget')
      //       .get();

      //   for (var doc in querySnapshot.docs) {
      //     if (doc.exists) {
      //       Map<String, dynamic>? data = doc.data() as Map<String, dynamic>?;
      //       point = (data?['points'] as double?)!;
      //       GA = (data?['GA'] as double?)!;
      //       OC = (data?['orangeCash'] as double?)!;
      //       DSL = (data?['adsl'] as double?)!;
      //       Devices = (data?['devices'] as double?)!;
      //       Home4G = (data?['home4g'] as double?)!;
      //       pointKpi = (data?['pointper'] as double?)!;
      //       GAKpi = (data?['GAper'] as double?)!;
      //       OCKpi = (data?['orangeCashper'] as double?)!;
      //       DSLKpi = (data?['adslper'] as double?)!;
      //       DevicesKpi = (data?['devicesper'] as double?)!;
      //       Home4GKpi = (data?['home4gper'] as double?)!;
      //     }
      //   }
      //   querySnapshot = await FirebaseFirestore.instance
      //       .collection('users')
      //       .doc(userId)
      //       .collection('totaltarget')
      //       .get();

      //   for (var doc in querySnapshot.docs) {
      //     if (doc.exists) {
      //       Map<String, dynamic>? data = doc.data() as Map<String, dynamic>?;
      //       totalPoints = (data?['totalPoints'] as double?)!;
      //       totalGA = (data?['totalGA'] as double?)!;
      //       totalOC = (data?['totalOC'] as double?)!;
      //       totalDsl = (data?['totalDsl'] as double?)!;
      //       totalDevices = (data?['totalDevices'] as double?)!;
      //       totalHome4G = (data?['totalHome4G'] as double?)!;
      //     }
      // }

      pointper = (totalPoints * 100 / point) as double;
      pointKpi = (pointper * pointKpi / 100) as double;
      GAper = (totalGA * 100 / GA) as double;
      GAKpi = 0.0;
      OCper = (totalOC * 100 / OC) as double;
      OCKpi = (OCper * OCKpi / 100) as double;
      DSLper = (totalDsl * 100 / DSL) as double;
      DSLKpi = (DSLper * DSLKpi / 100) as double;
      Devicesper = (totalDevices * 100 / Devices) as double;
      DevicesKpi = (Devicesper * DevicesKpi / 100) as double;
      Home4Gper = (totalHome4G * 100 / Home4G) as double;
      Home4GKpi = (Home4Gper * Home4GKpi / 100) as double;
      print(pointKpi);
      Map<String, dynamic> m = {
        'pointper': pointper,
        'pointKpi': pointKpi,
        'GAper': GAper,
        'GAKpi': GAKpi,
        'Home4Gper': Home4Gper,
        'Home4GKpi': Home4GKpi,
        'Devicesper': Devicesper,
        'DevicesKpi': DevicesKpi,
        'OCper': OCper,
        'OCKpi': OCKpi,
        'DSLper': DSLper,
        'DSLKpi': DSLKpi,
      };
      print(m);
      FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .collection('totalAche')
          .doc('Ache')
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

  FilePickerResult? result;
  Future<void> pickPDF() async {
    result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );
    emit(Addimage());
  }

  String? pdfurl;

  Future<void> uploadPDF() async {
    // Step 1: Pick the file

    if (result != null) {
      // Step 2: Get the file and create a Firebase reference
      File file = File(result!.files.single.path!);
      FirebaseStorage storage = FirebaseStorage.instance;
      Reference ref =
          storage.ref().child('uploads/${result!.files.single.name}');

      // Step 3: Upload the file
      UploadTask uploadTask = ref.putFile(file);

      // Step 4: Monitor the upload progress
      uploadTask.snapshotEvents.listen((TaskSnapshot snapshot) {
        double progress =
            (snapshot.bytesTransferred / snapshot.totalBytes) * 100;
        print('Upload is $progress% complete.');
      });

      // Step 5: Get the download URL once the upload is complete
      await uploadTask.whenComplete(() async {
        String downloadURL = await ref.getDownloadURL();
        pdfurl = downloadURL;
        print('File uploaded. Download URL: $downloadURL');
      });
    } else {
      // User canceled the picker
      print('No file selected.');
    }
  }

  void addinformation({
    required String title,
    required String description,
  }) async {
    try {
      await uploadPDF();

      await FirebaseFirestore.instance.collection('information').add({
        'title': title,
        'description': description,
        'pdf': await pdfurl,
      });
      emit(AddInformationSuccessful());
    } catch (error) {
      print('Error adding information: $error');
      emit(AddInformationError());
    }
  }

  void addkpi({
    required String title,
    required String description,
  }) async {
    try {
      await uploadPDF();

      await FirebaseFirestore.instance.collection('KPI').add({
        'title': title,
        'description': description,
        'pdf': await pdfurl,
      });
      emit(AddInformationSuccessful());
    } catch (error) {
      print('Error adding kpi: $error');
      emit(AddInformationError());
    }
  }

  List<Knowladgemodel> knowladge = [];
  void getknowladge() {
    knowladge = [];
    FirebaseFirestore.instance.collection('information').get().then((value) {
      value.docs.forEach((element) {
        knowladge.add(Knowladgemodel.fromMap(element.data()));
      });
      emit(GetKnowlageSuccessfully());
    }).catchError((error) {
      emit(GetKnowlageError());
    });
  }

  List<Knowladgemodel> kpi = [];
  void getkpi() {
    kpi = [];
    FirebaseFirestore.instance.collection('KPI').get().then((value) {
      value.docs.forEach((element) {
        kpi.add(Knowladgemodel.fromMap(element.data()));
      });
      print(kpi[0]);
      emit(GetkpiSuccessfully());
    }).catchError((error) {
      print(error);
      emit(GetkpiError());
    });
  }
}
