import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';
import 'dart:io';

main() async {
  // Note that using a username and password for gmail only works if
  // you have two-factor authentication enabled and created an App password.
  // Search for "gmail app password 2fa"
  // The alternative is to use oauth.
  String username = 'adib.fikri@aimsglobal.com.my';
  String password = 'Aims@123456';

  final smtpServer = SmtpServer(
      'mail.aimsglobal.com.my',
      ignoreBadCertificate: true,
      ssl: false,
      allowInsecure: true,
      username: username,
      password: password
  );
  // Use the SmtpServer class to configure an SMTP server:
  // final smtpServer = SmtpServer('smtp.domain.com');
  // See the named arguments of SmtpServer for further configuration
  // options.

  // Create our message.
  final message = Message()
    ..from = Address(username, 'adib')
    ..recipients.add('juliani.jaafar@aimsglobal.com.my')
    ..subject = 'Test Dart Mailer library :: 😀 :: ${DateTime.now()}'
    ..text = 'This is the plain text.\nThis is line 2 of the text part.'
    ..html = "<h1>Test</h1>\n<p>Hey! Here's some HTML content</p>";

  try {
    final sendReport = await send(message, smtpServer);
    print('Message sent: $sendReport');
  } on MailerException catch (e) {
    print('Message not sent. $e');
    for (var p in e.problems) {
      print('Problem: ${p.code}: ${p.msg}');
    }
  }
  // DONE
}