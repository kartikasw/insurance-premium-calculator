import 'package:insurance_challenge/core/data/source/remote/firebase_service.dart';
import 'package:insurance_challenge/core/data/source/remote/remote_data_source.dart';
import 'package:insurance_challenge/core/data/source/remote/response/premium_response.dart';

class RemoteWithFirebase implements RemoteDataSource {
  RemoteWithFirebase(this._firebase);

  final FirebaseService _firebase;

  @override
  Future<String> addPremiumCalculation(Map<String, dynamic> data) async {
    if (_firebase.user != null) {
      data['userId'] = _firebase.user!.uid;
    } else {
      throw Exception('You are not eligible to perform this action');
    }
    return await _firebase.addDocument('premium', data);
  }

  @override
  Future<List<PremiumResponse>> getHistoryList() async {
    String userId = '';
    if (_firebase.user != null) {
      userId = _firebase.user!.uid;
    } else {
      throw Exception('You are not eligible to perform this action');
    }
    return await _firebase.getDocumentListByField(
      collection: 'premium',
      field: 'userId',
      value: userId,
      orderBy: 'timestamp',
      mapping: (data) => PremiumResponse.fromMap(data),
    );
  }

  @override
  Future<String> login({
    required String email,
    required String password,
  }) async {
    return await _firebase.signInWithEmailAndPassword(email, password);
  }

  @override
  Future<String> logout() async {
    return await _firebase.signOut();
  }
}
