import 'dart:collection';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:notex/api_helper/FirbaseHelper.dart';
import 'package:notex/providers/HomeScreenProvider.dart';
import 'package:notex/utils/ColorsHelper.dart';
import 'package:notex/utils/NavigatorRoutes.dart';
import 'package:notex/utils/ProgressDialog.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return HomeScreenState();
  }
}

class HomeScreenState extends State<HomeScreen> {
  RefreshController _refreshController=RefreshController(
    initialRefresh: true
  );
  DataSnapshot dataSnapshot;
  List<String> items=List();
    final _myListViewKey=GlobalKey<AnimatedListState>();

  @override
  void initState() {
    super.initState();
    onRefresh();

    // ProgressDialog.instanst.showProgress(context);

  }
  void onRefresh()async{
     await FirebaseHelper.instance.getAllNotes().then((data) =>
    {
      dataSnapshot = data,
      _refreshController.refreshCompleted(),
    });
      setDatatoList();
    // if failed,use refreshFailed()

  }
  void setDatatoList(){
    items.clear();

      (dataSnapshot.value as Map).forEach((k,v)=>{
        items.add(v.toString()),

      });
      setState(() {
        
      });

  }
  void onLoading()async{
    // if failed,use loadFailed(),if no data return,use LoadNodata()
  //  items.add((items.length+1).toString());

    if(mounted)
      setState(() {

      });
    _refreshController.loadComplete();
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
          child: SmartRefresher(
            enablePullDown: true,
            header: WaterDropMaterialHeader(distance: 40,backgroundColor: Colors.blueAccent,),
            controller: _refreshController,
            onLoading: onLoading,
            onRefresh: onRefresh,
              child: ListView.separated(
                key: _myListViewKey ,
                padding: EdgeInsets.only(right: 20,top: 10, bottom: 10),
                itemBuilder: (x, postion) => getRowWidget(postion),
                separatorBuilder: (e, h) => SizedBox(height: 10),
                itemCount: items.length),
          )),
      floatingActionButton: FloatingActionButton(
        onPressed: () => {
              NavigatorRoutes.toAddnotes(context),
            },
        backgroundColor: AppColors.primaryColor,
        child: Icon(Icons.add),
      ),
    );
  }

  getRowWidget(int postion) {
    return Slidable(
      actionPane: SlidableDrawerActionPane(),
      secondaryActions: <Widget>[
        IconSlideAction(
          icon: Icons.delete,
          color: Colors.red,

        )
      ],
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
                    items[postion],
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
                    child: Text( items[postion].substring(0,1),
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
    //ProgressDialog.instanst.showProgress(context);
    return ChangeNotifierProvider(
      builder: (context) => HomeScreenProvider(),
      child: HomeScreen(),

    );
  }
}
