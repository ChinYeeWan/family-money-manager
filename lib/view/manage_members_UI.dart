import 'package:flutter/material.dart';

import '../constants/color.dart';
import '../models/user.dart';
import '../viewmodels/base_model.dart';
import '../viewmodels/manage_members_model.dart';
import 'base_UI.dart';
import 'widget/no_member_found_widget.dart';

class ManageMembersUI extends StatelessWidget {
  final User user;
  ManageMembersUI({this.user});

  @override
  Widget build(BuildContext context) {
    return BaseUI<ManageMembersModel>(
      onModelReady: (model) => model.init(user),
      builder: (context, model, child) => Scaffold(
        appBar: AppBar(
          backgroundColor: secondary,
          title: Text('Members'),
        ),
        body: model.state == ViewState.Busy
            ? Center(child: CircularProgressIndicator())
            : getBody(context, model),
        bottomNavigationBar: InkWell(
          onTap: () => model.addMember(context),
          child: Container(
            decoration: BoxDecoration(color: secondary),
            height: 45,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.add, size: 18),
                Text('Add Member', style: TextStyle(fontSize: 18)),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget getBody(BuildContext context, model) {
    return model.members.length == 0
        ? NoMemberFoundWidget()
        : Column(children: <Widget>[
            Expanded(
              child: ListView.builder(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemCount: model.members.length,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () => Navigator.pushNamed(context, "overviewMember",
                        arguments: model.members[index]),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Card(
                        elevation: 4,
                        child: Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: ListTile(
                            leading: CircleAvatar(
                              radius: 25,
                              backgroundColor: grey,
                              child: Icon(
                                Icons.person,
                                color: white,
                              ),
                            ),
                            title: Text(model.members[index].username),
                            trailing: showPopUpMenu(context, model, index),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            )
          ]);
  }

  Widget showPopUpMenu(context, model, memberIndex) {
    return PopupMenuButton<int>(
        icon: Icon(Icons.more_vert),
        onSelected: (value) => model.selectMenu(context, value, memberIndex),
        itemBuilder: (context) => [
              PopupMenuItem(
                value: 1,
                child: Text("Copy info"),
              ),
              PopupMenuItem(
                value: 2,
                child: Text("Delete"),
              )
            ]);
  }
}
