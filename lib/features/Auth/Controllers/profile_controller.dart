import 'package:flutter/material.dart';
import '../models/user_model.dart';

class ProfileController extends ChangeNotifier {
  User? _user;
  bool _isEditing = false;
  
  User? get user => _user;
  bool get isEditing => _isEditing;
  
  set user(User? newUser) {
    _user = newUser;
    notifyListeners();
  }
  
  void toggleEdit() {
    _isEditing = !_isEditing;
    notifyListeners();
  }
  
  Future<bool> updateProfile(User updatedUser) async {
    try {
      await Future.delayed(const Duration(seconds: 1));
      
      
      _user = updatedUser;
      _isEditing = false;
      notifyListeners();
      return true;
    } catch (e) {
      return false;
    }
  }
  
  void updatePreference(String key, bool value) {
    if (_user != null) {
      _user!.preferences[key] = value;
      notifyListeners();
    }
  }
}