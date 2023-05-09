import 'package:get/get.dart';

class LanguageChanger extends Translations {
  @override
  // TODO: implement keys
  Map<String, Map<String, String>> get keys => {
        'en_US': {
          'hello': 'Hello',
          'Sign in': 'Sign in',
          'Sign out': 'Sign out',
          'Sign up': 'Sign up',
          'if you already have a account': 'if you already have a account',
          'forgot your password': 'forgot your password',
          'Accept': 'Accept',
          'Decline': 'Decline',
          'Cancel': 'Cancel',
          'Submit': 'Submit',
        },
        'ar_EG': {
          'hello': 'مرحبا',
          'Sign in': 'تسجيل الدخول',
          'Sign out': 'تسجيل الخروج',
          'Sign up': 'تسجيل',
          'if you already have a account': 'لديك حساب بالفعل',
          'forgot your password': 'نسيت كلمة المرور',
          'Accept': 'قبول',
          'Decline': 'رفض',
          'Cancel': 'الغاء',
          'Submit': 'تأكيد',
        }
      };
}
