import 'package:flutter_app1/model_shop_app/search_model.dart';
import 'package:flutter_app1/shop_app/consistant.dart';
import 'package:flutter_app1/shop_app/network/end_points/end_points.dart';
import 'package:flutter_app1/shop_app/network/remote/dio_helper.dart';
import 'package:flutter_app1/shop_app/search/cubit/states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchCubit extends Cubit<SearchStates>
{
  SearchCubit() : super(SearchInitialStates());

  static SearchCubit get(context) => BlocProvider.of(context);

  SearchModel model;

  void search(String text)
  {
    emit(SearchLoadingStates());
    DioHelper.postData(
        url: SEARCH,
        token: token,
        data: {
          'text' : text,
        }
    ).then((value) {
      model = SearchModel.fromJson(value.data);
      emit(SearchSuccessStates());
    }).catchError((error) {
      print(error.toString());
      emit(SearchErrorStates());
    });
  }
}