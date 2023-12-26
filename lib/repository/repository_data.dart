import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myweb/model/response_model.dart';

final instanceProviderFirebase = Provider<FirebaseFirestore>((ref) => FirebaseFirestore.instance);
final instanceProviderFirebaseStorage =
    Provider<FirebaseStorage>((ref) => FirebaseStorage.instance);

final repoProvider = Provider<RepositoryData>((ref) {
  return RepositoryData(
      instance: ref.read(instanceProviderFirebase),
      instance2: ref.read(instanceProviderFirebaseStorage));
});

class RepositoryData {
  final FirebaseFirestore instance;
  final FirebaseStorage instance2;

  const RepositoryData({required this.instance, required this.instance2});

  Future<ResponseModel?> getprojectData() async {
    CollectionReference dataProject = instance.collection("project_work");

    var dataResponse = await dataProject.orderBy("end_project", descending: true).get();

    return ResponseModel(data: dataResponse.docChanges, status: 200);
  }

  Future<ResponseModel?> getWorkingData() async {
    CollectionReference dataProject = instance.collection("experience_work");

    var dataResponse = await dataProject.orderBy("date_start", descending: true).get();

    return ResponseModel(data: dataResponse.docChanges, status: 200);
  }

  Future<String> downloadResume() async {
    final refData = await instance2
        .refFromURL("gs://portfolioweb-55f91.appspot.com/resume.pdf")
        .getDownloadURL();
    print(refData);
    return refData;
  }
}
