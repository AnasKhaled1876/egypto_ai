# Auth Cubit to Riverpod Migration

## Overview
The authentication system has been successfully migrated from `flutter_bloc` to `flutter_riverpod`. This provides better state management, dependency injection, and testing capabilities.

## Changes Made

### 1. AuthCubit → AuthNotifier
- `AuthCubit` is now `AuthNotifier extends StateNotifier<AuthState>`
- `emit()` calls changed to `state = newState`
- Removed `static AuthCubit get(context)` method

### 2. New Providers
```dart
// Main auth provider
final authProvider = StateNotifierProvider<AuthNotifier, AuthState>((ref) {
  final authRepository = ref.watch(authRepositoryProvider);
  return AuthNotifier(authRepository);
});

// Convenience providers
final otpMailProvider = Provider<String?>((ref) {
  return ref.watch(authProvider.notifier).otpMail;
});

final currentUserProvider = Provider<EgyptoUser?>((ref) {
  return ref.watch(authProvider.notifier).user;
});
```

### 3. App Setup
- Wrapped the app with `ProviderScope`
- Removed `BlocProvider<AuthCubit>` from `MultiBlocProvider`

### 4. Widget Updates

#### Before (Bloc):
```dart
class MyScreen extends StatefulWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        // Handle state changes
      },
      builder: (context, state) {
        return ElevatedButton(
          onPressed: () {
            AuthCubit.get(context).signIn(email, password);
          },
          child: Text('Sign In'),
        );
      },
    );
  }
}
```

#### After (Riverpod):
```dart
class MyScreen extends ConsumerStatefulWidget {
  @override
  ConsumerState<MyScreen> createState() => _MyScreenState();
}

class _MyScreenState extends ConsumerState<MyScreen> {
  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authProvider);
    
    ref.listen<AuthState>(authProvider, (previous, next) {
      // Handle state changes
    });

    return ElevatedButton(
      onPressed: () {
        ref.read(authProvider.notifier).signIn(email, password);
      },
      child: Text('Sign In'),
    );
  }
}
```

## Usage Examples

### 1. Watching Auth State
```dart
final authState = ref.watch(authProvider);
```

### 2. Calling Auth Methods
```dart
// Sign in
ref.read(authProvider.notifier).signIn(email, password);

// Sign up
ref.read(authProvider.notifier).signUp(
  name: name,
  email: email,
  password: password,
);

// Check email
ref.read(authProvider.notifier).checkEmail(email: email);

// Social sign in
ref.read(authProvider.notifier).signInWithSocial(
  email: email,
  providerId: providerId,
  name: name,
  photoUrl: photoUrl,
);
```

### 3. Accessing User Data
```dart
// Get current user
final user = ref.watch(currentUserProvider);

// Get OTP email
final otpEmail = ref.watch(otpMailProvider);
```

### 4. Listening to State Changes
```dart
ref.listen<AuthState>(authProvider, (previous, next) {
  if (next is LoginSuccessState) {
    // Navigate to home
  } else if (next is LoginErrorState) {
    // Show error message
  }
});
```

## Files Updated
- `lib/features/auth/cubit/auth_cubit.dart` - Converted to Riverpod
- `lib/features/auth/presentation/screens/register.dart` - Updated to use Riverpod
- `lib/features/auth/presentation/screens/otp.dart` - Updated to use Riverpod
- `lib/features/start/presentation/screens/login_or_create.dart` - Updated to use Riverpod
- `lib/app.dart` - Added ProviderScope and removed AuthCubit provider

## Benefits of Migration
1. **Better Performance**: Riverpod only rebuilds widgets that actually depend on changed state
2. **Compile-time Safety**: Providers are checked at compile time
3. **Better Testing**: Easier to mock and test providers
4. **No BuildContext Required**: Can access providers from anywhere
5. **Better DevTools**: Enhanced debugging capabilities
6. **Automatic Disposal**: Providers are automatically disposed when not needed

## Migration Checklist
- [x] Convert AuthCubit to AuthNotifier
- [x] Create auth providers
- [x] Update app.dart with ProviderScope
- [x] Update register screen
- [x] Update OTP screen  
- [x] Update login/create screen
- [x] Remove flutter_bloc imports from auth files
- [x] Test all auth flows

The migration is complete and all auth functionality should work as before, but with the benefits of Riverpod's state management system.