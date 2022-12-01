import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:sports_meet/core/app/app.locator.dart';
import 'package:sports_meet/core/models/user.dart';
import 'package:sports_meet/core/services/authentication_service.dart';
import 'package:sports_meet/core/services/stream_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class EditProfileViewModel extends BaseViewModel {

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final AuthenticationService _authenticationService = locator<AuthenticationService>();
  final NavigationService _navigationService = locator<NavigationService>();
  final DialogService _dialogService = locator<DialogService>();
  final ServiceEventStream _serviceStream = locator<ServiceEventStream>();
  UserModel? userModel;
  User? user;

  final firebaseStorage = FirebaseStorage.instance;
  final imagePicker = ImagePicker();


  void updateProfilePic(){
    userModel = _authenticationService.currentUser!;
    user = _auth.currentUser!;
    notifyListeners();
  }

  void saveAndLoadImage(
      {required String folderName,
        required XFile image,
        required File file}) async {
    setBusy(true);
    try{
      var snapshot = await firebaseStorage
          .ref()
          .child('$folderName/${image.name}')
          .putFile(file);

      ///Getting the url of the file
      var downloadUrl = await snapshot.ref.getDownloadURL();

      ///Updating stored user data
      Map<String, dynamic> json = {
        folderName: downloadUrl,
      };
      await _authenticationService.updateUser(
        uid: _authenticationService.currentUser!.id!,
        json: json,
      );
      updateProfilePic();
      _serviceStream.add(ServiceEvent(type: ServiceEventType.updateProfile));
    } catch (e){
      _dialogService.showDialog(
        title: 'Error',
        description:
        'Something went wrong somewhere.',
      );
    } finally {
      setBusy(false);
    }
  }

  void uploadImage({required bool fromPhotos, required bool profilePic}) async {
    ///Checking if user wants to pick photo
    if (fromPhotos) {
      XFile? image = await imagePicker.pickImage(source: ImageSource.gallery);

      if (image != null) {
        var file = File(image.path);

        if (profilePic) {
          saveAndLoadImage(
              folderName: UserField.profileImage, image: image, file: file);
        } else if (!profilePic) {
          saveAndLoadImage(
              folderName: UserField.coverImage, image: image, file: file);
        }
      }
    } else if (!fromPhotos) {
      PermissionStatus permissionStatus = await Permission.camera.request();
      if (permissionStatus.isGranted) {
        ///Select Image
        XFile? image = await imagePicker.pickImage(
          source: ImageSource.camera,
          preferredCameraDevice: CameraDevice.front,
        );

        if (image != null) {
          var file = File(image.path);

          ///Updating user information in the firestore database
          if (profilePic) {
            saveAndLoadImage(
                folderName: UserField.profileImage, image: image, file: file);
          } else if (!profilePic) {
            saveAndLoadImage(
                folderName: UserField.coverImage, image: image, file: file);
          }
        }
      } else {
        _dialogService.showDialog(
          title: 'Error',
          description:
          'Permission not granted. Try Again with permission access',
        );
      }
    }
  }

  void verifyEmail() async {
    await user!.sendEmailVerification();
    _navigationService.back();
  }

  void saveChanges({required String email, required String username}) async {
    setBusy(true);
    try{
      if (email.isNotEmpty && email != user!.email){
        await user?.updateEmail(email);
      }
      if (username.isNotEmpty &&  username != userModel!.username){
        Map<String, dynamic> json = {
          UserField.username: username,
        };
        await _authenticationService.updateUser(uid: user!.uid, json: json);
        _serviceStream.add(ServiceEvent(type: ServiceEventType.updateProfile));
      }
      _navigationService.back();
    } on FirebaseAuthException catch (e){
      _dialogService.showDialog(
        title: 'Error',
        description: e.message,
      );
    } catch (e) {
      _dialogService.showDialog(
        title: 'Error',
        description: 'Something occurred. Please try again later.',
      );
    } finally {
      setBusy(false);
    }
  }

  void cancel(){
    _navigationService.back();
  }

}