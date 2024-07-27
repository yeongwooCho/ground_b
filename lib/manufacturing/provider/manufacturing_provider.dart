import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ground_b/manufacturing/model/enum/manufacturing_category_status.dart';
import 'package:ground_b/manufacturing/provider/category_provider.dart';
import 'package:ground_b/manufacturing/provider/current_situation_provider.dart';

import '../../common/const/data.dart';
import '../../common/const/image_path.dart';
import '../../common/utils/data_utils.dart';
import '../model/manufacturing_model.dart';

final manufacturingRandomByCurrentSituationProvider = Provider<List<ManufacturingModel>>((ref) {
  final manufactures = ref.watch(manufacturingProvider);
  final currentSituation = ref.watch(currentSituationSelectedProvider);

  final randomManufactures =
  DataUtils.getRandomShuffledList<ManufacturingModel>(manufactures);
  return randomManufactures;
});

final manufacturingRandomByCategoryProvider = Provider<List<ManufacturingModel>>((ref) {
  final manufactures = ref.watch(manufacturingProvider);
  final selectedCategory = ref.watch(manufacturingCategorySelectedProvider);

  final randomManufactures =
      DataUtils.getRandomShuffledList<ManufacturingModel>(manufactures);
  return randomManufactures;
});

final manufacturingDetailProvider =
    Provider.family<ManufacturingModel, String>((ref, id) {
  final manufacture = ref
      .watch(manufacturingProvider)
      .firstWhere((element) => element.id == id);
  return manufacture;
});

final manufacturingProvider =
    StateNotifierProvider<ManufacturingStateNotifier, List<ManufacturingModel>>(
        (ref) {
  return ManufacturingStateNotifier();
});

class ManufacturingStateNotifier
    extends StateNotifier<List<ManufacturingModel>> {
  ManufacturingStateNotifier() : super([]) {
    state = getItems();
  }
  List<ManufacturingModel> getItems() {
    return List.generate(
      manufacturingData.keys.length,
      (index) {
        List<int> tagIndexes = DataUtils.getRandomTwoInt(dividerNumber: 9);

        return ManufacturingModel(
          id: index.toString(),
          title: manufacturingData.keys.elementAt(index),
          description:
              manufacturingData[manufacturingData.keys.elementAt(index)]!,
          mainImageUrl: '${ImagePath.manufacturingDirectory}$index.png',
          numberOfProgress:
              DataUtils.getRandomInt(dividerNumber: 500) + 374 + index,
          tags: [manufacturingTags[tagIndexes.first], manufacturingTags[tagIndexes.last]],
          referenceImageUrls: DataUtils.getRandomTwoInt(dividerNumber: 18)
              .map((e) => '${ImagePath.referenceDirectory}$e.png')
              .toList(),
          categoryStatus: ManufacturingCategoryStatus.clothing,
        );
      },
    );
  }
}
