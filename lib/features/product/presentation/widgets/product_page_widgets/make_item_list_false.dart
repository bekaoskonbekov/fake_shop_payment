void changeItemListToFalse(List<bool> array) {
  var temp = array.map((c) => false).toList();
  array.replaceRange(0, array.length, temp);
}
