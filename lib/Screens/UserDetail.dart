
import 'package:anitask/Helper/Colors.dart';
import 'package:anitask/Helper/size_config.dart';
import 'package:anitask/Helper/utilities.dart';
import 'package:anitask/Models/GetUserList.dart';
import 'package:anitask/Widgets/customtext.dart';
import 'package:flutter/material.dart';

class UserDetail extends StatefulWidget {
  GetUserDetiails userDetiails = GetUserDetiails();
  UserDetail({Key? key,required this.userDetiails}) : super(key: key);

  @override
  State<UserDetail> createState() => _UserDetailState();
}

class _UserDetailState extends State<UserDetail> {

  String getaddress({String? add1, String? add2, String? add3,String? pincode}) {

    String address1 = "",
        address2 = "",
        address3 = "",
        strpincode = "",
        fulladdress = "";

    if (add1 != null && add1.isNotEmpty && add1 != "null") {
      address1 = add1 + ",";
    }
    if (add2 != null && add2.isNotEmpty && add2 != "null") {
      address2 = add2 + ",";
    }
    if (add3 != null && add3.isNotEmpty && add3 != "null") {
      address3 = add3 + ",";
    }
    if (pincode != null && pincode.isNotEmpty && pincode != "null") {
      strpincode = pincode +".";
    }

    fulladdress = address1  + address2 + address3 + strpincode;

    if (fulladdress == "") {
      return "-Not added-";
    } else {
      return fulladdress;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Profile"),
        centerTitle: true,
        backgroundColor: primaryColor,elevation: 0,),
      body: SingleChildScrollView(
        child: Container(
          width: SizeConfig.blockSizeHorizontal!*100,
          padding: const EdgeInsets.symmetric(horizontal: 22.0),
          child: Column(
            children: [
              SizedBox(height: SizeConfig.blockSizeVertical!*3.5),
              Center(
                child: Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                        color: primaryColor,
                        width: 2.5
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Container(
                      clipBehavior: Clip.hardEdge,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                          color: secondaryColor
                      ),
                      height: 120,
                      width: 120,
                      child: widget.userDetiails.profileImage != null
                          ? FadeInImage(image: NetworkImage(widget.userDetiails.profileImage!) ,fit: BoxFit.cover, placeholder: AssetImage(placeholder))
                          : Container(
                          child : Center(child: Icon(Icons.person,color: primaryColor,size: 80,))),
                    ),
                  ),
                ),
              ),
              SizedBox(height: SizeConfig.blockSizeVertical!*2),
              Text(widget.userDetiails.name!,style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20
              ),),
              SizedBox(height: SizeConfig.blockSizeVertical!*1.5),
              Text(widget.userDetiails.email!,style: TextStyle(
                  fontSize: 14
              ),),
              SizedBox(height: SizeConfig.blockSizeVertical!*3),
              Divider(color: Colors.black12,thickness: 1,),
              SizedBox(height: SizeConfig.blockSizeVertical!*3),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomText(text: 'Website',),
                  CustomText(text: widget.userDetiails.website != null ? '${widget.userDetiails.website}' : '-No results-',)
                ],),
              SizedBox(height: SizeConfig.blockSizeVertical!*3),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomText(text: 'Phone',),
                  CustomText(text: widget.userDetiails.phone != null ? '${widget.userDetiails.phone}' : '-No results-',)
                ],),
              SizedBox(height: SizeConfig.blockSizeVertical!*3),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 1,
                    child: CustomText(
                        text: 'Address',

                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        CustomText(text: getaddress(
                          add1: widget.userDetiails.address!.street.toString(),
                          add2: widget.userDetiails.address!.suite.toString(),
                          add3: widget.userDetiails.address!.city.toString(),
                          pincode: widget.userDetiails.address!.zipcode.toString(),
                        ),textAlign: TextAlign.right,
                          height: 1.5,
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
