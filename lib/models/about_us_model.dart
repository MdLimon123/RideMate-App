class AboutUsModel {
  final String? pageName;
  final String? content;

  AboutUsModel({this.pageName, this.content});


  factory AboutUsModel.fromJson(Map<String, dynamic> json) {
    return AboutUsModel(
      pageName: json['page_name'],
      content: json['content'],
    );
  }


  Map<String, dynamic> toJson() {
    return {
      'page_name': pageName,
      'content': content,
    };
  }
}
