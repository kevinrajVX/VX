import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/auth/auth_provider.dart';
import '../../core/localization/generated/app_localizations.dart';
import '../../core/theme/tokens.dart';
import '../../core/widgets/dark_pill_button.dart';
import '../../core/widgets/koperasi_logo.dart';
import '../../core/widgets/pressable.dart';

class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({super.key});

  @override
  ConsumerState<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {
  final _usernameCtrl = TextEditingController();
  final _passwordCtrl = TextEditingController();
  bool _obscurePassword = true;
  bool _loading = false;
  String? _error;

  @override
  void dispose() {
    _usernameCtrl.dispose();
    _passwordCtrl.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    final l = AppL10n.of(context);
    setState(() {
      _loading = true;
      _error = null;
    });

    final ok = await ref
        .read(authProvider.notifier)
        .login(_usernameCtrl.text, _passwordCtrl.text);

    if (!mounted) return;

    if (!ok) {
      setState(() {
        _loading = false;
        _error = l.invalidCredentials;
      });
    }
    // On success the auth state changes, main.dart re-routes to HomeShell.
  }

  @override
  Widget build(BuildContext context) {
    final l = AppL10n.of(context);

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.screenPadding,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 64),

              // Logo
              Center(
                child: const KoperasiLogo(size: 72, showWordmark: true)
                    .animate()
                    .fadeIn(duration: 400.ms)
                    .slideY(
                      begin: -0.1,
                      end: 0,
                      duration: 440.ms,
                      curve: AppMotion.emphasized,
                    ),
              ),

              const SizedBox(height: 56),

              // Sign in heading
              Text(
                l.signIn,
                style: const TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.w800,
                  color: AppColors.textPrimary,
                  letterSpacing: -0.5,
                ),
              ).animate().fadeIn(delay: 80.ms, duration: 340.ms),

              const SizedBox(height: AppSpacing.xxl),

              // Member ID field
              _InputLabel(label: l.memberId)
                  .animate()
                  .fadeIn(delay: 120.ms, duration: 300.ms),
              const SizedBox(height: AppSpacing.sm),
              _TextField(
                controller: _usernameCtrl,
                hint: l.enterMemberId,
                prefixIcon: Icons.badge_outlined,
                keyboardType: TextInputType.text,
                textInputAction: TextInputAction.next,
              ).animate().fadeIn(delay: 140.ms, duration: 300.ms),

              const SizedBox(height: AppSpacing.lg),

              // Password field
              _InputLabel(label: l.password)
                  .animate()
                  .fadeIn(delay: 180.ms, duration: 300.ms),
              const SizedBox(height: AppSpacing.sm),
              _TextField(
                controller: _passwordCtrl,
                hint: l.enterPassword,
                prefixIcon: Icons.lock_outline_rounded,
                obscureText: _obscurePassword,
                textInputAction: TextInputAction.done,
                onSubmitted: (_) => _submit(),
                suffix: Pressable(
                  onTap: () =>
                      setState(() => _obscurePassword = !_obscurePassword),
                  child: Icon(
                    _obscurePassword
                        ? Icons.visibility_off_outlined
                        : Icons.visibility_outlined,
                    size: 20,
                    color: AppColors.textSecondary,
                  ),
                ),
              ).animate().fadeIn(delay: 200.ms, duration: 300.ms),

              // Error message
              if (_error != null) ...[
                const SizedBox(height: AppSpacing.md),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppSpacing.lg,
                    vertical: AppSpacing.md,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.tagAmberBg,
                    borderRadius: BorderRadius.circular(AppRadius.lg),
                  ),
                  child: Text(
                    _error!,
                    style: const TextStyle(
                      color: AppColors.tagAmberText,
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ).animate().fadeIn(duration: 260.ms).shakeX(hz: 3),
              ],

              const SizedBox(height: AppSpacing.xxxl),

              // Sign in button
              _loading
                  ? const Center(
                      child: SizedBox(
                        width: 28,
                        height: 28,
                        child: CircularProgressIndicator(
                          strokeWidth: 2.5,
                          color: AppColors.brandViolet,
                        ),
                      ),
                    )
                  : DarkPillButton(
                      label: l.signIn,
                      onPressed: _submit,
                      onBrand: true,
                    ).animate().fadeIn(delay: 260.ms, duration: 320.ms),
            ],
          ),
        ),
      ),
    );
  }
}

class _InputLabel extends StatelessWidget {
  const _InputLabel({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Text(
      label,
      style: const TextStyle(
        fontSize: 13,
        fontWeight: FontWeight.w600,
        color: AppColors.textPrimary,
        letterSpacing: 0.1,
      ),
    );
  }
}

class _TextField extends StatelessWidget {
  const _TextField({
    required this.controller,
    required this.hint,
    required this.prefixIcon,
    this.obscureText = false,
    this.keyboardType,
    this.textInputAction,
    this.onSubmitted,
    this.suffix,
  });

  final TextEditingController controller;
  final String hint;
  final IconData prefixIcon;
  final bool obscureText;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final ValueChanged<String>? onSubmitted;
  final Widget? suffix;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppRadius.lg),
        border: Border.all(color: AppColors.divider),
        boxShadow: AppShadows.card,
      ),
      child: TextField(
        controller: controller,
        obscureText: obscureText,
        keyboardType: keyboardType,
        textInputAction: textInputAction,
        onSubmitted: onSubmitted,
        style: const TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.w500,
          color: AppColors.textPrimary,
        ),
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: const TextStyle(
            color: AppColors.textSecondary,
            fontSize: 15,
            fontWeight: FontWeight.w400,
          ),
          prefixIcon: Icon(
            prefixIcon,
            size: 20,
            color: AppColors.textSecondary,
          ),
          suffixIcon: suffix != null
              ? Padding(
                  padding: const EdgeInsets.only(right: AppSpacing.md),
                  child: suffix,
                )
              : null,
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.lg,
            vertical: AppSpacing.lg,
          ),
        ),
      ),
    );
  }
}
