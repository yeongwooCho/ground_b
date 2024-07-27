import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../model/enum/current_situation_status.dart';

final currentSituationSelectedProvider = StateProvider<CurrentSituationStatus>(
  (ref) => CurrentSituationStatus.productionRequest,
);

final currentSituationProvider = StateProvider<List<CurrentSituationStatus>>(
  (ref) => [
    CurrentSituationStatus.productionRequest,
    CurrentSituationStatus.requestConfirmation,
    CurrentSituationStatus.progress,
    CurrentSituationStatus.completed,
    CurrentSituationStatus.confirmation,
  ],
);
