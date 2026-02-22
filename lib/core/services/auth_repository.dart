// lib/core/services/auth_repository.dart

import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../models/user_model.dart';

class AuthRepository {
  final SupabaseClient _supabase = Supabase.instance.client;

  Future<UserModel> login({
    required String email,
    required String password,
  }) async {

    // ✅ FIX: AuthException কে rethrow করো — wrap করলে message হারিয়ে যায়
    // আগে: throw Exception(e.message) — এতে "Invalid login credentials" ঠিকমতো আসে না
    // এখন: AuthException directly rethrow

    final response = await _supabase.auth.signInWithPassword(
      email: email,
      password: password,
    );

    final user = response.user;

    if (user == null) {
      throw const AuthException('Invalid login credentials');
    }

    // Profile থেকে role নাও
    final profile = await _supabase
        .from('profiles')
        .select('role')
        .eq('id', user.id)
        .maybeSingle();

    debugPrint('Profile fetched: $profile'); // console এ দেখো

    final role = profile?['role'] as String? ?? 'student';
    debugPrint('Role from DB: $role');

    return UserModel(
      id: user.id,
      email: user.email ?? '',
      role: role,
    );
  }

  Future<void> logout() async {
    await _supabase.auth.signOut();
  }

  User? get currentUser => _supabase.auth.currentUser;
}