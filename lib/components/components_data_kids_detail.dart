// ignore_for_file: avoid_print

import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

import '../components/components_text_box.dart';
import '../components/components_photo.dart';
import '../configs/config_apps.dart';
import '../configs/config_components.dart';

class ComponentsDataKidsDetail extends StatefulWidget {
  final String id;
  const ComponentsDataKidsDetail({
    Key? key,
    required this.id,
  }) : super(key: key);

  @override
  State<ComponentsDataKidsDetail> createState() =>
      _ComponentsDataKidsDetailState();
}

class _ComponentsDataKidsDetailState extends State<ComponentsDataKidsDetail> {
  final currentUserId = FirebaseAuth.instance.currentUser!.uid;
  late Timestamp birthDateTimestamp;
  PlatformFile? pickedFile;
  late DateTime birthDate;
  UploadTask? uploadTask;
  String? nameParent;

  @override
  void initState() {
    super.initState();
    birthDate = DateTime.now();
    birthDateTimestamp = Timestamp.fromDate(birthDate);
  }

  Future<String?> getNameParent(String? parent) async {
    try {
      final user = await FirebaseFirestore.instance
          .collection('users')
          .doc(parent)
          .get();

      final data = user.data() as Map<String, dynamic>;

      return data['name'];
    } catch (error) {
      print('Error fetching user data: $error');
      return null;
    }
  }

  Future photoUpload(String userId) async {
    final path = "$userId.jpg";
    final file = File(pickedFile!.path!);
    final ref = FirebaseStorage.instance.ref().child(path);

    setState(() {
      uploadTask = ref.putFile(file);
    });

    final photo = imagePhotoProfile(userId);

    await FirebaseFirestore.instance.collection('users').doc(userId).update({
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

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: controllerUser.streamUsers.doc(widget.id).snapshots(),
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
                  photo: pickedFile == null
                      ? Image.network(
                          data['photo'],
                          fit: BoxFit.cover,
                        )
                      : Image.file(
                          File(pickedFile!.path!),
                          fit: BoxFit.cover,
                        ),
                ),
                buildProgress(),
                ComponentsTextBox(
                  textTitle: "Nama Lengkap",
                  text: data['name'],
                ),
                ComponentsTextBox(
                  textTitle: "Nomor Induk Keluarga",
                  text: data['nik'],
                ),
                ComponentsTextBox(
                  textTitle: "Jenis Kelamin",
                  text: data['gender'],
                ),
                ComponentsTextBox(
                  textTitle: "Tempat Lahir",
                  text: data['birthPlace'],
                ),
                ComponentsTextBox(
                  textTitle: "Tanggal Lahir",
                  text: formatDate(data['birthDate']),
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
