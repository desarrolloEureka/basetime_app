List<List<T>> splitList<T>(List<T> list, int chunkSize) {
  return List.generate(
    (list.length / chunkSize).ceil(),
    (i) => list.sublist(
      i * chunkSize,
      (i + 1) * chunkSize > list.length ? list.length : (i + 1) * chunkSize,
    ),
  );
}
