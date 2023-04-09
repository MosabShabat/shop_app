import 'dart:io';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shop_app/consts/conste.dart';
import '../../controllers/auth_controller.dart';

enum Gender { male, female }

class EditProfileScreen extends StatefulWidget {
  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final AuthController _authController = Get.find();
  Gender? _selectedGender;

  final _formKey = GlobalKey<FormState>();

  String? _firstName;
  String? _lastName;

  File? _imageFile;

  final ImagePicker _imagePicker = ImagePicker();

  Future<void> _pickImage(ImageSource source) async {
    final pickedFile = await _imagePicker.pickImage(source: source);
    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
      });
    }
  }

  void _saveChanges() async {
    // if (_formKey.currentState?.validate() ?? false) {
    //   _formKey.currentState?.save();

    //   if (_imageFile != null) {
    // //  late  _authController.userImage = _imageFile!.path;
    //   }

    //   if (_firstName != null && _lastName != null) {
    //     final currentUser = _authController.firebaseUser.value;
    //     if (currentUser != null) {
    //       await currentUser.updateProfile(
    //         displayName: '$_firstName $_lastName',
    //       );
    //       _authController.firebaseUser.value = currentUser;
    //     }
    //   }

    //   Get.back();
    // }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: const Icon(
              Icons.arrow_back,
              color: darkColor,
            )),
        elevation: 0,
        backgroundColor: Colors.transparent,
        centerTitle: true,
        title: Editprofile.tr.text.color(darkColor).fontFamily(bold).make(),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Obx(
            () => Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: mainColor,
                    image: _imageFile != null
                        ? DecorationImage(
                            image: FileImage(_imageFile!),
                            fit: BoxFit.cover,
                          )
                        : _authController.userImage != null
                            ? DecorationImage(
                                image: NetworkImage(_authController.userImage!),
                                fit: BoxFit.cover,
                              )
                            : null,
                  ),
                  width: 100,
                  height: 100,
                  child: _imageFile == null
                      ? TextButton(
                          onPressed: () => _pickImage(ImageSource.gallery),
                          child: Changeimage.tr.text
                              .color(darkColor)
                              .fontFamily(bold)
                              .size(20)
                              .make(),
                        )
                      : null,
                ),
                20.heightBox,
                TextFormField(
                  initialValue: _authController.userName,
                  decoration: const InputDecoration(
                    labelText: 'User Name',
                    border: InputBorder.none,
                  ),
                  validator: (value) {
                    if (value?.isEmpty ?? true) {
                      return 'Please enter your first name';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _firstName = value;
                  },
                )
                    .box
                    .padding(const EdgeInsets.symmetric(horizontal: 10))
                    .rounded
                    .width(context.screenWidth)
                    .height(60)
                    .color(grayColor)
                    .make(),
                20.heightBox,
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    gender.tr.text
                        .color(darkColor)
                        .fontFamily(bold)
                        .size(16)
                        .make(),
                    120.widthBox,
                    Radio<Gender>(
                      value: Gender.male,
                      groupValue: _selectedGender,
                      onChanged: (value) {
                        setState(() {
                          _selectedGender = value!;
                        });
                      },
                    ),
                    Container(
                        width: 30,
                        height: 30,
                        decoration: BoxDecoration(
                            color: grayColor,
                            borderRadius: BorderRadius.circular(10)),
                        child: const Center(
                            child: Icon(
                          Icons.male,
                          color: mainColor,
                          size: 25,
                        ))),
                    Radio<Gender>(
                      value: Gender.female,
                      groupValue: _selectedGender,
                      onChanged: (value) {
                        setState(() {
                          _selectedGender = value!;
                        });
                      },
                    ),
                    Container(
                        width: 30,
                        height: 30,
                        decoration: BoxDecoration(
                            color: grayColor,
                            borderRadius: BorderRadius.circular(10)),
                        child: const Center(
                            child: Icon(
                          Icons.female,
                          color: mainColor,
                          size: 25,
                        ))),
                  ],
                ),
                20.heightBox,
                TextFormField(
                  initialValue: _authController.userEmail,
                  decoration: const InputDecoration(
                    labelText: 'Email',
                    border: InputBorder.none,
                  ),
                  validator: (value) {
                    if (value?.isEmpty ?? true) {
                      return 'Please enter your first name';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _firstName = value;
                  },
                )
                    .box
                    .padding(const EdgeInsets.symmetric(horizontal: 10))
                    .rounded
                    .width(context.screenWidth)
                    .height(60)
                    .color(grayColor)
                    .make(),
                100.heightBox,
                ElevatedButton(
                  onPressed: _saveChanges,
                  child: Confirm.tr.text
                      .color(whiteColor)
                      .fontFamily(bold)
                      .size(20)
                      .make(),
                ).box.rounded.width(context.screenWidth - 40).height(60).make(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
//langue