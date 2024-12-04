import 'dart:ffi';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:target_manangment/layout/cubit/AppStates.dart';
import 'package:target_manangment/models/dashboard.dart';
import 'package:target_manangment/models/datamodel.dart';
import 'package:target_manangment/models/initialModel.dart';
import 'package:target_manangment/models/knowladgemodel.dart';
import 'package:target_manangment/models/profiledata.dart';
import 'package:target_manangment/models/total.dart';
import 'package:target_manangment/modules/Achievement/Targetpage.dart';
import 'package:target_manangment/modules/Home/Home.dart';
import 'package:target_manangment/modules/KPI&Award/KPI&Award.dart';
import 'package:target_manangment/modules/Setting/Setting.dart';
import 'package:target_manangment/modules/knowledge/knowledgelist.dart';
import 'package:target_manangment/modules/offers/offers.dart';
import 'package:target_manangment/shared/constant/constant.dart';
import 'package:file_picker/file_picker.dart';
import 'package:target_manangment/shared/network/local/shared_helper.dart';

class Appcubit extends Cubit<AppStates> {
  Appcubit() : super(AppInitialState());
  static Appcubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;
  List<Widget> screens = [
    HomeScreen(),
    Targetpage(),
    Setting(),
  ];

  void changeIndex(int index) {
    currentIndex = index;
    emit(ChangeIndexState());
  }

