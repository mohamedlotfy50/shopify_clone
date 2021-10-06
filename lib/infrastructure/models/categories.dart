class Categories {
  final List<String> category;
  Categories({required this.category});
  factory Categories.fromJson(List list) {
    List<String> l = [];
    list.forEach((element) {
      l.add(element as String);
    });

    return Categories(category: l);
  }
}
