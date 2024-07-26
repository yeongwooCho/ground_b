import 'package:collection/collection.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ground_b/common/utils/data_utils.dart';

import '../model/notification_model.dart';

final notificationDetailProvider =
    Provider.family<NotificationModel?, String>((ref, id) {
  final events = ref.watch(notificationProvider);

  return events.where((element) => element.id == id).firstOrNull;
});

final notificationProvider =
    StateNotifierProvider<NotificationStateNotifier, List<NotificationModel>>(
  (ref) => NotificationStateNotifier(),
);

class NotificationStateNotifier extends StateNotifier<List<NotificationModel>> {
  NotificationStateNotifier() : super([]) {
    initItems();
  }

  void initItems() {
    final notificationData = {
      "[약관/정책 변경] 수수료 변경에 따른 서비스 이용약관 수정":
          "안녕하세요, 고객 여러분.\n\n저희는 최근의 시장 상황과 운영 비용의 변화를 반영하여 서비스 이용 수수료 구조를 조정하게 되었습니다.\n\n이에 따라, 서비스 이용약관의 관련 내용도 일부 수정되었습니다.\n\n주요 변경 사항은 수수료율의 조정이며, 이는 다음 달부터 적용될 예정입니다.\n\n변경된 약관은 더 투명하고 공정한 서비스 이용을 위한 조치이오니, 이용에 참고하시기 바랍니다.\n\n자세한 내용과 변경된 약관은 홈페이지에서 확인하실 수 있으며, 문의 사항이 있으시면 언제든지 고객지원 센터로 연락주시기 바랍니다.\n\n이용에 불편을 드리게 된 점 양해 부탁드리며, 앞으로도 더 나은 서비스를 제공하기 위해 최선을 다하겠습니다.",
      '[앱 기능성 개선] 카테고리 선택 다양화 추가':
          '저희 앱 사용자 여러분께 기쁜 소식을 전합니다! 사용자의 피드백을 반영하여 앱 내에서 제공하는 카테고리 선택 기능을 대폭 개선했습니다.\n\n이제 사용자는 보다 세분화된 카테고리 중에서 선택하여 자신의 관심사에 더욱 잘 맞는 콘텐츠를 쉽게 찾을 수 있게 되었습니다.\n\n이번 업데이트를 통해 사용자의 편의성을 높이고, 보다 개인화된 경험을 제공하고자 합니다.\n\n업데이트된 카테고리 기능은 오늘부터 사용 가능하며, 앱을 최신 버전으로 업데이트하여 새로운 기능을 경험해 보세요.\n\n추가된 카테고리와 사용 방법에 대한 자세한 정보는 앱의 도움말 섹션에서 확인하실 수 있습니다.',
      '2024년 이벤트 구독 기능 업데이트':
          '오는 2024년, 저희 서비스의 이벤트 구독 기능이 새롭게 업데이트됩니다.\n\n새로운 구독 기능을 통해 사용자는 자신이 관심 있는 이벤트를 더 쉽고 편리하게 추적하고, 이벤트 알림을 받을 수 있습니다.\n\n또한, 이벤트 참여 과정을 더욱 간소화하여 사용자 경험을 개선하고자 합니다.\n\n이번 업데이트에는 사용자 맞춤형 알림 설정 기능도 포함되어, 사용자는 원하는 이벤트 정보만을 선택적으로 받아볼 수 있습니다.\n\n업데이트된 기능은 내년 초부터 서비스에 적용되며, 모든 등록 사용자에게 자동으로 제공됩니다.\n\n업데이트에 대한 자세한 소개와 이용 방법은 곧 공지될 예정이니, 많은 관심 부탁드립니다.',
      '시스템 유지보수 작업 안내':
          '안녕하세요, 사용자 여러분.\n\n오는 5월 20일 금요일 저녁 8시부터 10시까지 시스템 유지보수 작업이 예정되어 있습니다.\n\n이 시간 동안 일부 서비스 접속이 제한될 수 있으니 양해 부탁드립니다.\n\n불편을 최소화하기 위해 최선을 다하겠습니다.',
      '새로운 기능 업데이트 소식':
          '저희 서비스의 새로운 기능 업데이트가 완료되었습니다.\n\n이번 업데이트에는 사용자 편의성을 대폭 향상시킬 여러 가지 기능들이 포함되어 있습니다.\n\n업데이트 내용을 확인하시고, 더욱 개선된 서비스를 경험해 보세요.',
      '개인정보 처리방침 변경 안내':
          '사용자의 개인정보 보호를 위해 개인정보 처리방침이 변경되었습니다.\n\n변경된 내용은 주로 사용자의 데이터 관리 및 보호를 강화하는 데 초점을 맞추었습니다.\n\n자세한 내용은 홈페이지에서 확인하실 수 있습니다.',
      '신규 매장 오픈 안내':
          '새로운 지점이 오는 6월 1일에 오픈합니다.\n\n많은 관심과 참여 부탁드리며, 오픈 당일 방문하시는 고객님들께 특별 할인 혜택을 제공할 예정입니다.\n\n위치와 시간은 홈페이지에서 자세히 안내드리겠습니다.',
      '긴급 보안 업데이트 안내':
          '최근 발견된 보안 취약점을 해결하기 위해 긴급 업데이트를 진행하였습니다.\n\n모든 사용자는 가급적 빠른 시간 내에 업데이트를 실행하여 주시기 바랍니다.\n\n업데이트 방법은 이메일과 웹사이트를 통해 상세히 안내해 드리겠습니다',
      '이용 약관 변경 사전 안내':
          '이용 약관이 새롭게 개정되어, 다음 달부터 적용될 예정입니다.\n\n변경되는 주요 내용에 대해 사전에 안내해 드리니, 서비스 이용에 참고하시기 바랍니다.\n\n개정된 약관은 웹사이트를 통해 확인 가능합니다.',
      '모바일 앱 크래시 이슈 수정 완료':
          '일부 사용자에게서 보고된 모바일 앱 크래시 문제를 해결하기 위한 업데이트가 완료되었습니다.\n\n이번 업데이트를 통해 문제가 해결되었음을 확인하였으며, 앱을 최신 버전으로 업데이트하시길 바랍니다.',
      '고객 지원 센터 운영 시간 변경 안내':
          '고객 지원 센터의 운영 시간이 변경되어 알려드립니다.\n\n새로운 운영 시간은 월요일부터 금요일, 오전 9시부터 오후 6시까지입니다.\n\n변경된 운영 시간에 맞춰 문의해 주시기 바랍니다.',
      '"환불 정책 업데이트 안내':
          '보다 명확한 서비스 이용을 도모하기 위해 환불 정책을 업데이트하였습니다.\n\n변경된 환불 정책은 즉시 효력을 발생하며, 자세한 내용은 공식 웹사이트에서 확인 가능합니다.',
      '주요 서비스 점검 안내':
          '서비스의 안정성을 보장하기 위해 정기적인 점검을 실시합니다.\n\n점검 시간 동안 서비스 이용에 일부 제약이 있을 수 있으니 이점 양해 부탁드립니다.\n\n점검 일정은 웹사이트를 통해 사전에 공지됩니다.',
    };

    final notifications = notificationData.keys
        .mapIndexed(
          (index, element) => NotificationModel(
            id: index.toString(),
            title: element,
            description: notificationData[element]!,
            createAt: DataUtils.getRandomDateTime(dividerAt: DateTime.now()),
          ),
        )
        .toList();

    state = notifications.sorted((a, b) => b.createAt.compareTo(a.createAt));
  }
}
