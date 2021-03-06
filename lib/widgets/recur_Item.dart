import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/recur_list_model.dart';
import '../models/task.dart';


class RecurItem extends StatelessWidget {
  // This class creates a todoItem, including its properties
  final Task task;

  // the constuctor for a recurItem that requires a task
  RecurItem({@required this.task}); 

  @override
  Widget build(BuildContext context) {
    // this builds an icon button that prompts an alert that
    // will be used to delete/remove a recur/task item
    return new ListTile(
        leading: IconButton(
          onPressed: () => _promptRemoveRecur(context),
          icon: Icon(Icons.close),
          color: Colors.red,
        ),
        title: Text(task.name, style: TextStyle(
            fontSize: 18.7,)
        )
    );
  }

  void _promptRemoveRecur(BuildContext context) {
    // Creates a prompt with an alert message in a new page, which results in either
    // the cancellation of the removal or the removal of the intended/pressed task
    // from the todoItems list using removeTodo method in TodoModel class with
    // the aid of Provider as a mocked class while popping the alert/prompt page
    showDialog(context: context, builder: (BuildContext context) {
      return new AlertDialog(
        title: new Text('Delete "${task.name}" ?'),
        content: Text('This will remove all recurances of "${task.name}"'),
        actions: <Widget>[
          new FlatButton(onPressed: () => Navigator.of(context).pop(),
            child: new Text ('Cancel')),
          new FlatButton(
            child: new Text('DELETE'),
            onPressed: () {
              Provider.of<RecurListModel>(context, listen: false).removeRecur(task);
              Navigator.of(context).pop();
            }
          )
        ]
      );
    }
    );
  }

}
