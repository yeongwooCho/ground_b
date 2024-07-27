enum CurrentSituationStatus {
  productionRequest('생산요청'),
  requestConfirmation('요청확인'),
  progress('제작중'),
  completed('제작완료'),
  confirmation('확정');

  const CurrentSituationStatus(this.label);

  final String label;
}
