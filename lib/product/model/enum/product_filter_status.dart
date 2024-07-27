enum ProductFilterStatus {
  recommend('추천순'),
  latest('최신순'),
  expensive('판매가높은순'),
  cheap('판매가낮은순');

  const ProductFilterStatus(this.label);

  final String label;
}
