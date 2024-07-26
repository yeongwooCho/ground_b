import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ground_b/manufacturing/model/enum/manufacturing_category_status.dart';
import 'package:ground_b/manufacturing/provider/category_provider.dart';

import '../../common/const/image_path.dart';
import '../../common/utils/data_utils.dart';
import '../model/manufacturing_model.dart';

final manufacturingRandomProvider = Provider<List<ManufacturingModel>>((ref) {
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

  final Map<String, String> manufacturingData = {
    '대전 패션 공장':
        "저희 회사는 혁신적인 의류와 잡화를 제조하는 기업으로, 최신 트렌드와 최고 품질의 제품을 제공합니다.\n\n독창적인 디자인과 정교한 기술을 바탕으로 고객의 다양한 취향과 요구를 반영한 맞춤형 제품을 제작합니다.지속 가능한 패션을 지향하며 친환경 소재와 윤리적 생산 방식을 고수하여, 환경 보호와 사회적 책임을 실천합니다. 열정과 창의성을 바탕으로 끊임없이 혁신하며, 글로벌 시장에서 경쟁력을 갖춘 제품을 제공하는 신뢰받는 브랜드입니다.",
  };

  List<String> descriptions = [];

  List<ManufacturingModel> getItems() {
    return List.generate(
      8,
      (index) => ManufacturingModel(
        id: index.toString(),
        title: manufacturingData.keys.first,
        description: manufacturingData['대전 패션 공장']!,
        mainImageUrl: '${ImagePath.manufacturingDirectory}0.png',
        numberOfProgress: 143 + index,
        tags: ["배송무료", "여름맛집"],
        referenceImageUrls: [
          '${ImagePath.manufacturingDirectory}0.png',
          '${ImagePath.manufacturingDirectory}0.png',
          '${ImagePath.manufacturingDirectory}0.png',
          '${ImagePath.manufacturingDirectory}0.png',
        ],
        categoryStatus: ManufacturingCategoryStatus.clothing,
      ),
    );
  }
}
