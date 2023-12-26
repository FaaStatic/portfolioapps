import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myweb/model/experience_model.dart';
import 'package:myweb/repository/repository_data.dart';

final providerWorkingGet = StateNotifierProvider<ProviderWorking, List<ExperienceModel>>(
    (ref) => ProviderWorking(instanceData: ref.read(repoProvider)));

class ProviderWorking extends StateNotifier<List<ExperienceModel>> {
  final RepositoryData instanceData;
  ProviderWorking({required this.instanceData}) : super([]);

  Future<void> getAllData() async {
    try {
      if (state.isNotEmpty) {
        state.clear();
      }

      final response = await instanceData.getWorkingData();
      List<ExperienceModel> dataList = [];
      for (var items in response!.data) {
        ExperienceModel data = ExperienceModel.fromJson(items.doc.data());
        dataList.add(data);
      }
      state = [...state, ...dataList];
    } catch (e) {
      print(e.toString());
    }
  }
}
