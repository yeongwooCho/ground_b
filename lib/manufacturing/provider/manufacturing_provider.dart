import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ground_b/manufacturing/model/enum/manufacturing_category_status.dart';
import 'package:ground_b/manufacturing/provider/category_provider.dart';
import 'package:ground_b/manufacturing/provider/current_situation_provider.dart';

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

  final Map<String, String> manufacturingData = {
    "트렌디 어패럴":
        "최신 트렌드를 반영한 고품질 의류를 제작합니다. 독창적인 디자인과 세심한 바느질로 고객의 만족을 극대화하며, 항상 신선한 제품을 제공합니다. 고객의 다양한 요구를 반영한 맞춤형 서비스를 제공하여, 개성 있는 스타일을 연출할 수 있도록 돕습니다.",
    "스타일 크래프트":
        "다양한 패션 아이템을 정교한 기술과 창의적인 디자인으로 제작해, 유니크한 스타일을 선보입니다. 고객 맞춤형 서비스를 통해 독특한 패션을 제공하며, 최신 트렌드와 전통적인 디자인을 조화롭게 결합합니다.",
    "모던 패션 팩토리":
        "현대적 감각의 의류와 잡화를 전문적으로 생산합니다. 최신 패션 트렌드를 반영한 제품을 제공하며, 품질과 스타일 모두에서 높은 만족도를 자랑합니다. 지속 가능한 패션을 지향하며, 친환경 소재를 사용하여 환경 보호에 기여합니다.",
    "엘리트 패브릭스":
        "최고급 소재를 사용해 프리미엄 의류를 제조합니다. 세련된 디자인과 철저한 품질 관리를 통해 고급스러운 제품을 제공합니다. 맞춤형 서비스와 세심한 바느질로 고객의 요구를 충족시키며, 최고의 품질을 보장합니다.",
    "골든 스티치":
        "세심한 바느질과 품질 관리를 통해 신뢰받는 의류를 제작합니다. 고객의 요구를 반영한 맞춤형 서비스를 제공하며, 고품질의 제품을 신속하게 제공합니다. 전통적인 기술과 현대적인 디자인을 결합하여 독특한 제품을 만듭니다.",
    "프리미어 가먼츠":
        "맞춤형 의류 제작과 효율적인 생산 공정을 통해 고품질 제품을 제공합니다. 고객의 요구에 맞춘 다양한 스타일의 의류를 제작하며, 신속한 배송을 자랑합니다. 지속 가능한 패션을 추구하며 친환경 소재를 사용합니다.",
    "럭셔리 라인":
        "고급스러운 디자인과 품질로 유명한 패션 제조사입니다. 세련된 스타일의 의류를 제공하며, 프리미엄 소재와 세심한 마감 처리를 통해 최고의 품질을 보장합니다. 고객 맞춤형 서비스를 통해 개인의 스타일을 극대화합니다.",
    "에코 패션 하우스":
        "친환경 소재와 윤리적 생산 방식을 고수합니다. 지속 가능한 패션을 지향하며, 환경 보호와 사회적 책임을 실천하는 기업으로 자리매김하고 있습니다. 고객의 요구를 반영한 맞춤형 제품을 제공합니다.",
    "어반 웨어":
        "도시적이고 세련된 스타일의 패션 아이템을 제작합니다. 현대적인 감각을 반영한 제품으로, 일상에서 쉽게 스타일링할 수 있는 의류를 제공합니다. 다양한 고객의 요구를 반영한 맞춤형 서비스를 제공합니다.",
    "시그니처 스타일":
        "독창적이고 차별화된 디자인으로 주목받는 패션 공장입니다. 개성 있는 의류를 제공하며, 고객의 스타일을 표현할 수 있는 다양한 제품을 제작합니다. 최신 트렌드를 반영하여 항상 신선한 제품을 제공합니다.",
    "패션 포지":
        "다양한 고객 요구에 맞춘 맞춤형 의류를 생산합니다. 품질과 디자인 모두에서 높은 만족을 제공하며, 고객의 기대를 초과하는 제품을 제공합니다. 전통적인 기술과 현대적인 디자인을 조화롭게 결합합니다.",
    "클래식 컷":
        "전통적인 스타일과 현대적 감각을 조화롭게 반영한 의류를 제작합니다. 클래식하면서도 트렌디한 제품을 통해 다양한 고객층을 만족시킵니다. 맞춤형 서비스를 통해 개성 있는 스타일을 연출합니다.",
    "디자인 디멘션":
        "혁신적이고 창의적인 패션 디자인을 실현합니다. 독특한 스타일의 의류를 제공하며, 차별화된 디자인과 높은 품질로 고객의 사랑을 받고 있습니다. 지속 가능한 패션을 지향하며, 친환경 소재를 사용합니다.",
    "프레시 패브릭":
        "신선한 디자인과 트렌디한 의류를 제공하며, 세심한 품질 관리로 고객 만족을 보장합니다. 최신 트렌드를 반영한 제품을 제작하여 항상 신선하고 독특한 스타일을 제공합니다.",
    "유니크 가먼트":
        "독특하고 개성 있는 패션 아이템을 제작하며, 다양한 스타일을 반영한 의류를 제공합니다. 고객 맞춤형 서비스를 통해 개인의 스타일을 극대화합니다.",
    "비비드 패션":
        "생동감 넘치는 디자인과 화려한 색상의 의류를 제작해, 고객의 시선을 사로잡습니다. 최신 트렌드를 반영하여 항상 신선하고 독창적인 제품을 제공합니다.",
    "프리미엄 웨어":
        "고급스러운 소재와 정교한 기술로 제작된 프리미엄 의류를 제공합니다. 세심한 품질 관리와 고객 맞춤형 서비스를 통해 최고의 제품을 보장합니다.",
    "에코 프렌들리":
        "환경을 생각하는 친환경 소재와 생산 방식을 통해 지속 가능한 패션을 제공합니다. 윤리적 생산 방식을 고수하며, 사회적 책임을 실천합니다.",
    "글로벌 패브릭":
        "글로벌 트렌드를 반영한 다양한 의류를 제작하며, 국제 시장에서도 경쟁력을 갖춘 제품을 제공합니다. 품질과 디자인 모두에서 높은 만족도를 자랑합니다.",
    "트렌드세터":
        "최신 트렌드를 선도하는 패션 아이템을 제작해, 빠르게 변하는 시장에 대응합니다. 혁신적인 디자인과 고품질 소재로 고객의 만족을 극대화합니다.",
    "스타일 인사이트":
        "독창적이고 창의적인 디자인으로 트렌디한 의류를 제작하며, 고객의 다양한 요구를 충족시킵니다. 지속 가능한 패션을 지향하며, 친환경 소재를 사용합니다.",
    "디자인 퀄리티":
        "디자인과 품질 모두를 중시하여, 고급스러운 의류를 제공합니다. 세심한 품질 관리와 고객 맞춤형 서비스를 통해 최고의 제품을 보장합니다.",
    "크리에이티브 패션":
        "창의적인 아이디어와 혁신적인 디자인으로 차별화된 패션 아이템을 제작합니다. 고객의 요구를 반영한 맞춤형 서비스를 제공하며, 독특한 스타일을 연출합니다.",
  };

  List<String> tags = [
    "배송무료",
    "여름맛집",
    "겨울맛집",
    "트렌디",
    "데일리",
    "바캉스",
    "빠른제작",
    "TOP",
    "NEW",
  ];

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
          tags: [tags[tagIndexes.first], tags[tagIndexes.last]],
          referenceImageUrls: DataUtils.getRandomTwoInt(dividerNumber: 18)
              .map((e) => '${ImagePath.referenceDirectory}$e.png')
              .toList(),
          categoryStatus: ManufacturingCategoryStatus.clothing,
        );
      },
    );
  }
}
