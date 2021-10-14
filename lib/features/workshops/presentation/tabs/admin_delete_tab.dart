import 'package:flutter/material.dart';
import 'package:workshops/features/workshops/presentation/controller/admin_controller.dart';

class DeleteTab extends StatelessWidget {
  final AdminController adminController;

  const DeleteTab({Key key, this.adminController}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: adminController.initWorkshops(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return ListView.builder(
            itemCount: adminController.workshopsList.length,
            itemBuilder: (context, index) {
              return Container(
                margin: EdgeInsets.all(10),
                padding: EdgeInsets.only(right: 10, left: 10),
                decoration: BoxDecoration(
                    color: Colors.lightBlueAccent,
                    border: Border.all(color: Colors.blue)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      adminController.workshopsList[index].title,
                      style: TextStyle(fontSize: 18),
                    ),
                    IconButton(
                        icon: Icon(Icons.delete_outline),
                        onPressed: () {
                          adminController.deleteWorkshop(
                              adminController.workshopsList[index].id);
                        })
                  ],
                ),
              );
            },
          );
        } else {
          return Text(
            "loading workshops....",
            style: TextStyle(fontSize: 18),
          );
        }
      },
    );
  }


}
