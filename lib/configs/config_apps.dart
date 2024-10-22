import 'package:flutter/material.dart';

import '../controllers/controller_immunization.dart';
import '../controllers/controller_growth.dart';
import '../controllers/controller_user.dart';
import '../controllers/controller_kid.dart';
import '../models/model_controller.dart';
import '../models/model_list.dart';

// default size
const double defaultSize = 16;
const double defaultRadius = 12;

// color palette - light mode
const Color colorBackground = Color(0xFFFFFFFF);
const Color colorPrimary = Color(0xFF0C1B33);
const Color colorSecondary = Color(0xFFEFEFEF);
const Color colorAccent = Color(0xFFFFFFFF);

const Color colorTextAccent = Color(0xFF000000);
const Color colorBlack = Color(0xFF3C4048);
const Color colorBar = Color(0xFFE8E8E8);
const Color colorRed = Color(0xFFD24545);

// model

ModelController user = ModelController();
ModelList list = ModelList();

// controller
ControllerKid controllerKid = ControllerKid();
ControllerUser controllerUser = ControllerUser();
ControllerGrowth controllerGrowth = ControllerGrowth();
ControllerImmunization controllerImmun = ControllerImmunization();

// image default
const String imagePhotoBoy = "https://bit.ly/app-photo-boy";
const String imagePhotoGirl = "https://bit.ly/app-photo-girl";

const String imageEmailVerification = "assets/page_email_verification.svg";
const String imageForgotPassword = "assets/page_forgot_password.svg";
const String imagePageChatEmpty = "assets/page_chat_empty.svg";
const String imagePageHomeEmpty = "assets/page_home_empty.svg";
const String imagePageKidsEmpty = "assets/page_kids_empty.svg";
const String imageChooseRole = "assets/page_choose_role.svg";
const String imageDelete = "assets/page_delete.svg";
const String imageLogout = "assets/page_logout.svg";

const String imageFood =
    "https://i0.wp.com/resepkoki.id/wp-content/uploads/2016/04/Resep-Bakso-urat.jpg?fit=500%2C632&ssl=1";

String imagePhotoProfile(String currentUserId) {
  return 'https://firebasestorage.googleapis.com/v0/b/mawar-care.appspot.com/o/$currentUserId.jpg?alt=media&token=36d3d579-ce2a-426b-a44c-9f5daf1639e4';
}

// message
const String messageAuthinvalid = "Kredensial otentikasi yang diberikan salah.";
const String messageDeleteKids = "Apakah Anda yakin ingin menghapus anak ini ?";
const String messageSignOut = "Apakah Anda yakin ingin keluar dari aplikasi ?";
const String messageAuthError = "Ups, terdapat kesalahan. Coba ulangi lagi.";
const String messagPassAlert = "Kata sandi setidaknya mempunyai enam karakter.";
const String messageEmailInvalid = "Email tidak sesuai dengan format.";
const String messageImageEmpty = "Tidak ada Image yang dipilih.";
const String messageEmailAlreadyUse = "Email sudah digunakan.";
const String messageSignInWithGoogleCancelled =
    "Masuk dengan Google, dibatalkan.";
const String messageDefault = "Tidak ada data";
const String messageMustEntry = "Semua data harus diisi.";
const String messageMinimunChars = "Setidaknya mempunyai tiga karakter.";
const String messageNoInternet = "Koneksi internet anda terputus.";
const String messageEmailAndPasswordEmpty =
    "Email dan kata sandi tidak boleh kosong.";
const String messageEmailVerification =
    "Harap aktifkan akun Anda dengan mengklik tautan di email untuk memulai.";
const String messagePageChatEmpty =
    "Tidak ada percakapan. Silahkan  ketik pesan untuk memulai percakapan baru.";
const String messageForgotPassword =
    "Masukkan email dan kami akan mengirimkan tautan untuk mereset kata sandi Anda.";
const String messageChooseRole =
    "Lengkapi informasi pribadi dengan memilih jenis kelamin dan peran Anda.";
const String messageHomeEmptyForParent =
    "Saat ini, tidak ada data anak. Klik  tambah untuk menambahkan data anak.";
const String messageHomeEmptyForOthers =
    "Saat ini, tidak ada data anak. Silahkan hubungi orang tua untuk menambah data anak mereka.";
const String messageKidsDataEmptyForOthers =
    "Tidak ada catatan. Klik tombol tambah untuk membuat catatan baru.";
const String messageDeleteRecords =
    "Apakah Anda yakin ingin menghapus catatan ini ?";
const String messageKidsEmpty =
    "Maaf, nama anak yang Anda cari tidak ditemukan dalam daftar.";
const String messageChatEmpty =
    "Saat ini, tidak ada data pengguna tersedia. Silahkan  undang orang lain untuk bergabung";
const String messageKidsDataEmptyForParent =
    "Data catatan gizi anak tidak tersedia. Harap hubungi Pengurus atau Bidan Posyandu.";
