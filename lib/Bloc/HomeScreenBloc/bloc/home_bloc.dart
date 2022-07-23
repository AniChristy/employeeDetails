import 'dart:convert';

import 'package:anitask/Models/GetUserList.dart';
import 'package:anitask/network/apiService.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {

  ApiService apiService = ApiService();
  List<GetUserDetiails> userList = [];
  bool gotResponse = false;
  TextEditingController searchController = TextEditingController();

  HomeBloc() : super(HomeInitial()) {
    on<HomeEvent>((event, emit) async {

      final SharedPreferences prefs = await SharedPreferences.getInstance();

      if(event is GetUserlDetailsEvent){

        print('home screen initiated');


        if(prefs.getInt("oneTimeLogin") != 1){

          await apiService.getUserDetails().then((value) async {

            if (value.model != null) {

              prefs.setInt("oneTimeLogin", 1);

              gotResponse = true;

              userList.clear();
              userList.addAll(value.model!);

              prefs.setString('userDetails', jsonEncode(userList));

            }

            emit(GotUserDetailsState());


          }, onError: (error) {
            print(error);
          });

        }else{

          String userDetailsString = prefs.getString('userDetails')!;
          var tagsJson = jsonDecode(userDetailsString);
          List<dynamic> dynamicArray = List.from(tagsJson);

          for(int i=0 ; i<dynamicArray.length ; i++){

            Address address = Address();
            address.street = dynamicArray[i]['address']['street'].toString();
            address.suite = dynamicArray[i]['address']['suite'].toString();
            address.city = dynamicArray[i]['address']['city'].toString();
            address.zipcode = dynamicArray[i]['address']['zipcode'].toString();

            Company company = Company();
            bool flag = false;

            if(dynamicArray[i]['company'] != null){
              flag = true;
              company.name = dynamicArray[i]['company']['name'].toString();
              company.catchPhrase = dynamicArray[i]['company']['catchPhrase'].toString();
              company.bs = dynamicArray[i]['company']['bs'].toString();
            }

            userList.insert(i, GetUserDetiails(
                id: dynamicArray[i]['id'] ,
                name: dynamicArray[i]['name'].toString(),
                profileImage: dynamicArray[i]['profile_image'],
                phone: dynamicArray[i]['phone'].toString(),
                email: dynamicArray[i]['email'].toString(),
                website: dynamicArray[i]['website'].toString(),
                address: address,
                company: flag ? company : null

            ));

          }

          gotResponse = true;

          emit(GotUserDetailsState());

        }


      }


    });
  }
}
