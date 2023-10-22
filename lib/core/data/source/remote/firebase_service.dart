import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

typedef ModelElement<T> = T Function(Map<String, dynamic>);

class FirebaseService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  User? get user => _auth.currentUser;

  Future<String> signInWithEmailAndPassword(
    String email,
    String password,
  ) async {
    try {
      UserCredential credential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (credential.user != null) {
        String userUid = credential.user!.uid;
        return userUid;
      } else {
        throw Exception('Empty');
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<String> signOut() async {
    try {
      await _auth.signOut();
      return 'Success';
    } catch (e) {
      rethrow;
    }
  }

  Future<String> addDocument(
      String collection, Map<String, dynamic> data) async {
    try {
      await _firestore.collection(collection).add(data);
      return 'Success';
    } catch (e) {
      rethrow;
    }
  }

  Future<List<T>> getDocumentListByField<T>({
    required String collection,
    String field = '',
    dynamic value,
    String orderBy = '',
    required ModelElement<T> mapping,
  }) async {
    try {
      QuerySnapshot<Map<String, dynamic>> result = await _firestore
          .collection(collection)
          .where(field, isEqualTo: value)
          .orderBy(orderBy, descending: true)
          .get();
      return result.docs.map((e) => mapping(e.data())).toList();
    } catch (e) {
      rethrow;
    }
  }
}
