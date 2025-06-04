double avg(List<int> values) {
  final sum = values.reduce((a, b) => a + b);
  final result = sum / values.length;
  return result;
}
