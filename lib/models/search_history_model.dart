class SearchHistoryModel {
  static const tblHistory = 'SearchHistory';
  static const colId = 'id';
  static const colTitle = 'title';

  int id;
  String title;
  SearchHistoryModel({this.id, this.title});

  SearchHistoryModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
  }

  Map<String, dynamic> toJsonDB() {
    return {
      'id': id,
      'title': title,
    };
  }
}
