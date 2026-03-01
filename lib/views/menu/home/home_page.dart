import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:todolistapp/common/commoncolor.dart';
import 'package:todolistapp/common/routes.dart';
import 'package:todolistapp/views/menu/home/completed_task.dart';
import 'package:todolistapp/views/menu/home/progress_task.dart';
import 'package:todolistapp/views/menu/profile/settings/settings.dart';
import 'package:todolistapp/views/menu/todo/add_edit.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final currUser = FirebaseAuth.instance.currentUser!;
  int selected = 0;
  bool isGrid = false;
  @override
  Widget build(BuildContext context) {
    final List<Widget> pages = [
      ProgressTask(isGrid: isGrid), 
      CompletedTask(isGrid: isGrid)
    ];
    return SafeArea(
      child: Scaffold(
        backgroundColor: Commoncolor.black,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Commoncolor.black,
          foregroundColor: Commoncolor.white,
          title: Padding(
            padding: EdgeInsets.all(8),
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(50),
                  child: Image.network("${currUser.photoURL}",
                    fit: BoxFit.cover,
                    width: 50,
                    height: 50,
                  ),
                ),
                SizedBox(width: 5),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Welcome back, ${currUser.displayName}", 
                      style: TextStyle(
                        fontSize: 16, 
                        fontWeight: FontWeight.w700
                      ),
                    ),
                    Text(
                      DateFormat('EEEE, dd-MM-yyyy').format(DateTime.now()),
                      style: TextStyle(
                        fontSize: 16, 
                        fontWeight: FontWeight.w700
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
          actions: [
            IconButton(
              onPressed: () => push(context, Settings()), 
              icon: Icon(
                Icons.settings, 
                size: 20
              )
            ),
            IconButton(
              onPressed: (){
                setState(() {
                  isGrid = !isGrid;
                });
              }, 
              icon: Icon(
                isGrid ? Icons.grid_3x3 : Icons.list,
                size: 20,
              )
            )
          ],
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    InkWell(
                      onTap: (){
                        setState(() {
                          selected = 0;
                        });
                      },
                      child: Container(
                        height: 50,
                        width: MediaQuery.of(context).size.width / 3,
                        decoration: BoxDecoration(
                          color: selected == 0 ? Commoncolor.blue : Commoncolor.black,
                          borderRadius: BorderRadius.circular(22)
                        ),
                        child: Center(
                          child: Text(
                            "Progress",
                            style: TextStyle(
                              color: Commoncolor.white,
                              fontSize: 18
                            ),
                          ),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: (){
                        setState(() {
                          selected = 1;
                        });
                      },
                      child: Container(
                        height: 50,
                        width: MediaQuery.of(context).size.width / 3,
                        decoration: BoxDecoration(
                          color: selected == 1 ? Commoncolor.blue : Commoncolor.black,
                          borderRadius: BorderRadius.circular(22)
                        ),
                        child: Center(
                          child: Text(
                            "Completed",
                            style: TextStyle(
                              color: Commoncolor.white,
                              fontSize: 18
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 30),
                pages[selected],
              ],
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Commoncolor.blue,
          onPressed: () => push(context, AddEdit(todo: null)),
          child: Icon(
            Icons.add, 
            size: 30, 
            color: Commoncolor.white
          ),
        ),
      ),
    );
  }
}