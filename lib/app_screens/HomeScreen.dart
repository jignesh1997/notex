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
    super.initState();
    ProgressDialog.instanst.showProgress(context);
    FirebaseHelper.instance.getAllNotes().then((data) =>
        {ProgressDialog.instanst.dismissDialog(context), dataSnapshot = data});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        title: Center(child: Text("Notex")),
      ),
      body: Container(
          color: Colors.deepPurple,
          child: ListView.separated(
              padding: EdgeInsets.only(top: 10, bottom: 10),
              itemBuilder: (x, postion) => getRowWidget(),
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

  getRowWidget() {
    return Container(
      margin: EdgeInsets.only(right: 20, left: 20),
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
