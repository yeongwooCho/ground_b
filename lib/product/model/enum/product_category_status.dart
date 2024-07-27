enum ProductCategoryStatus {
  man('남성의류'),
  woman('여성의류'),
  outer('아우터'),
  miscellaneous('패션잡화');

  const ProductCategoryStatus(this.label);

  final String label;
}