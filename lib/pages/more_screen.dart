import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:persian_datetime_picker/persian_datetime_picker.dart';

class MoreScreen extends StatefulWidget {
  const MoreScreen({Key? key}) : super(key: key);

  @override
  _MoreScreenState createState() => _MoreScreenState();
}

class _MoreScreenState extends State<MoreScreen> {
  PickedFile? imageFile = null;

  Future<void> _showChoiceDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Row(children: const [
              Text(
                "انتخاب نوع روش",
                textDirection: TextDirection.rtl,
                style: TextStyle(color: Colors.blue),
              ),
            ],mainAxisAlignment: MainAxisAlignment.end,),
            content: Directionality(
              child: SingleChildScrollView(
                child: ListBody(
                  children: [
                    const Divider(
                      height: 1,
                      color: Colors.blue,
                    ),
                    ListTile(
                      onTap: () {
                        _openGallery(context);
                      },
                      title: const Text("گالری"),
                      leading: const Icon(
                        Icons.account_box,
                        color: Colors.blue,
                      ),
                    ),
                    const Divider(
                      height: 1,
                      color: Colors.blue,
                    ),
                    ListTile(
                      onTap: () {
                        _openCamera(context);
                      },
                      title: const Text("دوربین"),
                      leading: const Icon(
                        Icons.camera,
                        color: Colors.blue,
                      ),
                    ),
                  ],
                ),
              ),
              textDirection: TextDirection.rtl,
            )
          );
        });
  }

  String date = '';
  String time = '';

  String selectedDate = Jalali.now().toJalaliDateTime();

  @override
  void initState() {
    super.initState();
    date = 'انتخاب تاریخ';
    time = 'انتخاب ساعت';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: [
            Padding(
                padding:
                    const EdgeInsets.only(left: 16.0, right: 16.0, top: 16.0),
                child: Row(
                  children: const [
                    Text(
                      'انتخاب عکس از گالری یا دوربین',
                      textDirection: TextDirection.rtl,
                      style: TextStyle(
                          fontSize: 16.0,
                          color: Colors.grey,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                  mainAxisAlignment: MainAxisAlignment.end,
                )),
            Padding(
                padding:
                    const EdgeInsets.only(left: 16.0, right: 16.0, top: 16.0),
                child: SizedBox(
                  height: MediaQuery.of(context).size.height * 0.4,
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    children: [
                      InkWell(
                        child: Container(
                          height: 52.0,
                          width: 160.0,
                          decoration: BoxDecoration(
                              color: Colors.blue.shade50,
                              borderRadius: const BorderRadius.all(
                                  Radius.circular(12.0))),
                          child: Row(
                            children: const [
                              Icon(
                                Icons.add,
                                size: 36.0,
                                color: Colors.grey,
                              ),
                              Text(
                                'انتخاب عکس',
                                textDirection: TextDirection.rtl,
                                style: TextStyle(
                                    fontSize: 16.0,
                                    color: Colors.grey,
                                    fontWeight: FontWeight.bold),
                              )
                            ],
                            mainAxisAlignment: MainAxisAlignment.center,
                          ),
                        ),
                        onTap: () {
                          _showChoiceDialog(context);
                        },
                      ),
                      const SizedBox(
                        height: 16.0,
                      ),
                      (imageFile == null)
                          ? const Text("عکسی انتخاب نکرده اید")
                          : SizedBox(
                              child: Image.file(
                                File(imageFile!.path),
                                fit: BoxFit.fill,
                              ),
                              height: MediaQuery.of(context).size.height * 0.3,
                              width: MediaQuery.of(context).size.height * 0.3,
                            ),
                    ],
                  ),
                )),
            Padding(
                padding:
                    const EdgeInsets.only(left: 16.0, right: 16.0, top: 16.0),
                child: Row(
                  children: const [
                    Text(
                      'انتخاب ساعت و تاریخ',
                      textDirection: TextDirection.rtl,
                      style: TextStyle(
                          fontSize: 16.0,
                          color: Colors.grey,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                  mainAxisAlignment: MainAxisAlignment.end,
                )),
            Padding(
              padding:
                  const EdgeInsets.only(left: 16.0, right: 16.0, top: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    child: Container(
                      height: 52.0,
                      width: 160.0,
                      decoration: BoxDecoration(
                          color: Colors.blue.shade50,
                          borderRadius:
                              const BorderRadius.all(Radius.circular(12.0))),
                      child: Row(
                        children: [
                          const Icon(
                            Icons.arrow_drop_down,
                            size: 36.0,
                            color: Colors.grey,
                          ),
                          Text(
                            time,
                            textDirection: TextDirection.rtl,
                            style: const TextStyle(
                                fontSize: 16.0,
                                color: Colors.grey,
                                fontWeight: FontWeight.bold),
                          )
                        ],
                        mainAxisAlignment: MainAxisAlignment.center,
                      ),
                    ),
                    onTap: () async {
                      //hour
                      var picked = await showPersianTimePicker(
                        context: context,
                        initialTime: TimeOfDay.now(),
                      );
                      setState(() {
                        if (picked != null) {
                          time = picked.persianFormat(context);
                        }
                      });
                    },
                  ),
                  InkWell(
                    child: Container(
                      height: 52.0,
                      width: 160.0,
                      decoration: BoxDecoration(
                          color: Colors.blue.shade50,
                          borderRadius:
                              const BorderRadius.all(Radius.circular(12.0))),
                      child: Row(
                        children: [
                          const Icon(
                            Icons.arrow_drop_down,
                            size: 36.0,
                            color: Colors.grey,
                          ),
                          Text(
                            date,
                            textDirection: TextDirection.rtl,
                            style: const TextStyle(
                                fontSize: 16.0,
                                color: Colors.grey,
                                fontWeight: FontWeight.bold),
                          )
                        ],
                        mainAxisAlignment: MainAxisAlignment.center,
                      ),
                    ),
                    onTap: () async {
                      Jalali? picked = await showPersianDatePicker(
                        context: context,
                        initialDate: Jalali.now(),
                        firstDate: Jalali(1385, 8),
                        lastDate: Jalali(1450, 9),
                      );
                      if (picked != null && picked != selectedDate) {
                        setState(() {
                          date = picked.year.toString() +
                              '/' +
                              picked.month.toString() +
                              '/' +
                              picked.day.toString();
                        });
                      }
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _openGallery(BuildContext context) async {
    final pickedFile = await ImagePicker().getImage(
      source: ImageSource.gallery,
    );
    setState(() {
      imageFile = pickedFile!;
    });

    Navigator.pop(context);
  }

  void _openCamera(BuildContext context) async {
    final pickedFile = await ImagePicker().getImage(
      source: ImageSource.camera,
    );
    setState(() {
      imageFile = pickedFile!;
    });
    Navigator.pop(context);
  }
}
