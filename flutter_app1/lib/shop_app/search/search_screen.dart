import 'package:flutter/material.dart';
import 'package:flutter_app1/conistant/conistant.dart';
import 'package:flutter_app1/shop_app/consistant.dart';

import 'package:flutter_app1/shop_app/search/cubit/cubit.dart';
import 'package:flutter_app1/shop_app/search/cubit/states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchScreen extends StatelessWidget {

  var formKey = GlobalKey<FormState>();
  var searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => SearchCubit(),
      child: BlocConsumer<SearchCubit, SearchStates>(
        listener: (context, state) {

        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              elevation: 0.0,
              backgroundColor: Colors.white,
            ),
            body: Form(
              key: formKey,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(
                          5.0,
                        ),
                        border: Border.all(
                          color: Colors.grey,
                        ),
                      ),
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 15.0,
                        ),
                        child: TextFormField(
                          validator: (String value) {
                            if(value.isEmpty)
                            {
                              return 'enter text to search';
                            }
                            return null;
                          },
                          onChanged: (String text)
                          {
                            SearchCubit.get(context).search(text);
                          },
                          controller: searchController,
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                            labelText: 'Search',
                            prefix: Icon(
                                Icons.search,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    if(state is SearchLoadingStates)
                      LinearProgressIndicator(),
                    SizedBox(
                      height: 10.0,
                    ),
                    if(state is SearchSuccessStates)
                    Expanded(
                      child: ListView.separated(
                        itemBuilder: (context, index) => buildListProduct(SearchCubit.get(context).model.data.data[index], context, isOldPrice: false),
                        separatorBuilder: (context, index) => defaultSeparator(),
                        itemCount: SearchCubit.get(context).model.data.data.length,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      )
    );
  }
}
