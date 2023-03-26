import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int count = 0;

  TextEditingController _controller = TextEditingController();
  String date = '';

  List _taskData = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My First App'),
      ),
      body: ListView.builder(
          itemCount: _taskData.length,
          itemBuilder: (context, index) {
            return Container(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ListTile(
                    title: Text('Task Title'),
                    subtitle: Text('${_taskData[index]['title']}'),
                  ),
                  ListTile(
                    title: Text('Task Date'),
                    subtitle: Text('${_taskData[index]['date']}'),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton.icon(
                            icon: Icon(
                              Icons.delete,
                              color: Colors.white,
                            ),
                            style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all(Colors.red)),
                            onPressed: () {
                              setState(() {
                                _taskData.removeAt(index);
                              });
                            },
                            label: Text('Delete')),
                      ),
                      Expanded(
                        child: ElevatedButton.icon(
                            icon: Icon(
                              Icons.edit,
                              color: Colors.white,
                            ),
                            style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all(
                                    Color(0xFF363EF6))),
                            onPressed: () {
                              _controller.text = _taskData[index]['title'];
                              date = _taskData[index]['date'];
                              showModalBottomSheet(
                                  context: context,
                                  builder: (context) {
                                    return StatefulBuilder(
                                        builder: (context, newState) {
                                      return Container(
                                        padding: EdgeInsets.all(15),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAx isAlignment.start,
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text('Edit task data'),
                                                IconButton(
                                                    onPressed: () {
                                                      Navigator.of(context)
                                                          .pop();
                                                    },
                                                    icon: Icon(Icons.close))
                                              ],
                                            ),
                                            SizedBox(
                                              height: 30,
                                            ),
                                            TextFormField(
                                              controller: _controller,
                                              decoration: InputDecoration(
                                                  labelText: 'Enter task title',
                                                  border: OutlineInputBorder()),
                                            ),
                                            SizedBox(
                                              height: 20,
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      'Select Date',
                                                      style: TextStyle(
                                                          fontSize: 20,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                    SizedBox(
                                                      height: 5,
                                                    ),
                                                    Text(date.isEmpty
                                                        ? 'Please pick the date'
                                                        : date)
                                                  ],
                                                ),
                                                ElevatedButton(
                                                    onPressed: () async {
                                                      // condition ? true execution : false execution
                                                      var datePicked =
                                                          await showDatePicker(
                                                              context: context,
                                                              initialDate: DateTime
                                                                  .now(),
                                                              firstDate:
                                                                  DateTime
                                                                      .now(),
                                                              lastDate:
                                                                  DateTime(
                                                                      4000));
                                                      if (datePicked != null) {
                                                        newState(() {
                                                          date = DateFormat(
                                                                  'dd/MM/yyyy')
                                                              .format(
                                                                  datePicked);
                                                        });
                                                        // print(date);
                                                      }
                                                    },
                                                    child: Text('Pick Date'))
                                              ],
                                            ),
                                            SizedBox(
                                              height: 25,
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              children: [
                                                TextButton(
                                                    onPressed: () {
                                                      newState(() {
                                                        date = '';
                                                      });
                                                      _controller.clear();
                                                    },
                                                    child: Text('Cancel')),
                                                SizedBox(
                                                  width: 5,
                                                ),
                                                TextButton(
                                                    onPressed: () {
                                                      String taskTitle =
                                                          _controller.text
                                                              .trim();
                                                      String datePicked = date;

                                                      if (taskTitle.length >=
                                                              3 &&
                                                          datePicked
                                                              .isNotEmpty) {
                                                        Map taskMapData = {
                                                          'title': taskTitle,
                                                          'date': datePicked
                                                        };

                                                        setState(() {
                                                          _taskData[index] =
                                                              taskMapData;
                                                        });
                                                        _controller.clear();
                                                        newState(() {
                                                          date = '';
                                                        });

                                                        Navigator.of(context)
                                                            .pop();
                                                        print(_taskData);
                                                      } else {
                                                        if (taskTitle.length <
                                                            3) {
                                                          if (taskTitle
                                                              .isEmpty) {
                                                            Fluttertoast.showToast(
                                                                msg:
                                                                    'Task title is required');
                                                          } else {
                                                            Fluttertoast.showToast(
                                                                msg:
                                                                    'Task title should be of atleast 3 characters');
                                                          }
                                                        } else {
                                                          Fluttertoast.showToast(
                                                              msg:
                                                                  'Date is required');
                                                        }
                                                      }
                                                    },
                                                    child: Text('Submit')),
                                              ],
                                            )
                                          ],
                                        ),
                                      );
                                    });
                                  });
                            },
                            label: Text(
                              'Edit',
                            )),
                      )
                    ],
                  )
                ],
              ),
              decoration: BoxDecoration(color: Colors.white, boxShadow: [
                BoxShadow(
                    offset: Offset(0, 4),
                    blurRadius: 4,
                    color: Colors.black.withOpacity(0.25))
              ]),
              margin: EdgeInsets.only(left: 20, right: 20, top: 20),
              width: MediaQuery.of(context).size.width,
            );
          }),
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () {
            showModalBottomSheet(
                context: context,
                builder: (context) {
                  return StatefulBuilder(builder: (context, newState) {
                    return Container(
                      padding: EdgeInsets.all(15),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Enter task data'),
                              IconButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  icon: Icon(Icons.close))
                            ],
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          TextFormField(
                            controller: _controller,
                            decoration: InputDecoration(
                                labelText: 'Enter task title',
                                border: OutlineInputBorder()),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Select Date',
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Text(date.isEmpty
                                      ? 'Please pick the date'
                                      : date)
                                ],
                              ),
                              ElevatedButton(
                                  onPressed: () async {
                                    // condition ? true execution : false execution
                                    var datePicked = await showDatePicker(
                                        context: context,
                                        initialDate: DateTime.now(),
                                        firstDate: DateTime.now(),
                                        lastDate: DateTime(4000));
                                    if (datePicked != null) {
                                      newState(() {
                                        date = DateFormat('dd/MM/yyyy')
                                            .format(datePicked);
                                      });
                                      // print(date);
                                    }
                                  },
                                  child: Text('Pick Date'))
                            ],
                          ),
                          SizedBox(
                            height: 25,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              TextButton(
                                  onPressed: () {
                                    newState(() {
                                      date = '';
                                    });
                                    _controller.clear();
                                  },
                                  child: Text('Cancel')),
                              SizedBox(
                                width: 5,
                              ),
                              TextButton(
                                  onPressed: () {
                                    String taskTitle = _controller.text.trim();
                                    String datePicked = date;

                                    if (taskTitle.length >= 3 &&
                                        datePicked.isNotEmpty) {
                                      Map taskMapData = {
                                        'title': taskTitle,
                                        'date': datePicked
                                      };

                                      setState(() {
                                        _taskData.insert(0, taskMapData);
                                      });
                                      _controller.clear();
                                      newState(() {
                                        date = '';
                                      });

                                      Navigator.of(context).pop();
                                      print(_taskData);
                                    } else {
                                      if (taskTitle.length < 3) {
                                        if (taskTitle.isEmpty) {
                                          Fluttertoast.showToast(
                                              msg: 'Task title is required');
                                        } else {
                                          Fluttertoast.showToast(
                                              msg:
                                                  'Task title should be of atleast 3 characters');
                                        }
                                      } else {
                                        Fluttertoast.showToast(
                                            msg: 'Date is required');
                                      }
                                    }
                                  },
                                  child: Text('Submit')),
                            ],
                          )
                        ],
                      ),
                    );
                  });
                });
          }),
    );
  }
}
