class FavoritesModel
{
  bool status;
  Data data;

  FavoritesModel.fromJson(Map<String, dynamic> json)
  {
    status = json['status'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }
}

class Data
{
  int currentPage;
  List<FavoritesData> data;
  String firstPageUrl;
  int from;
  int lastPage;
  String lastPageUrl;
  String path;
  int perPage;
  int to;
  int total;

  Data.fromJson(Map<String, dynamic> json)
  {
    currentPage = json['currentPage'];
    if(json['data'] != null){
      data = new List<FavoritesData>();
      json['data'].forEach((value)
      {
        data.add(value);
      }
      );
    }
    firstPageUrl = json['firstPageUrl'];
    from = json['from'];
    lastPage = json['lastPage'];
    lastPageUrl = json['lastPageUrl'];
    path = json['path'];
    perPage = json['perPage'];
    to = json['to'];
    total = json['total'];
  }

}

class FavoritesData
{
  int id;
  Product product;

  FavoritesData.fromJson(Map<String, dynamic> json)
  {
    id = json['id'];
    product = json['prduct'] != null ? new Product.fromJson(json['prduct']) : null;
  }

}

class Product
{
  int id;
  dynamic price;
  dynamic oldPrice;
  int discount;
  String image;
  String name;
  String description;

  Product.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    price = json['price'];
    oldPrice = json['old_price'];
    discount = json['discount'];
    image = json['image'];
    name = json['name'];
    description = json['description'];
  }
}