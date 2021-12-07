import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mar_stor/modules/shop_app/setting/cubit/cubit.dart';
import 'package:mar_stor/modules/shop_app/setting/cubit/states.dart';
import 'package:mar_stor/shared/components/components.dart';
import 'package:mar_stor/shared/style/color/color.dart';


class SearchScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var formKey = GlobalKey<FormState>();
    var searchController = TextEditingController();

    return BlocProvider(
      create: (BuildContext context) => SearchCubit(),
      child: BlocConsumer<SearchCubit, SearchStates>(
        listener: (context, state) {},
        builder: (context, state) => Scaffold(
            appBar: AppBar(),
            body: Form(
              key: formKey,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    defaultFormField(
                      controller: searchController,
                      type: TextInputType.text,
                      validate: (String value) {
                        if (value.isEmpty) {
                          return 'enter text to search';
                        }
                        return null;
                      },
                      onSubmit: (String text) {
                        SearchCubit.get(context).search(text);
                      },
                      label: 'Search',
                      prefix: Icons.search,
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    if (state is SearchLoadingState) LinearProgressIndicator(),
                    SizedBox(
                      height: 10.0,
                    ),
                    if (state is SearchSuccessState)
                      Expanded(
                        child: ListView.separated(
                          itemBuilder: (context, index) => buildListProduct(
                              SearchCubit.get(context).model.data.data[index],
                              context,
                              isOldPrice: false
                          ),
                          separatorBuilder: (context, index) => myDivider(),
                          itemCount: SearchCubit.get(context).model.data.data.length,
                        ),
                      ),
                  ],
                ),
              ),
            )),
      ),
    );
  }

  Widget buildListProduct( model, context,
      {
        bool isOldPrice = true,
      }) => Padding(
    padding: const EdgeInsets.all(20.0),
    child: Container(
      height: 120.0,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            alignment: AlignmentDirectional.bottomStart,
            children: [
              Image(
                image: NetworkImage(model.image),
                height: 120.0,
                width: 120.0,
              ),
              if (model.discount != 0 && isOldPrice)
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 5.0),
                  color: Colors.red,
                  child: Text(
                    'DISCOUNT',
                    style: TextStyle(
                      fontSize: 8.0,
                      color: Colors.white,
                    ),
                  ),
                ),
            ],
          ),
          SizedBox(
            width: 20.0,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  model.name,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 14.0,
                    height: 1.3,
                  ),
                ),
                Row(
                  children: [
                    Text(
                      model.price.toString(),
                      style: TextStyle(
                        fontSize: 12.0,
                        color: defaultColor,
                      ),
                    ),
                    SizedBox(
                      width: 5.0,
                    ),
                    if (model.discount != 0 && isOldPrice)
                      Text(
                        model.oldPrice.toString(),
                        style: TextStyle(
                          fontSize: 10.0,
                          color: Colors.grey,
                          decoration: TextDecoration.lineThrough,
                        ),
                      ),
                    Spacer(),
                    // IconButton(
                    //   onPressed: () {
                    //     ShopCubit.get(context)
                    //         .changeFavorites(model.id);
                    //   },
                    //   icon: CircleAvatar(
                    //     radius: 15.0,
                    //     backgroundColor: ShopCubit.get(context).favorites[model.id]
                    //         ? defaultColor
                    //         : Colors.grey,
                    //     child: Icon(
                    //       Icons.favorite_border,
                    //       color: Colors.white,
                    //       size: 14.0,
                    //     ),
                    //   ),
                    // )
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}
