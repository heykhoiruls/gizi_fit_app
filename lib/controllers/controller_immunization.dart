import 'package:cloud_firestore/cloud_firestore.dart';

class ControllerImmunization {
  final streamsImmunization = FirebaseFirestore.instance.collection("immun");

  void add(String id) {
    streamsImmunization.doc(id).set({
      'uid': id,
      'timestamp': Timestamp.now(),
      'Vaksin HB-0': false,
      'Vaksin BCG': false,
      'Vaksin Polio 1': false,
      'Vaksin DPT-HB-Hib-1': false,
      'Vaksin Polio 2': false,
      'Vaksin DPT-HB-Hib-2': false,
      'Vaksin Polio 3': false,
      'Vaksin DPT-HB-Hib-3': false,
      'Vaksin Polio 4': false,
      'Vaksin IPV': false,
      'Vaksin Campak': false,
    });
  }
}
