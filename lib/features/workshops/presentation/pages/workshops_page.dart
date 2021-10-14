import 'package:flutter/material.dart';
import 'package:workshops/features/workshops/presentation/controller/workshops_controller.dart';
import '../states/workshops_states.dart';
import 'package:workshops/features/workshops/presentation/widgets/mini_worshop_card.dart';
import 'package:workshops/injection_container.dart';

class WorkshopsPage extends StatefulWidget {
  @override
  _WorkshopsPageState createState() => _WorkshopsPageState();
}

class _WorkshopsPageState extends State<WorkshopsPage> {
  final WorkshopsPageController workshopsPageController =
      WorkshopsPageController(
          getMiniWorkshops: sl(),
          workshopsNotifier: ValueNotifier(WorkshopsStates.loading));

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/background.jpg"),
          fit: BoxFit.cover,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.black45,
          title: Text("Workshops"),
          centerTitle: true,
        ),
        body: ValueListenableBuilder(
          valueListenable: workshopsPageController.workshopsNotifier,
          builder: (context, WorkshopsStates workshopsStates, __) {
            switch (workshopsStates) {
              case WorkshopsStates.loading:
                {
                  return Center(
                    child: Text("loading....."),
                  );
                }
              case WorkshopsStates.error:
                {
                  return Center(
                    child: Text("error....."),
                  );
                }
              case WorkshopsStates.empty:
                {
                  return Center(
                    child: Text("empty....."),
                  );
                }
              case WorkshopsStates.loaded:
                {
                  return Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: ListView.builder(
                      itemCount:
                          workshopsPageController.miniWorkshopList.length,
                      itemBuilder: (context, index) {
                        return MiniWorkshopCard(miniWorkshop: workshopsPageController
                            .miniWorkshopList[index],);
                      },
                    ),
                  );
                }
              default:
                return Container();
            }
          },
        ),
      ),
    );
  }
}
