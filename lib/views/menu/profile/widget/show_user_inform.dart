import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:todolistapp/common/commoncolor.dart';
import 'package:todolistapp/common/routes.dart';
import 'package:todolistapp/models/user.dart';
import 'package:todolistapp/services/firestore/user/user_services.dart';
import 'package:todolistapp/views/menu/profile/details/user_detail.dart';

class ShowUserInform extends StatefulWidget {
  const ShowUserInform({super.key});

  @override
  State<ShowUserInform> createState() => _ShowUserInformState();
}

class _ShowUserInformState extends State<ShowUserInform> {
  final services = UserServices();
  final currentUser = FirebaseAuth.instance.currentUser;
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: services.getUser(currentUser!.uid), 
      builder: (context, snapshot){
        if (!snapshot.hasData || snapshot.hasError){
          return Center(
            child: Column(
              children: [
                Icon(Icons.error,
                  size: 20,
                  color: Commoncolor.white,
                ),
                SizedBox(height: 10),
                Text("No data",
                  style: TextStyle(
                    color: Commoncolor.white,
                    fontSize: 14,
                    fontWeight: FontWeight.bold
                  ),
                )
              ],
            ),
          );
        }else if (snapshot.connectionState == ConnectionState.waiting){
          return Center(child: CircularProgressIndicator(color: Commoncolor.white));
        }else{
          List<UserModel> userList = snapshot.data!;
          return ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: userList.length,
            itemBuilder: (context, index) {
              UserModel user = userList[index];
              return GestureDetector(
                onTap: () {
                  push(context, UserDetail(user: user));
                },
                child: Container(
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: Commoncolor.black,
                    border: Border.all(color: Commoncolor.white)
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(50),
                        child: Image.network(
                          user.avatar,
                          fit: BoxFit.cover,
                          width: 50,
                          height: 50,
                        ),
                      ),
                      SizedBox(width: 15),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            user.username,
                            style: TextStyle(
                              color: Commoncolor.white,
                              fontSize: 18,
                              fontWeight: FontWeight.w700
                            ),
                          ),
                          Text(
                            user.email,
                            style: TextStyle(
                              color: Commoncolor.white,
                              fontSize: 14,
                              fontWeight: FontWeight.w400
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              );
            },
          );
        }
      }
    );
  }
}