import 'dart:async';
import 'package:flutter/material.dart';
import '../../services/auth_service.dart';

class VerifyEmailScreen extends StatefulWidget {
  const VerifyEmailScreen({super.key});

  @override
  State<VerifyEmailScreen> createState() => _VerifyEmailScreenState();
}

class _VerifyEmailScreenState extends State<VerifyEmailScreen> {
  final AuthService _authService = AuthService();
  Timer? _timer;
  bool _canResend = true;
  int _countdown = 0;

  @override
  void initState() {
    super.initState();
    // Vérifie toutes les 3 secondes si le mail a été validé
    _timer = Timer.periodic(const Duration(seconds: 3), (_) async {
      final verified = await _authService.isEmailVerified();
      if (verified && mounted) {
        _timer?.cancel();
        // Force un reload complet en se déconnectant puis reconnectant
        // Plus simple : on pop, le AuthGate dans main.dart gèrera
        Navigator.of(context).popUntil((route) => route.isFirst);
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  Future<void> _resendEmail() async {
    if (!_canResend) return;

    try {
      await _authService.resendVerificationEmail();
      setState(() {
        _canResend = false;
        _countdown = 60;
      });

      // Compte à rebours de 60 secondes
      Timer.periodic(const Duration(seconds: 1), (timer) {
        if (mounted) {
          setState(() => _countdown--);
          if (_countdown <= 0) {
            timer.cancel();
            setState(() => _canResend = true);
          }
        } else {
          timer.cancel();
        }
      });

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Email de vérification envoyé !'),
            backgroundColor: Colors.green,
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Erreur lors de l\'envoi'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final email = _authService.currentUser?.email ?? '';

    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: Center(
        child: Container(
          width: 420,
          padding: const EdgeInsets.all(32),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.08),
                blurRadius: 20,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.mark_email_read, size: 60, color: Colors.orange),
              const SizedBox(height: 20),
              const Text(
                'Vérifiez votre email',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              Text(
                'Un email de vérification a été envoyé à :\n$email',
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 15, color: Colors.grey),
              ),
              const SizedBox(height: 10),
              const Text(
                'Cliquez sur le lien dans l\'email puis revenez ici.\nCette page se mettra à jour automatiquement.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 13, color: Colors.grey),
              ),
              const SizedBox(height: 30),

              // Indicateur de chargement
              const CircularProgressIndicator(),
              const SizedBox(height: 10),
              const Text(
                'En attente de vérification...',
                style: TextStyle(color: Colors.grey, fontSize: 13),
              ),
              const SizedBox(height: 30),

              // Renvoyer l'email
              SizedBox(
                width: double.infinity,
                height: 45,
                child: OutlinedButton(
                  onPressed: _canResend ? _resendEmail : null,
                  child: Text(
                    _canResend
                        ? 'Renvoyer l\'email de vérification'
                        : 'Renvoyer dans $_countdown s',
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // Se déconnecter (pour changer de compte)
              TextButton(
                onPressed: () async {
                  await _authService.signOut();
                  if (mounted) {
                    Navigator.of(context).popUntil((route) => route.isFirst);
                  }
                },
                child: const Text(
                  'Utiliser un autre compte',
                  style: TextStyle(color: Colors.red),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

