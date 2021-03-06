import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../globals.dart' as globals;
import '../models/todo_model.dart';
import '../models/recur_list_model.dart';
import 'edit_recurrence_screen.dart';

class OptionsScreen extends StatefulWidget{
  // This class creates a new options screen mutable state
  @override
  createState()=> new OptionsScreenState();
}

class OptionsScreenState extends State<OptionsScreen>{
  // This class builds the option list in a screen, including icons for
  // editRecurringTask, promptDataDelete, and a variety of user data options
  Widget _buildOptionsList(BuildContext context){
    return new ListView(
      children: <Widget>[
        ListTile(
          title: Text('Recurring Task Options:',
                  style: 
                    TextStyle(fontSize: 21,
                        fontWeight: FontWeight.w400,
                        color: Colors.black54)),
          dense: true,
          leading: Icon(Icons.assignment_turned_in, size: 30.0, color: Colors.amber),
        ),
        Card(
          child: ListTile(
            onTap: () => _editRecurringTask(),
            title: Text('Edit Recurring Tasks', 
                    style: 
                      TextStyle(fontSize: 16,
                          fontWeight: FontWeight.w300,
                          color: Colors.black87)),
            leading: Icon(Icons.add_box, color: Colors.lightBlue),
          ),
        ),
        ListTile(
          title: Text('User Data Options:',
                  style: 
                    TextStyle(fontSize: 21,
                        fontWeight: FontWeight.w400,
                        color: Colors.black54)
          ),
          dense: true,
          leading: Icon(Icons.person, size: 35.0, color: Colors.blue),
        ),
        Card(
            child: ListTile(
                onTap: () => _promptDataDelete(context),
                title: Text('Delete All User Data', 
                    style: 
                      TextStyle(fontSize: 16,
                          fontWeight: FontWeight.w300,
                          color: Colors.black87)),
              leading: Icon(Icons.delete),
            )
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    // This creates the buildOptionsList
    return new Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 66, 177, 227),
        title: Text ('Options', 
          style: 
          TextStyle(fontSize: 25,
              fontWeight: FontWeight.w500,
              color: Colors.white)),
      ),
      body: _buildOptionsList(context)
    );

  }

  void _promptDataDelete(BuildContext context){
    // This method creates a prompt alerting task deletion
    showDialog(context: context, builder: (BuildContext context) {
      return new AlertDialog(
          title: Text('Delete ALL User Data?'),
          content: Text('This will load a blank checklist'),
          actions: <Widget>[
            new FlatButton(onPressed: () => Navigator.of(context).pop(),
                child: Text ('Cancel')),
            new FlatButton(
                child: Text('DELETE ALL'),
                onPressed: () {
                  _deleteData();
                  Navigator.of(context).pop();
                }
            )
          ]
      );
    }
    );
  }

  void _deleteData() async{
    // This method deletes the pressed task
    final prefs = await SharedPreferences.getInstance();
    prefs.clear();
    globals.setDate = DateTime.now();
    Provider.of<TodoModel> (context, listen: false).refreshAll();
    Provider.of<RecurListModel> (context, listen:false).refreshAll();
    Navigator.of(context).pop();
  }

  void _editRecurringTask(){
    // This method edits the recurring task
    Navigator.of(context).push(
        new MaterialPageRoute(builder: (context) => EditRecurrenceScreen()
        )
    );
  }
}