  bool knowledge = true;
  void changepage(bool k) {
    knowledge = k;
    emit(ChangeIndexState());
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

  ProfileData? profileData;
  Future<void> getprofiledata(String userId) async {
    try {
      DocumentSnapshot documentSnapshot = await FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .get();

      if (documentSnapshot.exists) {
        Map<String, dynamic>? data =
            documentSnapshot.data() as Map<String, dynamic>?;

        if (data != null) {
          profileData = ProfileData.fromJson(data);
          print(profileData!.username);

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

  DashBoard? dashBoard;

  Future<void> getdashboard(String userId) async {
    try {
      DocumentSnapshot documentSnapshot = await FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .collection('dashboard')
          .doc('basicinfo')
          .get();

      if (documentSnapshot.exists) {
        Map<String, dynamic>? data =
            documentSnapshot.data() as Map<String, dynamic>?;

        if (data != null) {
          dashBoard = DashBoard.fromMap(data);

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
    if (result != null) {
      File file = File(result!.files.single.path!);

      FirebaseStorage storage = FirebaseStorage.instance;

      Reference ref =
          storage.ref().child('uploads/${result!.files.single.name}');

      UploadTask uploadTask = ref.putFile(file);

      uploadTask.snapshotEvents.listen((TaskSnapshot snapshot) {
        double progress =
            (snapshot.bytesTransferred / snapshot.totalBytes) * 100;
        print('Upload is $progress% complete.');
      });
      await uploadTask.whenComplete(() async {
        String downloadURL = await ref.getDownloadURL();
        pdfurl = downloadURL;
        print('File uploaded. Download URL: $downloadURL');
      });
    } else {
      print('No file selected.');
    }
  }

  void addinformation({
    required String title,
    required String description,
    required String type,
  }) async {
    try {
      await uploadPDF();
      if (title.isEmpty || description.isEmpty || type.isEmpty) {
        throw Exception("All fields must be filled.");
      }

      await FirebaseFirestore.instance
          .collection('information')
          .doc(type)
          .collection(type)
          .add({
        'title': title,
        'description': description,
        'pdf': await pdfurl,
        'type': type,
      });

      emit(AddInformationSuccessful());
    } catch (error) {
      // Log the error for better debugging
      print('Error adding knowledge: $error');
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
  void getknowladge({required String type}) {
    knowladge = [];
    FirebaseFirestore.instance
        .collection('information')
        .doc(type)
        .collection(type)
        .get()
        .then((value) {
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

  void calculateTotalAchieve() async {
    try {
      await getInitTarget(userId);
      await getTotalachievement(userId);
      totlalAchieve(total!, InitTarget!);
    } catch (error) {
      print('Error calculating total points: $error');
    }
  }

  void totlalAchieve(Total t, initialTarget initAch) async {
    int totalPoints = t.point;
    int totalGA = t.GA;
    int totalOC = t.orangeCash;
    int totalHome4G = t.home4g;
    int totalDevices = t.devices;
    int totalDsl = t.adsl;
    int pointKpi = initAch.pointper;
    int OCKpi = initAch.orangeCashper;
    int DSLKpi = initAch.adslper;
    int GAKpi = initAch.GAper;
    double DevicesKpi = initAch.devicesper;
    double Home4GKpi = initAch.home4gper;
    int point = initAch.point;
    int GA = initAch.GA;
    int OC = initAch.orangeCash;
    int DSL = initAch.adsl;
    int Home4G = initAch.home4g;
    int Devices = initAch.devices;
    int pointper = 0;
    int GAper = 0;
    int OCper = 0;
    int DSLper = 0;
    int Home4Gper = 0;
    int Devicesper = 0;
    pointper = (point != 0) ? ((totalPoints * 100 / point).toInt()) : 0;
    pointKpi = (pointper * pointKpi / 100).toInt();
    GAper = (GA != 0) ? ((totalGA * 100 / GA).toInt()) : 0;
    OCper = (OC != 0) ? ((totalOC * 100 / OC).toInt()) : 0;
    OCKpi = (OCper * OCKpi / 100).toInt();
    DSLper = (DSL != 0)
        ? ((totalDsl * 100 / DSL).toInt())
        : (totalDsl * 100).toInt();
    DSLKpi = (GA != 0) ? (DSLper * DSLKpi / 100).toInt() : 0;
    Devicesper = (Devices != 0) ? ((totalDevices * 100 / Devices).toInt()) : 0;
    DevicesKpi = (Devicesper * DevicesKpi / 100).toInt() > 5
        ? 5
        : (Devicesper * DevicesKpi / 100);
    Home4Gper = (Home4G != 0) ? ((totalHome4G * 100 / Home4G).toInt()) : 0;
    Home4GKpi = (Home4Gper * Home4GKpi / 100).toDouble();
    double totalKpi = pointKpi + OCKpi + DSLKpi + DevicesKpi + Home4GKpi;
    settotal(
        totalPoints: totalPoints,
        totalGA: totalGA,
        totalOC: totalOC,
        totalHome4G: totalHome4G,
        totalDsl: totalDsl,
        totalDevices: totalDevices,
        pointKpi: pointKpi,
        GAKpi: GAKpi,
        OCKpi: OCKpi,
        Home4GKpi: Home4GKpi.toInt(),
        DevicesKpi: DevicesKpi.toInt(),
        DSLKpi: DSLKpi,
        point: point,
        GA: GA,
        OC: OC,
        Home4G: Home4G,
        Devices: Devices,
        DSL: DSL,
        pointper: pointper,
        GAper: GAper,
        OCper: OCper,
        Home4Gper: Home4Gper,
        Devicesper: Devicesper,
        DSLper: DSLper,
        totalKpi: totalKpi);
  }

  void settotal({
    required int totalPoints,
    required int totalGA,
    required int totalOC,
    required int totalHome4G,
    required int totalDsl,
    required int totalDevices,
    required int pointKpi,
    required int GAKpi,
    required int OCKpi,
    required int Home4GKpi,
    required int DevicesKpi,
    required int DSLKpi,
    required int point,
    required int GA,
    required int OC,
    required int Home4G,
    required int Devices,
    required int DSL,
    required int pointper,
    required int GAper,
    required int OCper,
    required int Home4Gper,
    required int Devicesper,
    required int DSLper,
    required double totalKpi,
  }) {
    DashBoard total = DashBoard(
      totalPoints: totalPoints,
      totalGA: totalGA,
      totalOC: totalOC,
      totalHome4G: totalHome4G,
      totalDsl: totalDsl,
      totalDevices: totalDevices,
      pointKpi: pointKpi,
      GAKpi: GAKpi,
      OCKpi: OCKpi,
      Home4GKpi: Home4GKpi,
      DevicesKpi: DevicesKpi,
      DSLKpi: DSLKpi,
      point: point,
      GA: GA,
      OC: OC,
      Home4G: Home4G,
      Devices: Devices,
      DSL: DSL,
      pointper: pointper,
      GAper: GAper,
      OCper: OCper,
      Home4Gper: Home4Gper,
      Devicesper: Devicesper,
      DSLper: DSLper,
      totalKpi: totalKpi.toInt(),
    );
    FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .collection('dashboard')
        .doc('basicinfo')
        .set(total.toMap())
        .then((value) {
      print('done');
      emit(SetDataSuccessful());
    }).catchError((error) {
      emit(SetDataError());
    });
  }

  Future<void> clearCollection(String collectionPath) async {
    CollectionReference collectionRef = FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .collection(collectionPath);

    QuerySnapshot snapshot = await collectionRef.get();

    for (DocumentSnapshot document in snapshot.docs) {
      await document.reference.delete();
    }
  }

  String lastDay() {
    DateTime now = DateTime.now();

    DateTime lastDayOfMonth = DateTime(now.year, now.month + 1, 0);

    DateFormat formatter = DateFormat('d');
    String formatted = formatter.format(lastDayOfMonth);

    return formatted;
  }

  void clear() {
    DateTime now = DateTime.now();
    DateFormat formatter = DateFormat('d');
    DateFormat month = DateFormat('MMMM');
    String monthname = month.format(now);

    String formatted = formatter.format(now);
    if (formatted == '1') {
      if (CashHelper.getData(key: monthname) == 1) {
        return;
      }
      CashHelper.saveData(key: monthname, value: 1);
      clearCollection("target").then((_) {
        print("Collection cleared!");
      }).catchError((error) {
        print("Error clearing collection: $error");
      });
      setInatioalTarget(
          point: 0,
          pointper: 0,
          GA: 0,
          GAper: 0,
          oc: 0,
          ocper: 0,
          dsl: 0,
          dslper: 0,
          home4g: 0,
          home4gper: 0,
          devices: 0,
          devicesper: 0);
      getTotalachievement(userId);
      calculateAchie(userId);
      calculateTotalAchieve();
      calculateTotaltotal(userId);
    } else {
      print("Not the last day of the month");
    }
  }

  void addKnowledge({
    required String type,
    required String title,
    required String description,
    required String pdf,
  }) async {
    try {
      if (title.isEmpty || description.isEmpty || pdf.isEmpty || type.isEmpty) {
        throw Exception("All fields must be filled.");
      }

      await FirebaseFirestore.instance
          .collection('information')
          .doc(type)
          .collection(type)
          .add({
        'title': title,
        'description': description,
        'pdf': pdf,
        'type': type,
      });

      emit(AddInformationSuccessful());
    } catch (error) {
      // Log the error for better debugging
      print('Error adding knowledge: $error');
      emit(AddInformationError());
    }
  }

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;
  Future<void> addOffer({
    required String title,
    required String description,
    required String imagePath,
  }) async {
    try {
      // رفع الصورة إلى Firebase Storage
      final ref = _storage
          .ref()
          .child('offers/${DateTime.now().millisecondsSinceEpoch}.jpg');
      await ref.putFile(imagePath as File);
      final imageUrl = await ref.getDownloadURL();

      // إضافة العرض إلى Firestore
      await _firestore.collection('offers').add({
        'title': title,
        'description': description,
        'imageUrl': imageUrl,
      });
    } catch (e) {
      print('Error adding offer: $e');
    }
  }

  Future<List<Map<String, dynamic>>> getOffers() async {
    try {
      QuerySnapshot snapshot = await _firestore.collection('offers').get();
      return snapshot.docs.map((doc) {
        return {
          'title': doc['title'],
          'description': doc['description'],
          'imageUrl': doc['imageUrl'],
        };
      }).toList();
    } catch (e) {
      print('Error fetching offers: $e');
      return [];
    }
  }

  Future<List<Map<String, dynamic>>> getinstructions() async {
    try {
      QuerySnapshot snapshot =
          await _firestore.collection('instructions').get();
      return snapshot.docs.map((doc) {
        return {
          'title': doc['title'],
          'description': doc['description'],
          'imageUrl': doc['imageUrl'],
        };
      }).toList();
    } catch (e) {
      print('Error fetching instructions: $e');
      return [];
    }
  }

  Future<List<String>> getAllOfferImages() async {
    List<String> allImages = [];

    try {
      QuerySnapshot snapshot =
          await FirebaseFirestore.instance.collection('instructions').get();

      for (var doc in snapshot.docs) {
        // Ensure the 'images' field exists and is a list
        if (doc.data() != null &&
            (doc.data() as Map<String, dynamic>).containsKey('images')) {
          List<dynamic> images = (doc.data() as Map<String, dynamic>)['images'];
          allImages.addAll(List<String>.from(images)); // Add to allImages
        }
      }
    } catch (e) {
      print('Error fetching instructions images: $e');
    }
    return allImages;
  }

  Future<bool> checkQuizAccess(String userId) async {
    final userDoc =
        await FirebaseFirestore.instance.collection('users').doc(userId).get();
    return userDoc.data()?['quizAccess'] ?? true;
  }

  Future<void> blockQuizAccess(String userId) async {
    await FirebaseFirestore.instance.collection('users').doc(userId).set(
      {'quizAccess': false},
      SetOptions(merge: true),
    );
  }
}
