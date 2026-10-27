import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myweb/model/about_model.dart';
import 'package:myweb/model/response_model.dart';

final instanceProviderFirebase = Provider<FirebaseFirestore>((ref) => FirebaseFirestore.instance);

final repoProvider = Provider<RepositoryData>((ref) {
  return RepositoryData(instance: ref.read(instanceProviderFirebase));
});

class RepositoryData {
  final FirebaseFirestore instance;

  const RepositoryData({required this.instance});

  Future<ResponseModel?> getprojectData() async {
    CollectionReference dataProject = instance.collection("project_work");

    var dataResponse = await dataProject.orderBy("sort_order").get();

    return ResponseModel(data: dataResponse.docChanges, status: 200);
  }

  Future<ResponseModel?> getWorkingData() async {
    CollectionReference dataProject = instance.collection("experience_work");

    var dataResponse = await dataProject.orderBy("date_start", descending: true).get();

    return ResponseModel(data: dataResponse.docChanges, status: 200);
  }

  /// Resume link (Google Drive) kept in profile/resume.url so it can change without a redeploy.
  Future<String> downloadResume() async {
    final doc = await instance.collection("profile").doc("resume").get();
    return doc.data()?["url"] as String? ?? "";
  }

  /// About section copy kept in profile/about so it can change without a redeploy.
  Future<Map<String, dynamic>> getAbout() async {
    final doc = await instance.collection("profile").doc("about").get();
    return doc.data() ?? {};
  }
}

final aboutProvider =
    FutureProvider<AboutModel>((ref) async => AboutModel.fromJson(await ref.read(repoProvider).getAbout()));
