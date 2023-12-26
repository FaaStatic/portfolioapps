import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myweb/model/project_model.dart';
import 'package:myweb/repository/repository_data.dart';

final providerProjectGet = StateNotifierProvider<ProviderProject, List<ProjectModel>>(
    (ref) => ProviderProject(instanceData: ref.read(repoProvider)));

class ProviderProject extends StateNotifier<List<ProjectModel>> {
  final RepositoryData instanceData;
  ProviderProject({required this.instanceData}) : super([]);

  Future<void> getAllData() async {
    try {
      if (state.isNotEmpty) {
        state.clear();
      }

      final response = await instanceData.getprojectData();
      List<ProjectModel> dataList = [];
      for (var items in response!.data) {
        ProjectModel data = ProjectModel.fromJson(items.doc.data());
        dataList.add(data);
      }
      state = [...state, ...dataList];
    } catch (e) {
      print(e.toString());
    }
  }
}
