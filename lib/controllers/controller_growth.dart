// ignore_for_file: use_build_context_synchronously, avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/model_nutrition.dart';

class ControllerGrowth {
  final streamsGrowth = FirebaseFirestore.instance.collection("growth");
  final streamsTotal = FirebaseFirestore.instance.collection("total_nutrition");
  final streamsUser = FirebaseFirestore.instance.collection("users");

  void add(String id, Nutrition nutri) async {
    try {
      final today = DateTime.now().subtract(
        const Duration(
          days: 0,
        ),
      );
      final startOfToday = DateTime(
        today.year,
        today.month,
        today.day,
      );
      final endOfToday = DateTime(
        today.year,
        today.month,
        today.day,
        23,
        59,
        59,
      );
      String idGrowth = streamsGrowth.doc().id;

      await streamsGrowth.doc(idGrowth).set({
        'id': idGrowth,
        'id_user': id,
        "id_total": id +
            today.year.toString() +
            today.month.toString() +
            today.day.toString(),
        "protein": nutri.protein,
        "lemak": nutri.lemak,
        "air": nutri.air,
        "karbohidrat": nutri.karbohidrat,
        "serat": nutri.serat,
        "kalori": nutri.kalori,
        "name": nutri.text,
        "photo": nutri.photo,
        'timestamp': Timestamp.fromDate(today),
      });

      final totalNutritionDoc = streamsTotal.doc(id +
          today.year.toString() +
          today.month.toString() +
          today.day.toString());

      final querySnapshot = await streamsGrowth
          .where('timestamp',
              isGreaterThanOrEqualTo: Timestamp.fromDate(startOfToday))
          .where('timestamp',
              isLessThanOrEqualTo: Timestamp.fromDate(endOfToday))
          .where("id_total",
              isEqualTo: id +
                  today.year.toString() +
                  today.month.toString() +
                  today.day.toString())
          .get();

      double totalProtein = 0;
      double totalLemak = 0;
      double totalAir = 0;
      double totalKarbohidrat = 0;
      double totalSerat = 0;
      double totalKalori = 0;

      for (var doc in querySnapshot.docs) {
        totalProtein += (doc['protein'] ?? 0).toDouble();
        totalLemak += (doc['lemak'] ?? 0).toDouble();
        totalAir += (doc['air'] ?? 0).toDouble();
        totalKarbohidrat += (doc['karbohidrat'] ?? 0).toDouble();
        totalSerat += (doc['serat'] ?? 0).toDouble();
        totalKalori += (doc['kalori'] ?? 0).toDouble();
      }

      double totalNutrition = totalProtein +
          totalLemak +
          totalAir +
          totalKarbohidrat +
          totalSerat +
          totalKalori;

      await totalNutritionDoc.set({
        'id_user': id,
        "id_total": id +
            today.year.toString() +
            today.month.toString() +
            today.day.toString(),
        'protein': totalProtein,
        'lemak': totalLemak,
        'air': totalAir,
        'karbohidrat': totalKarbohidrat,
        'serat': totalSerat,
        'kalori': totalKalori,
        'totalNutrition': totalNutrition,
        'timestamp': Timestamp.fromDate(today),
      }, SetOptions(merge: true));

      String giziStatus = bodyMassIndex(totalNutrition);
      await streamsUser.doc(id).update({'gizi': giziStatus});
    } catch (e) {
      print("Error adding nutrition: $e");
    }
  }

  String bodyMassIndex(double totalNutrition) {
    if (totalNutrition < 5000.5) {
      return 'Kurang';
    } else if (totalNutrition >= 5000.5 && totalNutrition < 10000) {
      return 'Normal';
    } else {
      return 'Berlebih';
    }
  }

  void deleteNutrition(String totalNutritionId) async {
    try {
      await streamsTotal.doc(totalNutritionId).delete();

      final querySnapshot = await streamsGrowth
          .where("id_total", isEqualTo: totalNutritionId)
          .get();

      for (var doc in querySnapshot.docs) {
        await streamsGrowth.doc(doc.id).delete();
      }

      print("Nutrition records deleted successfully.");
    } catch (e) {
      print("Error deleting nutrition records: $e");
    }
  }
}
