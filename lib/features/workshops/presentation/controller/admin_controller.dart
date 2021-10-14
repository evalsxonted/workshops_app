import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:toast/toast.dart';
import 'package:workshops/core/either/either.dart';
import 'package:workshops/core/error/failure.dart';
import 'package:workshops/core/usecase/usecase.dart';
import 'package:workshops/core/utilities/input_converter.dart';
import 'package:workshops/features/workshops/domain/entities/mini_workshop.dart';
import 'package:workshops/features/workshops/domain/entities/workshop.dart';
import 'package:workshops/features/workshops/domain/usecases/delete_workshop.dart';
import 'package:workshops/features/workshops/domain/usecases/get_mini_workshops.dart';
import 'package:workshops/features/workshops/domain/usecases/set_workshop.dart';
import 'package:workshops/features/workshops/presentation/states/admin_states.dart';
import 'package:workshops/injection_container.dart';

class AdminController {
  final ValueNotifier<AdminStates> adminStateNotifier;
  final ValueNotifier<bool> freeFeeNotifier;
  final ValueNotifier<bool> certificateNotifier;
  final TabController tabController;
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController providerController = TextEditingController();
  TextEditingController locationController = TextEditingController();
  TextEditingController feesController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  String image;
  String startDate = DateTime.now().toIso8601String();
  String endDate = DateTime.now().toIso8601String();
  List<MiniWorkshop> workshopsList;
  BuildContext context;

  AdminController(
      {this.context,
      this.adminStateNotifier,
      this.freeFeeNotifier,
      this.certificateNotifier,
      this.tabController}){
    initWorkshops();
  }

  deleteWorkshop(String workshopId) async {
    DeleteWorkshop deleteWorkshop = sl();
    bool deleted = await deleteWorkshop(workshopId);
    if (deleted) {
      Toast.show("تم حذف الورشة", context,
          duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
    }
  }
  addWorkshop() async {
    if (titleController.text.isEmpty ||
        descriptionController.text.isEmpty ||
        providerController.text.isEmpty ||
        locationController.text.isEmpty ||
        phoneController.text.isEmpty ||
        emailController.text.isEmpty ||
        (!freeFeeNotifier.value && feesController.text.isEmpty) ||
        image == null ||
        titleController.text.isEmpty) {
      Toast.show("هناك حقول فارغة", context,
          duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
      return;
    }
    InputConverter inputConverter = InputConverter();
    Either<Failure, int> feesNum =
        inputConverter.stringToUnsignedInteger(phoneController.text);
    if (feesNum.isFailed) {
      Toast.show("خطا في الادخال", context,
          duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
      return;
    }
    Either<Failure, int> phoneNum =
        inputConverter.stringToUnsignedInteger(phoneController.text);
    if (phoneNum.isFailed) {
      Toast.show("خطا في الادخال", context,
          duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
      return;
    }
    Workshop workshop = Workshop(
        image: image,
        title: titleController.text,
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        available: true,
        description: descriptionController.text,
        endDate: endDate,
        startDate: startDate,
        certificate: certificateNotifier.value,
        email: emailController.text,
        phone: phoneNum.right,
        fees: feesNum.right,
        location: locationController.text,
        provider: providerController.text);

    Toast.show("تم اضافة الورشة", context,
        duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
    SetWorkshop setWorkshop = sl();
    bool added = await setWorkshop(workshop);
    if (added) {
      Toast.show("تم اضافة الورشة", context,
          duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
    }
  }

  addImage() async {
    final pickedFile =
        await ImagePicker().getImage(source: ImageSource.gallery);
    if (pickedFile == null) {
      return;
    }
    var img = File(pickedFile.path);
    Reference storageReference = FirebaseStorage.instance.ref().child("workshops/"+
        DateTime.now().toIso8601String());
    UploadTask uploadTask = storageReference.putFile(img);
    await uploadTask.whenComplete(() async {
      String myUrl = await storageReference.getDownloadURL();
        image = myUrl;
      Toast.show("تم رفع الصورة بنجاح", context,
          duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
    });
  }

  Future initWorkshops() async {
    GetMiniWorkshops getMiniWorkshops = sl();
    Either<Failure, MiniWorkshops> result = await getMiniWorkshops(NoParams());
    if(!result.isFailed){
      workshopsList = result.right.workshops;
    }
    return true;
  }
}
