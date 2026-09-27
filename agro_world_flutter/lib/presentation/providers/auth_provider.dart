import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../core/constants/app_constants.dart';

class UserModel {
  final String name;
  final String email;
  final String contact;
  final String? photoUrl;
  final String role; // 'farmer', 'manufacturer', 'transporter'

  UserModel({
    required this.name,
    required this.email,
    required this.contact,
    this.photoUrl,
    required this.role,
  });
}

class AuthProvider extends ChangeNotifier {
  UserModel? _currentUser;
  bool _isLoading = false;

  UserModel? get currentUser => _currentUser;
  bool get isLoggedIn => _currentUser != null;
  bool get isLoading => _isLoading;
  bool get isManufacturer => _currentUser?.role == AppConstants.roleManufacturer;
  bool get isTransporter => _currentUser?.role == AppConstants.roleTransporter;
  bool get isFarmer => _currentUser?.role == AppConstants.roleFarmer;

  AuthProvider() {
    _checkSavedSession();
  }

  Future<void> _checkSavedSession() async {
    final prefs = await SharedPreferences.getInstance();
    final savedEmail = prefs.getString("user_email");
    final savedName = prefs.getString("user_name");
    final savedPhone = prefs.getString("user_phone");

    if (savedEmail != null && savedEmail.isNotEmpty) {
      _currentUser = UserModel(
        name: savedName ?? "Farmer Ashish",
        email: savedEmail,
        contact: savedPhone ?? "9876543210",
        photoUrl: "https://firebasestorage.googleapis.com/v0/b/agro-world-55872.appspot.com/o/ic_launcher-playstore.png?alt=media&token=6f72edc5-6dc3-40b7-ac65-cdf1bada9532",
        role: determineRole(savedEmail),
      );
      notifyListeners();
    }
  }

  static String determineRole(String email) {
    final normalized = email.trim().toLowerCase();
    if (AppConstants.manufacturerEmails.contains(normalized)) {
      return AppConstants.roleManufacturer;
    } else if (AppConstants.transporterEmails.contains(normalized)) {
      return AppConstants.roleTransporter;
    }
    return AppConstants.roleFarmer;
  }

  Future<bool> signIn(String email, String password) async {
    _isLoading = true;
    notifyListeners();

    await Future.delayed(const Duration(milliseconds: 600));

    final role = determineRole(email);
    String displayName = "Farmer User";
    if (role == AppConstants.roleManufacturer) {
      displayName = "Agro Seeds Manufacturer";
    } else if (role == AppConstants.roleTransporter) {
      displayName = "Kisan Transport Service";
    }

    _currentUser = UserModel(
      name: displayName,
      email: email,
      contact: "9876543210",
      photoUrl: null,
      role: role,
    );

    final prefs = await SharedPreferences.getInstance();
    await prefs.setString("user_email", email);
    await prefs.setString("user_name", displayName);

    _isLoading = false;
    notifyListeners();
    return true;
  }

  Future<bool> signUp(String name, String email, String contact, String password) async {
    _isLoading = true;
    notifyListeners();

    await Future.delayed(const Duration(milliseconds: 600));

    final role = determineRole(email);
    _currentUser = UserModel(
      name: name,
      email: email,
      contact: contact,
      role: role,
    );

    final prefs = await SharedPreferences.getInstance();
    await prefs.setString("user_email", email);
    await prefs.setString("user_name", name);
    await prefs.setString("user_phone", contact);

    _isLoading = false;
    notifyListeners();
    return true;
  }

  Future<void> signInWithGoogle() async {
    _isLoading = true;
    notifyListeners();

    await Future.delayed(const Duration(milliseconds: 500));

    _currentUser = UserModel(
      name: "Ashish Gavade",
      email: "theashishgavade@gmail.com",
      contact: "9822334455",
      photoUrl: "https://firebasestorage.googleapis.com/v0/b/agro-world-55872.appspot.com/o/ic_launcher-playstore.png?alt=media&token=6f72edc5-6dc3-40b7-ac65-cdf1bada9532",
      role: determineRole("theashishgavade@gmail.com"),
    );

    final prefs = await SharedPreferences.getInstance();
    await prefs.setString("user_email", _currentUser!.email);
    await prefs.setString("user_name", _currentUser!.name);

    _isLoading = false;
    notifyListeners();
  }

  Future<void> signOut() async {
    _currentUser = null;
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove("user_email");
    await prefs.remove("user_name");
    await prefs.remove("user_phone");
    notifyListeners();
  }
}
