import 'package:flutter/material.dart';
import 'package:workshops/features/workshops/presentation/controller/admin_controller.dart';
import 'package:workshops/features/workshops/presentation/widgets/admin_input.dart';
import 'package:workshops/features/workshops/presentation/widgets/date_input.dart';

class AddTab extends StatelessWidget {
  final AdminController adminController;
  const AddTab({Key key, this.adminController}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.only(top: 10),
      child: Column(
        children: [
          AdminInput(
            hintText: "عنوان الورشة",
            controller: adminController.titleController,
          ),
          AdminInput(
            hintText: "تفاصيل الورشة",
            controller: adminController.descriptionController,
          ),
          AdminInput(
            hintText: "مسؤول الورشة",
            controller: adminController.providerController,
          ),
          AdminInput(
            hintText: " مكان الورشة",
            controller: adminController.locationController,
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: ValueListenableBuilder(valueListenable: adminController.freeFeeNotifier, builder: (context, freeFee, child) {
              return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Checkbox(value: freeFee, onChanged:(value) {
                        adminController.freeFeeNotifier.value = !freeFee;
                      },),
                      child,
                    ],
                  );
            }, child: Text("ورشة مجانية"),),
          ),
          AdminInput(
            hintText: "سعر الاشتراك",
            controller: adminController.feesController,
          ),
          AdminInput(
            hintText: "رقم الهاتف",
            controller: adminController.phoneController,
          ),
          AdminInput(
            hintText: "البريد االالكتروني",
            controller: adminController.emailController,
          ),
          Padding(
            padding: EdgeInsets.all(10),
            child: Row(
              children: [
                IconButton(
                  icon: Icon(Icons.add_box),
                  onPressed: (){
                    adminController.addImage();
                  },
                ),
                Text(adminController.image == null ? "اضافة صورة" : "تم اختيار الصورة", style: TextStyle(fontSize: 22),),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: ValueListenableBuilder(valueListenable: adminController.certificateNotifier, builder: (context, certificate, child) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Checkbox(value: certificate, onChanged:(value) {
                    adminController.certificateNotifier.value = !certificate;
                  },),
                  Text("شهادة مشاركة"),
                ],
              );
            }, child: Text("شهادة مشاركة"),),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              MyDateInput(
                buttonText: 'وقت البدأ',
                onDateSelected: (DateTime date){
                  adminController.startDate = date.toIso8601String();
                },
              ),
              MyDateInput(
                buttonText: 'وقت الانتهاء',
                onDateSelected: (DateTime date){
                  adminController.endDate = date.toIso8601String();
                },
              ),
            ],
          ),
          InkWell(
            onTap: adminController.addWorkshop,
            child: Container(
              margin: EdgeInsets.all(15),
              padding: EdgeInsets.all(15),
              width: MediaQuery.of(context).size.width,
              alignment: Alignment.center,
              color: Colors.blue,
              child: Text( "اضافة ورشة" , style: TextStyle(fontSize: 22),),
            ),
          )
        ],
      ),
    );
  }

}
