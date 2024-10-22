// ignore_for_file: use_build_context_synchronously
import 'dart:io';

import 'package:flutter_holo_date_picker/flutter_holo_date_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../components/components_modal_bottom.dart';
import '../components/components_transition.dart';
import '../controllers/controller_user.dart';
import '../components/components_photo.dart';
import '../configs/config_apps.dart';
import '../pages/page_auth/page_auth.dart';
import 'components_modal_choice.dart';
import 'components_modal_field.dart';
import '../configs/config_components.dart';
import 'components_text_box.dart';
import 'components_button.dart';

class ComponentsDataUser extends StatefulWidget {
  final String id;

  const ComponentsDataUser({
    Key? key,
    required this.id,
  }) : super(key: key);

  @override
  State<ComponentsDataUser> createState() => _ComponentsDataUserState();
}

class _ComponentsDataUserState extends State<ComponentsDataUser> {
  PlatformFile? pickedFile;
  UploadTask? uploadTask;
  final currentUserId = FirebaseAuth.instance.currentUser!.uid;

  Future photoUpload() async {
    if (pickedFile == null) {
      modalBottom(
        context,
        messageImageEmpty,
        null,
        null,
      );
      return;
    }
    final path = "$currentUserId.jpg";
    final file = File(pickedFile!.path!);
    final ref = FirebaseStorage.instance.ref().child(path);

    setState(() {
      uploadTask = ref.putFile(file);
    });

    final photo = imagePhotoProfile(currentUserId);

    await FirebaseFirestore.instance
        .collection('users')
        .doc(currentUserId)
        .update({
      'photo': photo,
    });
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

  Widget buildUser(BuildContext context, Map<String, dynamic> snapdata) {
    return Expanded(
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            if (snapdata.isNotEmpty) ...[
              const SizedBox(height: defaultSize),
              ComponentsPhoto(
                isEdit: true,
                photo: pickedFile == null
                    ? Image.network(
                        snapdata['photo'],
                        fit: BoxFit.cover,
                      )
                    : Image.file(
                        File(pickedFile!.path!),
                        fit: BoxFit.cover,
                      ),
                onTapRight: photoSelect,
                onTapLeft: photoUpload,
              ),
              buildProgress(),
              ComponentsTextBox(
                textTitle: "Nama Lengkap",
                text: snapdata['name'],
                showIcon: true,
                onTap: () {
                  Future.delayed(Duration.zero, () {
                    modalField(context, "Nama Lengkap", 25, false,
                        (String newValue) {
                      controllerUser.streamUsers.doc(widget.id).update({
                        'name': newValue,
                      });
                    });
                  });
                },
              ),
              ComponentsTextBox(
                textTitle: "Nomor Induk Keluarga",
                text: snapdata['nik'],
                onTap: () {
                  Future.delayed(Duration.zero, () {
                    modalField(context, "Nomor Induk Keluarga", 16, true,
                        (String newValue) {
                      controllerUser.streamUsers.doc(widget.id).update({
                        'nik': newValue,
                      });
                    });
                  });
                },
              ),
              ComponentsTextBox(
                textTitle: "Email",
                text: snapdata['email'],
              ),
              ComponentsTextBox(
                textTitle: "Peran",
                text: snapdata['role'],
              ),
              ComponentsTextBox(
                textTitle: "Jenis Kelamin",
                text: snapdata['gender'],
                onTap: () {
                  Future.delayed(Duration.zero, () {
                    modalChoice(context, "Jenis Kelamin", (String newValue) {
                      controllerUser.streamUsers.doc(widget.id).update({
                        'gender': newValue,
                      });
                    });
                  });
                },
              ),
              ComponentsTextBox(
                textTitle: "Tempat Lahir",
                text: snapdata['birthPlace'],
                onTap: () {
                  Future.delayed(Duration.zero, () {
                    modalField(context, "Tempat Lahir", 25, false,
                        (String newValue) {
                      controllerUser.streamUsers.doc(widget.id).update(
                        {
                          'birthPlace': newValue,
                        },
                      );
                    });
                  });
                },
              ),
              ComponentsTextBox(
                textTitle: "Tanggal Lahir",
                text: formatDate(snapdata['birthDate']),
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
                              controllerUser.streamUsers.doc(widget.id).update({
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
              const SizedBox(height: defaultSize),
              Padding(
                padding: const EdgeInsets.only(
                  left: defaultSize,
                  right: defaultSize,
                  bottom: defaultSize * 2,
                  top: defaultSize * 0.75,
                ),
                child: ComponentsButton(
                  text: 'Keluar',
                  color: colorBar,
                  onTap: () async {
                    modalBottom(
                      context,
                      messageSignOut,
                      widget.id,
                      () async {
                        final GoogleSignIn googleSignIn = GoogleSignIn();

                        if (googleSignIn.currentUser != null) {
                          await googleSignIn.disconnect();
                          await googleSignIn.signOut();
                        }

                        await FirebaseAuth.instance.signOut();

                        await Navigator.push(
                          context,
                          transitionRight(const PageAuth()),
                        );
                      },
                    );
                  },
                ),
              ),
              const SizedBox(height: defaultSize * 8),
            ],
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    ControllerUser controllerUser = ControllerUser();
    return StreamBuilder(
      stream: controllerUser.streamUsers.doc(widget.id).snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Container();
        }
        var data = snapshot.data!.data() as Map<String, dynamic>;
        return buildUser(context, data);
      },
    );
  }
}
