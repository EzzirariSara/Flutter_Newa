import 'package:flutter/material.dart';
import '../models/user_model.dart';

class AuthController extends ChangeNotifier {
  bool _isAuthenticated = false;
  User? _currentUser;
  
  bool get isAuthenticated => _isAuthenticated;
  User? get currentUser => _currentUser;
  
  Future<bool> login(String email, String password) async {
    try {
      await Future.delayed(const Duration(seconds: 1));
      
      _currentUser = User(
        id: '1',
        name: 'Utilisateur Connecté',
        email: email,
        phone: '+212 612345678',
        address: 'Rue Hassan II, N°123',
        city: 'Casablanca',
        postalCode: '20000',
        isPremium: true,
      );
      
      _isAuthenticated = true;
      notifyListeners();
      return true;
    } catch (e) {
      return false;
    }
  }
  
  Future<bool> signup(String name, String email, String password) async {
    try {
      await Future.delayed(const Duration(seconds: 1));
      
      
      _currentUser = User(
        id: '1',
        name: name,
        email: email,
        isPremium: false,
      );
      
      _isAuthenticated = true;
      notifyListeners();
      return true;
    } catch (e) {
      return false;
    }
  }
  
  void logout() {
    _isAuthenticated = false;
    _currentUser = null;
    notifyListeners();
  }
}