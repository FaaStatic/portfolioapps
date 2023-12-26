import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myweb/repository/repository_data.dart';

final providerDownloadData = StateNotifierProvider<ProviderDownload, String>(
    (ref) => ProviderDownload(instanceData: ref.read(repoProvider)));

class ProviderDownload extends StateNotifier<String> {
  final RepositoryData instanceData;
  ProviderDownload({required this.instanceData}) : super("");

  Future<void> downloadData() async {
    await instanceData.downloadResume().then((value) {
      state = value;
    });
  }
}
