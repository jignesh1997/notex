import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:notex/api_helper/FirbaseHelper.dart';
import 'package:notex/providers/HomeScreenProvider.dart';
import 'package:notex/utils/ColorsHelper.dart';
import 'package:notex/utils/NavigatorRoutes.dart';
import 'package:notex/utils/ProgressDialog.dart';
import 'package:provider/provider.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return HomeScreenState();
  }
}

class HomeScreenState extends State<HomeScreen> {
  DataSnapshot dataSnapshot;

  @override
  void initState() {
   // ProgressDialog.instanst.showProgress(context);

  }

  @override
  Widget build(BuildContext context) {
    //ProgressDialog.instanst.showProgress(context);
   // FirebaseHelper.instance.getAllNotes().then((data) =>
    //{ProgressDialog.instanst.dismissDialog(context), dataSnapshot = data});
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        title: Center(child: Text("Notex")),
      ),
      body: Container(
          color: Colors.deepPurple,
          child: ListView.separated(
              padding: EdgeInsets.only(top: 10, bottom: 10),
              itemBuilder: (x, postion) => getRowWidget(postion),
              separatorBuilder: (e, h) => SizedBox(height: 10),
              itemCount: 10)),
      floatingActionButton: FloatingActionButton(
        onPressed: () => {
              NavigatorRoutes.toAddnotes(context),
            },
        backgroundColor: AppColors.primaryColor,
        child: Icon(Icons.add),
      ),
    );
  }

  getRowWidget(int index) {
    return Slidable(
      secondaryActions: <Widget>[
        IconSlideAction(icon: Icons.delete_outline,color: Colors.red,)

      ],
      delegate: SlidableDrawerDelegate(),
      actionExtentRatio: 0.25,
      child: Container(
        margin: EdgeInsets.only( left: 20),
        child: Stack(
          children: <Widget>[
            Container(
              height: 80,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(10))),
              margin: EdgeInsets.only(left: 35),
              child: Container(
                  padding: EdgeInsets.all(10),
                  alignment: Alignment.centerLeft,
                  margin: EdgeInsets.only(left: 50),
                  child: Text(
                    "eksdcbsdjjjbgv",
                    style: TextStyle(fontSize: 15),
                    maxLines: 3,
                  )),
            ),
            Container(
              child: SizedBox(
                  height: 82,
                  width: 82,
                  child: CircleAvatar(
                    backgroundColor: Colors.red,
                    child: Text("A",
                        style: TextStyle(color: Colors.white, fontSize: 50)),
                  )),
            )
          ],
        ),
      ),
    );
  }
}

class HomeScreenWrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      builder: (context) => HomeScreenProvider(),
      child: HomeScreen(),
    );
  }
}
