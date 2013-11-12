PROJECT OVERVIEW:
=================
This project contains 4 ViewControllers in total. The first ViewController contains a UITableView to display task objects.
The properties of the task model object are title, description, date and completion (YES or NO). 
In one of the ViewControllers users are be able to add Task objects. These tasks are be displayed on the tableView.
The tableView allows the deletion and reordering of tasks. Users are be able to alter the completion of a task from YES
to NO by tapping on the cell. The UITableViewCell can change color depending on its’ status completion and/or whether the task is overdue.
The tableView also has an accessory button to transition to a ViewController which displays detailed
information about the task. From the detailed information ViewController users are be able to transition to a new ViewController
which allows editing of the task. If the user edits a task this information persists using NSUserDefaults.