
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:workshops/features/workshops/presentation/controller/admin_controller.dart';
import 'package:workshops/features/workshops/presentation/states/admin_states.dart';
import 'package:workshops/features/workshops/presentation/tabs/admin_add_tab.dart';
import 'package:workshops/features/workshops/presentation/tabs/admin_delete_tab.dart';


class Admin extends StatefulWidget {
  @override
  _AdminState createState() => _AdminState();
}

class _AdminState extends State<Admin> with SingleTickerProviderStateMixin {
  AdminController adminController;

  @override
  void initState() {
    adminController = AdminController(
      context: context,
      adminStateNotifier: ValueNotifier(AdminStates.loading),
      freeFeeNotifier: ValueNotifier(true),
      certificateNotifier: ValueNotifier(true),
      tabController: TabController(length: 2, vsync: this),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.cyan,
        title: Text("Admin"),
        centerTitle: true,
        bottom: TabBar(
          onTap: (value) {
          },
          controller: adminController.tabController,
          tabs: [
            Tab(icon: Icon(Icons.add)),
            Tab(icon: Icon(Icons.delete)),
          ],
        ),
      ),
      body: TabBarView(
        physics: NeverScrollableScrollPhysics(),
        controller: adminController.tabController,
        children: [
          AddTab(adminController: adminController,),
          DeleteTab(adminController: adminController,),
        ],
      ),
    );
  }


}
