import 'dart:io';

import 'package:flutter_holo_date_picker/flutter_holo_date_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../components/components_modal_field.dart';
import '../components/components_text_box.dart';
import '../components/components_photo.dart';
import '../configs/config_apps.dart';
import 'components_modal_bottom.dart';
import 'components_modal_choice.dart';
import '../configs/config_components.dart';

class ComponentsDataKidsEdit extends StatefulWidget {
  final String id;
  const ComponentsDataKidsEdit({Key? key, required this.id}) : super(key: key);

  @override
  State<ComponentsDataKidsEdit> createState() => _ComponentsDataKidsEditState();
}

class _ComponentsDataKidsEditState extends State<ComponentsDataKidsEdit> {
  late DateTime birthDate;
  late Timestamp birthDateTimestamp;
  PlatformFile? pickedFile;
  UploadTask? uploadTask;
  final currentUserId = FirebaseAuth.instance.currentUser!.uid;

  @override
  void initState() {
    super.initState();
    birthDate = DateTime.now();
    birthDateTimestamp = Timestamp.fromDate(birthDate);
  }

  Future photoSelect() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['jpg', 'jpeg', 'png'],
    );

    if (result == null) return;
    setState(() {
      pickedFile = result.files.first;
    });
  }

  Widget buildProgress() => StreamBuilder(
        stream: uploadTask?.snapshotEvents,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final data = snapshot.data!;
            double progress = data.bytesTransferred / data.totalBytes;

            return Padding(
              padding: const EdgeInsets.only(
                left: defaultSize * 2,
                right: defaultSize * 2,
                bottom: defaultSize,
              ),
              child: Column(
                children: [
                  LinearProgressIndicator(
                    value: progress,
                    minHeight: defaultSize * 0.5,
                    backgroundColor: colorAccent,
                    color: colorPrimary,
                    borderRadius: BorderRadius.circular(defaultSize),
                  ),
                ],
              ),
            );
          } else {
            return const SizedBox(
              height: defaultSize,
            );
          }
        },
      );

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: controllerKid.streamKids.doc(widget.id).snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const SizedBox.shrink();
        }

        var data = snapshot.data!.data() as Map<String, dynamic>;
        return Expanded(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              children: [
                ComponentsPhoto(
                  isEdit: true,
                  photo: pickedFile == null
                      ? Image.network(
                          data['photo'],
                          fit: BoxFit.cover,
                        )
                      : Image.file(
                          File(pickedFile!.path!),
                          fit: BoxFit.cover,
                        ),
                  onTapRight: photoSelect,
                  onTapLeft: () async {
                    if (pickedFile == null) {
                      modalBottom(
                        context,
                        messageImageEmpty,
                        null,
                        null,
                      );
                      return;
                    }
                    final path = "${snapshot.data!.id}.jpg";
                    final file = File(pickedFile!.path!);
                    final ref = FirebaseStorage.instance.ref().child(path);

                    setState(() {
                      uploadTask = ref.putFile(file);
                    });

                    final photo = imagePhotoProfile(snapshot.data!.id);

                    await FirebaseFirestore.instance
                        .collection('kids')
                        .doc(snapshot.data!.id)
                        .update({
                      'photo': photo,
                    });
                  },
                ),
                buildProgress(),
                ComponentsTextBox(
                  textTitle: "Nama Lengkap",
                  text: data['name'],
                  onTap: () {
                    Future.delayed(Duration.zero, () {
                      modalField(context, "Nama lengkap", 25, false,
                          (String newValue) {
                        controllerKid.streamKids.doc(widget.id).update({
                          'name': newValue,
                        });
                      });
                    });
                  },
                ),
                ComponentsTextBox(
                  textTitle: "Nomor Induk Keluarga",
                  text: data['nik'],
                  onTap: () {
                    Future.delayed(Duration.zero, () {
                      modalField(context, "Nomor Induk Keluarga", 16, true,
                          (String newValue) {
                        controllerKid.streamKids.doc(widget.id).update({
                          'nik': newValue,
                        });
                      });
                    });
                  },
                ),
                ComponentsTextBox(
                  textTitle: "Jenis Kelamin",
                  text: data['gender'],
                  onTap: () {
                    Future.delayed(Duration.zero, () {
                      modalChoice(context, "Jenis Kelamin", (String newValue) {
                        controllerKid.streamKids.doc(widget.id).update({
                          'gender': newValue,
                        });
                      });
                    });
                  },
                ),
                ComponentsTextBox(
                  textTitle: "Tempat Lahir",
                  text: data['birthPlace'],
                  onTap: () {
                    Future.delayed(Duration.zero, () {
                      modalField(context, "Tempat Lahir", 25, false,
                          (String newValue) {
                        controllerKid.streamKids.doc(widget.id).update({
                          'birthPlace': newValue,
                        });
                      });
                    });
                  },
                ),
                ComponentsTextBox(
                  textTitle: "Tanggal Lahir",
                  text: formatDate(data['birthDate']),
                  onTap: () {
                    showCupertinoModalPopup(
                      context: context,
                      builder: (BuildContext context) => Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: defaultSize,
                        ),
                        child: Container(
                          height: defaultSize * 11,
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(defaultRadius),
                              topRight: Radius.circular(defaultRadius),
                            ),
                            color: colorBackground,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: defaultSize,
                            ),
                            child: DatePickerWidget(
                              looping: true,
                              dateFormat: "dd-MMMM-yyyy",
                              onChange: (DateTime newDate, _) {
                                controllerKid.streamKids.doc(widget.id).update({
                                  'birthDate': newDate,
                                });
                              },
                              pickerTheme: DateTimePickerTheme(
                                itemTextStyle: GoogleFonts.poppins(
                                  color: colorBlack,
                                  fontSize: defaultSize,
                                ),
                                dividerColor: colorPrimary,
                                backgroundColor: colorBackground,
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
                const SizedBox(height: defaultSize * 2),
              ],
            ),
          ),
        );
      },
    );
  }
}
