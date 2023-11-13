class SearchModel
{
  bool status;
  Data data;

  SearchModel.fromJson(Map<String, dynamic> json)
  {
    status = json['status'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }
}

class Data
{
  int currentPage;
  List<Product> data;
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
      data = new List<Product>();
      json['data'].forEach((value)
      {
        data.add(new Product.fromJson(value));
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