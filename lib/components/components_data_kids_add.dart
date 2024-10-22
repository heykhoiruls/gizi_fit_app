// ignore_for_file: avoid_print

import 'package:flutter_holo_date_picker/flutter_holo_date_picker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/cupertino.dart';

import '../components/components_modal_bottom.dart';
import '../components/components_modal_field.dart';
import '../components/components_text_box.dart';
import '../configs/config_apps.dart';
import '../configs/config_components.dart';
import 'components_category.dart';
import 'components_button.dart';

class ComponentsDataKidsAdd extends StatefulWidget {
  const ComponentsDataKidsAdd({
    Key? key,
  }) : super(key: key);

  @override
  State<ComponentsDataKidsAdd> createState() => _ComponentsDataKidsAddState();
}

class _ComponentsDataKidsAddState extends State<ComponentsDataKidsAdd> {
  late DateTime birthDate;
  late Timestamp birthDateTimestamp;
  int selectedGenderIndex = 0;
  final currentUserId = FirebaseAuth.instance.currentUser!.uid;

  @override
  void initState() {
    super.initState();
    birthDate = DateTime.now();
    birthDateTimestamp = Timestamp.fromDate(birthDate);
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            const SizedBox(height: defaultSize),
            ComponentsTextBox(
              textTitle: "Nama Lengkap",
              text: user.name,
              onTap: () {
                Future.delayed(Duration.zero, () {
                  modalField(context, "Nama lengkap", 25, false,
                      (String newValue) {
                    setState(() {
                      user.name = newValue;
                    });
                  });
                });
              },
            ),
            ComponentsTextBox(
              textTitle: "Nomor Induk Keluarga",
              text: user.nik,
              onTap: () {
                Future.delayed(Duration.zero, () {
                  modalField(context, "Nomor Induk Keluarga", 16, true,
                      (String newValue) {
                    setState(() {
                      user.nik = newValue;
                    });
                  });
                });
              },
            ),
            ComponentsTextBox(
              textTitle: "Tempat Lahir",
              text: user.birthPlace,
              onTap: () {
                Future.delayed(Duration.zero, () {
                  modalField(context, "Tempat Lahir", 25, false,
                      (String newValue) {
                    setState(() {
                      user.birthPlace = newValue;
                    });
                  });
                });
              },
            ),
            ComponentsTextBox(
              textTitle: "Tanggal Lahir",
              text: formatDate(birthDateTimestamp),
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
                            setState(() {
                              birthDate = newDate;
                              birthDateTimestamp =
                                  Timestamp.fromDate(birthDate);
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
            ComponentsCategory(
              text: "Jenis Kelamin",
              onCategorySelected: (index) {
                setState(() {
                  selectedGenderIndex = index;
                });
              },
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: defaultSize,
                right: defaultSize,
                bottom: defaultSize * 2,
                top: defaultSize * 2,
              ),
              child: ComponentsButton(
                  text: 'Tambah',
                  color: colorBackground,
                  onTap: () {
                    if (user.name != messageDefault ||
                        user.nik != messageDefault ||
                        user.birthPlace != messageDefault) {
                      controllerKid.add(
                        context,
                        user,
                        birthDateTimestamp,
                        list.gender[selectedGenderIndex],
                        currentUserId,
                      );
                    } else {
                      modalBottom(
                        context,
                        messageMustEntry,
                        null,
                        () {},
                      );
                    }
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
