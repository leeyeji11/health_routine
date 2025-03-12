import 'package:cloud_firestore/cloud_firestore.dart';

class RoutineService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
// routines 컬렉션의 모든 데이터를 가져오는 메서드
  Future<List<Map<String, dynamic>>> getAllRoutines() async {
    final snapshot =
        await FirebaseFirestore.instance.collection('routines').get();

    // 데이터가 잘 가져왔는지 확인 (임시로 print 추가)
    print("Firestore 데이터 개수: ${snapshot.docs.length}");

    return snapshot.docs.map((doc) => {"id": doc.id, ...doc.data()}).toList();
  }

  Future<void> deleteRoutine(String id) async {
    await FirebaseFirestore.instance.collection('routines').doc(id).delete();
  }
}
