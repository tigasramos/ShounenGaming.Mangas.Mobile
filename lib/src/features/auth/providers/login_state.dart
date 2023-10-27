class LoginState {
  bool isTokenGenerated;
  bool rememberUsername;

  bool isCreatingToken;
  bool isLoggingIn;
  LoginState({
    this.isTokenGenerated = false,
    this.rememberUsername = true,
    this.isCreatingToken = false,
    this.isLoggingIn = false,
  });

  LoginState copyWith({
    bool? isTokenGenerated,
    bool? rememberUsername,
    bool? isCreatingToken,
    bool? isLoggingIn,
  }) {
    return LoginState(
      isTokenGenerated: isTokenGenerated ?? this.isTokenGenerated,
      isCreatingToken: isCreatingToken ?? this.isCreatingToken,
      rememberUsername: rememberUsername ?? this.rememberUsername,
      isLoggingIn: isLoggingIn ?? this.isLoggingIn,
    );
  }
}
