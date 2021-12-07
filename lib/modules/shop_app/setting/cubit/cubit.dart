

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mar_stor/models/shop_app/search_model.dart';
import 'package:mar_stor/modules/shop_app/setting/cubit/states.dart';
import 'package:mar_stor/shared/components/constants.dart';
import 'package:mar_stor/shared/network/end_points.dart';
import 'package:mar_stor/shared/network/remote/dio_helper.dart';

class SearchCubit extends Cubit<SearchStates>
{
  SearchCubit() :super(SearchInitialState());

  static SearchCubit get(context) =>BlocProvider.of(context);

  SearchModel model;

  void search(String text)
  {
    emit(SearchLoadingState());
    DioHelper.postData(
        url: SEARCH,
        token: token,
        data: {
          'text' :text,
        },
    ).then((value)
    {
      model =  SearchModel.fromJson(value.data);

      emit(SearchSuccessState());
    }).catchError((error)
    {
      print(error.toString());
      emit(SearchErrorState());
    });

  }
}