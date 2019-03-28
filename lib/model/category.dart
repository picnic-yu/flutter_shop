class CategoryBigModel {
  String mallCategoryId;
  String mallCategoryName;
  List<dynamic> bxMallSubDto;
  String image;
  Null comments;


  CategoryBigModel({
    this.mallCategoryId,
    this.mallCategoryName,
    this.comments,
    this.image,
    this.bxMallSubDto
  });


  factory CategoryBigModel.fromJson(dynamic json){
    return CategoryBigModel(
      mallCategoryId: json['mallCategoryId'],
      mallCategoryName: json['mallCategoryName'],
      comments: json['comments'],
      image: json['image'],
      bxMallSubDto: json['bxMallSubDto']
    );
  }
}


class CategoryBigListModel {
  List<CategoryBigModel> data;
  CategoryBigListModel(this.data);
  factory CategoryBigListModel.formJson(List json){
    return CategoryBigListModel(
      json.map((i)=>CategoryBigModel.fromJson((i))).toList()
    );
  }
}