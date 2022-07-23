
import 'package:anitask/Helper/Colors.dart';
import 'package:anitask/Helper/shimmer_loader.dart';
import 'package:anitask/Helper/size_config.dart';
import 'package:anitask/Helper/utilities.dart';
import 'package:anitask/Models/GetUserList.dart';
import 'package:anitask/Screens/UserDetail.dart';
import 'package:anitask/Widgets/customtext.dart';
import 'package:flutter/material.dart';

import '../Bloc/HomeScreenBloc/bloc/home_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  late HomeBloc bloc;
  bool searchTrue = true;

  @override
  void initState() {
    super.initState();
    bloc = BlocProvider.of<HomeBloc>(context);
  }

  Widget searchedList() {
    List<GetUserDetiails> searchedData = bloc.userList.where((element) {
      return element.name
          .toString()
          .toLowerCase()
          .contains(bloc.searchController.text.toLowerCase());
    }).toList();

    return searchedData.length != 0 ? Padding(
      padding: const EdgeInsets.all(8),
      child: ListView.builder(
          itemCount: searchedData.length,
          physics: BouncingScrollPhysics(),
          itemBuilder: (context, index) {
            return InkWell(
                onTap: () {

                  GetUserDetiails userDetiails = GetUserDetiails();

                  userDetiails.name = searchedData[index].name;
                  userDetiails.profileImage = searchedData[index].profileImage;
                  userDetiails.email = searchedData[index].email;
                  userDetiails.phone = searchedData[index].phone ;
                  userDetiails.website = searchedData[index].website;
                  userDetiails.address = searchedData[index].address;

                  Navigator.push(context,MaterialPageRoute(builder: (context) => UserDetail(userDetiails: userDetiails,)),);
                },
                child: Card(
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  color: Colors.white,
                  child: Container(
                      width:
                      SizeConfig.blockSizeHorizontal! * 100,
                      height:
                      SizeConfig.blockSizeVertical! * 14.5,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 15, vertical: 8),
                        child: Row(
                          children: [
                            Expanded(
                              flex: 2,
                              child: Container(
                                clipBehavior: Clip.hardEdge,
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: secondaryColor
                                ),
                                height: SizeConfig.blockSizeVertical!*8,
                                width: SizeConfig.blockSizeHorizontal! * 8,
                                child: searchedData[index].profileImage != null
                                    ? FadeInImage(image: NetworkImage(searchedData[index].profileImage!),width: SizeConfig.blockSizeHorizontal! * 30, height: SizeConfig.blockSizeVertical!*15 ,fit: BoxFit.contain,
                                  placeholder: AssetImage(placeholder),
                                  imageErrorBuilder: (context, error, stackTrace) {return Image.asset(errorImg, fit: BoxFit.contain);},)
                                    : Container(
                                    child : Center(child: Icon(Icons.person,color: primaryColor,size: 30,))
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 4,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  CustomText(text: '${searchedData[index].name}',color: primaryColor,size: 17,weight: FontWeight.w600,),
                                  CustomText(text: '${searchedData[index].email}',size: 15,),
                                  CustomText(text: searchedData[index].company != null ? '${searchedData[index].company!.name!}' : '-No Results-',size: 15,)
                                ],
                              ),
                            )

                          ],
                        ),
                      )),
                ));
          }),
    ) : Center(child: CustomText(text: 'no data matched'));
  }

  Widget UserList(){
    return Padding(
      padding: const EdgeInsets.all(8),
      child: ListView.builder(
          itemCount: bloc.userList.length,
          physics: BouncingScrollPhysics(),
          itemBuilder: (context, index) {
            return InkWell(
                onTap: () {
                  GetUserDetiails userDetiails = GetUserDetiails();

                  userDetiails.name = bloc.userList[index].name;
                  userDetiails.profileImage = bloc.userList[index].profileImage;
                  userDetiails.email = bloc.userList[index].email;
                  userDetiails.phone = bloc.userList[index].phone ;
                  userDetiails.website = bloc.userList[index].website;
                  userDetiails.address = bloc.userList[index].address;

                  Navigator.push(context,MaterialPageRoute(builder: (context) => UserDetail(userDetiails: userDetiails,)),);

                },
                child: Card(
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  color: Colors.white,
                  child: Container(
                      width:
                      SizeConfig.blockSizeHorizontal! * 100,
                      height:
                      SizeConfig.blockSizeVertical! * 14.5,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 15, vertical: 8),
                        child: Row(
                          children: [
                            Expanded(
                              flex: 2,
                              child: Container(
                                clipBehavior: Clip.hardEdge,
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: secondaryColor
                                ),
                                height: SizeConfig.blockSizeVertical!*8,
                                width: SizeConfig.blockSizeHorizontal! * 8,
                                child: bloc.userList[index].profileImage != null
                                    ? FadeInImage(image: NetworkImage(bloc.userList[index].profileImage!),width: SizeConfig.blockSizeHorizontal! * 30, height: SizeConfig.blockSizeVertical!*15 ,fit: BoxFit.contain,
                                  placeholder: AssetImage(placeholder),
                                  imageErrorBuilder: (context, error, stackTrace) {return Image.asset(errorImg, fit: BoxFit.contain);},)
                                    : Container(
                                    child : Center(child: Icon(Icons.person,color: primaryColor,size: 30,))
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 4,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  CustomText(text: '${bloc.userList[index].name}',color: primaryColor,size: 17,weight: FontWeight.w600,),
                                  CustomText(text: '${bloc.userList[index].email}',size: 15,),
                                  CustomText(text: bloc.userList[index].company != null ? '${bloc.userList[index].company!.name!}' : '-No Results-',size: 15,)
                                ],
                              ),
                            )

                          ],
                        ),
                      )),
                ));
          }),
    );
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      appBar: searchTrue
          ? AppBar(
        title: Text(
          'Employee Directory',
          style: TextStyle(fontSize: 18, color: Colors.white),
        ),
        elevation: 0,
        backgroundColor: primaryColor,
        actions: [
          IconButton(onPressed: (){
            setState(() {
              searchTrue = false;
            });
          }, icon: Icon(Icons.search,color: Colors.white,))
        ],
      )
          : AppBar(
        leadingWidth: 25,
        elevation: 0,
        backgroundColor: pageBg,
        toolbarHeight: kToolbarHeight + 20,
        centerTitle: false,
        leading: IconButton(
            icon: const Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
            ),
            onPressed: () {
              setState(() {
                searchTrue = true;
                bloc.searchController.text = "";

              });
            }),
        title: Container(
          height: SizeConfig.blockSizeVertical! * 6,
          child: TextField(
            controller: bloc.searchController,
            style: const TextStyle(height: 2),
            decoration: InputDecoration(
              prefixIcon: const Icon(
                Icons.search,
                color: Colors.black,
              ),
              suffixIcon: IconButton(
                icon: const Icon(
                  Icons.cancel_outlined,
                  color: Colors.black,
                ),
                onPressed: () {
                  bloc.searchController.clear();
                },
              ),
              filled: true,
              hintText: "Search...",
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25.0),
                  borderSide:
                  const BorderSide(color: Colors.transparent)),
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25.0),
                  borderSide:
                  const BorderSide(color: Colors.transparent)),
            ),
            onChanged: (value) {
              setState(() {

              });
            },
          ),
        ),
        iconTheme: const IconThemeData(color: Colors.black, size: 25),
      ),
      backgroundColor: pageBg,
      body: BlocListener<HomeBloc, HomeState>(
          listener: (context, state) {
            // TODO: implement listener
          },
          child: BlocBuilder<HomeBloc, HomeState>(
            builder: (context, state) {
              return bloc.gotResponse
                  ? bloc.searchController.text.length >= 1 ? searchedList () : UserList()
                  : Center(child: ShimmerList());
            },
          ),
        ));

  }
}
