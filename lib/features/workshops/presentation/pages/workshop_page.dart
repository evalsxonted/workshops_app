import 'package:flutter/material.dart';
import 'package:workshops/features/workshops/presentation/controller/workshop_controller.dart';
import 'package:workshops/features/workshops/presentation/states/workshop_states.dart';
import 'package:workshops/features/workshops/presentation/widgets/certificate_available.dart';
import 'package:workshops/features/workshops/presentation/widgets/contact_us.dart';
import 'package:workshops/features/workshops/presentation/widgets/fees.dart';
import 'package:workshops/features/workshops/presentation/widgets/location_icon.dart';
import 'package:workshops/features/workshops/presentation/widgets/start_end_dates.dart';
import 'package:workshops/injection_container.dart';

class WorkshopPage extends StatefulWidget {
  final String workshopId;

  const WorkshopPage({Key key, this.workshopId}) : super(key: key);

  @override
  _WorkshopPageState createState() => _WorkshopPageState();
}

class _WorkshopPageState extends State<WorkshopPage> {
  WorkshopPageController workshopPageController;

  @override
  void initState() {
    workshopPageController = WorkshopPageController(
        workshopsNotifier: ValueNotifier(WorkshopStates.loading),
        getWorkshop: sl(),
        workshopId: widget.workshopId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/background.jpg"),
          fit: BoxFit.cover,
        ),
      ),
      child: ValueListenableBuilder(
        valueListenable: workshopPageController.workshopsNotifier,
        builder: (context, WorkshopStates state, child) {
          switch(state){
            case WorkshopStates.loading: {
              return Scaffold(
                backgroundColor: Colors.transparent,
                appBar: AppBar(
                  backgroundColor: Colors.black45,
                ),
                body: Center(
                  child: Text("loading...", style: TextStyle(backgroundColor: Colors.white),),
                ),
              );
            }
            case WorkshopStates.empty: {
              return Scaffold(
                backgroundColor: Colors.transparent,
                appBar: AppBar(
                  backgroundColor: Colors.black45,
                ),
                body: Center(
                  child: Text("not available...", style: TextStyle(backgroundColor: Colors.white),),
                ),
              );
            }
            case WorkshopStates.error: {
              return Scaffold(
                backgroundColor: Colors.transparent,
                appBar: AppBar(
                  backgroundColor: Colors.black45,
                ),
                body: Center(
                  child: Text("error...", style: TextStyle(backgroundColor: Colors.white),),
                ),
              );
            }
            case WorkshopStates.loaded: {
              return Scaffold(
                backgroundColor: Colors.transparent,
                appBar: AppBar(
                  backgroundColor: Colors.black87,
                  title: Text(workshopPageController.workshop.title),
                  centerTitle: true,
                ),
                body: Column(
                  children: [
                    Image.network(
                      workshopPageController.workshop.image,
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height * 0.3,
                      fit: BoxFit.fitWidth,
                    ),
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          color: Color(0xffF4D6CC),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        margin: EdgeInsets.all(10),
                        padding: EdgeInsets.all(10),
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              Text(
                                workshopPageController.workshop.description,
                                style: TextStyle(fontSize: 22),
                              ),
                              StartEndDates(
                                startDate: workshopPageController.workshop.startDate
                                    .substring(0, 10),
                                endDate: workshopPageController.workshop.endDate
                                    .substring(0, 10),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Certificate(
                                    certificate:
                                    workshopPageController.workshop.certificate,
                                  ),
                                  LocationIcon(
                                    location:
                                    workshopPageController.workshop.location,
                                  ),
                                  Fees(
                                    fees: workshopPageController.workshop.fees,
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Text("لمزيد من التفاصيل اتصل بنا"),
                              SizedBox(
                                height: 10,
                              ),
                              ContactUS(
                                email: workshopPageController.workshop.email,
                                phone: workshopPageController.workshop.phone,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }
            default : {
              return Center(
                child: Text("loading...", style: TextStyle(backgroundColor: Colors.white),),
              );
            }
          }

        },
      ),
    );
  }
}
