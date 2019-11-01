import 'package:flutter/material.dart';
import 'package:notex/api_helper/FirbaseHelper.dart';
import 'package:notex/providers/AddNotesScreenProvider.dart';
import 'package:notex/utils/ColorsHelper.dart';
import 'package:notex/utils/ProgressDialog.dart';
import 'package:provider/provider.dart';

class AddNoteScreen extends StatefulWidget {
  AddNotesScreenProvider provider;

  @override
  State<StatefulWidget> createState() {
    return AddNoteState();
  }
}

String pushID;

class AddNoteState extends State<AddNoteScreen> {
  BuildContext _context = null;
  final noteTextController = TextEditingController();

  @override
  void initState() {
    super.initState();
    pushID = null;
  }

  @override
  Widget build(BuildContext context) {
    widget.provider = Provider.of<AddNotesScreenProvider>(context);
    this._context = context;
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Note"),
        backgroundColor: AppColors.primaryColor,
      ),
      body: Container(
        height: double.infinity,
        child: TextField(
          controller: noteTextController,
          maxLines: 100,
          textInputAction: TextInputAction.newline,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.primaryColor,
        onPressed: () => _onDoneClick(),
        child: Icon(
          Icons.done,
          color: AppColors.white,
        ),
      ),
    );
  }

  _onDoneClick() {
    widget.provider.noteText = noteTextController.text;
    ProgressDialog.instanst.showProgress(_context);
    FirebaseHelper.instance
        .insertNote(noteTextController.text, noteId: pushID)
        .then((newPushId) => {
              pushID = newPushId,
              ProgressDialog.instanst.dismissDialog(_context)
            })
        .catchError((error) => {print(error.toString())});
  }
}

// ignore: must_be_immutable
class AddNoteWrapper extends StatelessWidget {
  TextEditingController noteTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      builder: (context) => AddNotesScreenProvider(),
      child: AddNoteScreen(),
    );
  }
}
