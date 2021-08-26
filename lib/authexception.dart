enum AuthResultStatus {
  successful,
  emailAlreadyExists,
  wrongPassword,
  invalidEmail,
  userNotFound,
  userDisabled,
  operationNotAllowed,
  tooManyRequests,
  undefined
}

class AuthExceptionHandler {
  static handleException(e) {
    var status;
    switch (e.code) {
      case "ERROR_INVALID_MAIL":
        status = AuthResultStatus.invalidEmail;

        break;
      case "wrong-password":
        status = AuthResultStatus.wrongPassword;
        break;
      case "user-not-found":
        status = AuthResultStatus.userNotFound;
        break;
      case "ERROR_USER_DISABLED":
        status = AuthResultStatus.userDisabled;
        break;
      case "ERROR_TOO_MANY_REQUESTS":
        status = AuthResultStatus.tooManyRequests;
        break;
      case "ERROR_OPERATION_NOT_ALLOWED":
        status = AuthResultStatus.operationNotAllowed;
        break;
      case "ERROR_EMAIL_ALREADY_IN_USE":
        status = AuthResultStatus.emailAlreadyExists;
        break;
      default:
        status = AuthResultStatus.undefined;
    }
    return status;
  }

  static generateExceptionMessage(exceptionCode) {
    String errorMessage;
    switch (exceptionCode) {
      case AuthResultStatus.invalidEmail:
        errorMessage = 'Provide a valid email or use another one';

        break;
      case AuthResultStatus.wrongPassword:
        errorMessage = 'your password is incorrect';
        break;

      case AuthResultStatus.userNotFound:
        errorMessage = 'User with this email doesnt exist';
        break;
      case AuthResultStatus.userDisabled:
        errorMessage = 'user with this email is disabled';
        break;
      case AuthResultStatus.tooManyRequests:
        errorMessage = 'Too many requests, try again later';
        break;
      case AuthResultStatus.operationNotAllowed:
        errorMessage = 'sining with email and password is not enabled';
        break;
      case AuthResultStatus.emailAlreadyExists:
        errorMessage =
            'this email has already been registered. Please login or reset your password';
        break;
      default:
        errorMessage = 'undefined error';
    }
    return errorMessage;
  }
}
