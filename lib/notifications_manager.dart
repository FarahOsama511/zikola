// import 'dart:convert';

// import 'package:firebase_crashlytics/firebase_crashlytics.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_secure_storage/flutter_secure_storage.dart';
// import 'package:googleapis_auth/auth_io.dart';
// import 'package:http/http.dart' as http;

// class NotificationsManager {
//   // region Singleton
//   static final NotificationsManager _instance =
//       NotificationsManager._internal();

//   NotificationsManager._internal();

//   static NotificationsManager get instance => _instance;

// //endregion

//   static const String projectId = 'office-coffee-app';
//   static const String fcmUri =
//       'https://fcm.googleapis.com/v1/projects/$projectId/messages:send';
//   // 'https://fcm.googleapis.com/v1/projects/$projectId/messages:send';
//   static const String messagingScope =
//       'https://www.googleapis.com/auth/firebase.messaging';

//   /// Credentials used to authenticate the http calls.
//   /// If it is null, at the first time, it will be created.
//   /// After that, we will check if the access token is valid.
//   /// If it is expired, we are going to refresh it.
//   /// We also need the client to refresh the token.
//   AccessCredentials? _credentials;

//   FirebaseMessaging get fcmInstance => FirebaseMessaging.instance;

//   /// Sends a message to a topic or specific device
//   /// [topic] might be a topic itself or a registered fcm token (the device token)
//   Future<String> sendMessage({
//     required String title,
//     required String message,
//     required String fcmToken,
//   }) async {
//     debugPrint('Send message to token $fcmToken: $message');
//     Map<String, dynamic> notification = {};
//     notification['title'] = title;
//     notification['body'] = message;

//     Map<String, dynamic> body = {};
//     body["message"] = {
//       // 'topic': topic,
//       'token': fcmToken,
//       'notification': notification,
//     };

//     return _post(body);
//   }
//   Future<String> sendMessageByTopic({
//     required String title,
//     required String message,
//     required String topic,
//   }) async {
//     debugPrint('Send message to topic $topic: $message');
//     Map<String, dynamic> notification = {};
//     notification['title'] = title;
//     notification['body'] = message;

//     Map<String, dynamic> body = {};
//     body["message"] = {
//       'topic': topic,
//       'notification': notification,
//     };

//     return _post(body);
//   }

//   /// Send data to the informed destionation
//   /// [data] must have a maximum 3kb
//   Future<String> sendData({
//     required String topic,
//     required Map<String, String> data,
//   }) async {
//     debugPrint('Send data to topic $topic: ');

//     Map<String, dynamic> body = {};
//     body['message'] = {
//       'topic': topic,
//       'data': data,
//     };

//     return _post(body);
//   }

//   /// Posts the message
//   Future<String> _post(Map<String, dynamic> body) async {
//     Map<String, String> headers = await _buildHeaders();
//     return http
//         .post(
//       Uri.parse(fcmUri),
//       headers: headers,
//       body: json.encode(body),
//     )
//         .then((http.Response response) {
//       debugPrint(response.body);
//       return response.body;
//     });
//   }

//   /// Builds default header
//   Future<Map<String, String>> _buildHeaders() async {
//     await _autoRefreshCredentialsInitialize();
//     String token = _credentials!.accessToken.data;
//     Map<String, String> headers = {};
//     headers["Authorization"] = 'Bearer $token';
//     headers["Content-Type"] = 'application/json';
//     return headers;
//   }

//   /// Use service account credentials to obtain oauth credentials.
//   /// Whenever new credentials are available, [_credentials] is updated automatically
//   Future<void> _autoRefreshCredentialsInitialize() async {
//     if (_credentials != null) {
//       return;
//     }

//     // [Assets.files.serviceAccount] is the path to the json created on Services Account
//     // Assets is a class that I created to access easily files on assets folder.

//     // Decode the JSON string into a Dart object
//     final serviceAccount = {
//       "type": "service_account",
//       "project_id": "office-coffee-app",
//       "private_key_id": "1e53eb6d2ffe6a687c5a0525eda3f8ea3fcbd528",
//       "private_key":
//           "-----BEGIN PRIVATE KEY-----\nMIIEuwIBADANBgkqhkiG9w0BAQEFAASCBKUwggShAgEAAoIBAQDWIS+vxKhiIfCz\nKcCTS/EJnIcXodALaYInDyYkdbiaTwM+8TLHvVlxjxnxsKhjPSwrTN2KP7q/Pk2C\ng/UdwuUE9EPx/4vPTa28YB/E7F6SWa0l1mONlZI7tdAX5XLLrzIhMXj+JiLFkBq0\nEeh9aBGxyN7AkOggtz3gNuWmEHDNaHzoeiRmrXyZXoNcnjvy276HG9Jh5tZ0lODF\n23jDPgyXVBhANXnr/ZOvjiBofOV6X1ES/4QKsAO+uJYuaUs9+lI1CGjrzErOK+Yd\nysigVS5u/IE8Yvl4IFWKPUkxExkpmEZKErXe1t/yEbqrY4/f8jd5/BF7UYJ/YV52\nL6gmPW8lAgMBAAECgf9Ey+TGVCjFXqI27fMxX/TRYbkFnrd48y0d34AhtrDY4wnn\n7xahlfRmx9NOE7QGLmFCiC+le1REnX/JrxvRtAxgyxoJZlFFCXAIVdnfKxI3cxhu\nT7MsiiGxjXiONOntBxzUDVESVq5VSzdJI3fO0uDcfe0TcXsjB7yZjQm7kQys8Y43\nWfuhGlrrppC5Q5i61bUXtYGJRzIkWJWbOX+DKSvyjvDY5dPiTlgg3exRkMBS3zN8\n/FdEAfCJsFBwAoUZHyvhqoMf6zRZb+a3YeVnNjdzlOCUW7iMd5y02Iom/b0UDVRi\nwnhgE3QuLI51x8dLVjrHo4+UokoydblL1dcqEtECgYEA/oPquHb0SE+3PCoi6RUx\n6Htinhv07fjwnpalPq1SEa1MrJwOU6Bx2nIKOPAyUt8C+bDInsOVW9WDUfJA06f3\n2rqOfMIoI8IK+unK8cWhbdFz6aW7qDIwzdG3ZfBkoTa+TfA5TBoETCxbG/aIRjdl\ngTLaqlSSUQFRA0xPZTC/ZRECgYEA12D1g1byDhZHnS5YFvhVN4lCn6r+aeYc8KFp\nQehL5MowOunoWxuqI0SjpYfjpNk6BuUiaxwAVth33eirUq2wtClHrQIsE4m+GKJj\nFoyOB7GdWywYw/IXfdfHQvdxVkX7ty7GaJIZ6ubGOSJM7Zu9qK/Oo/BzV14pgH6B\nrx442NUCgYAjt4V//4mGgFFZixw9E3Fei7oqMAguQSobR07HPfFvc5939ap5B+IS\nYsCWfvbA9HTpb2qoBRB3w73bCSEZ0s+QjW+jiGezpO5/icGmLjLaQ3N9zXlJQEnj\nCFQxZQvqJ9GLBHQ1/sytl+ftQ6qaF/oRqH5ROu8RmRqyWMonjDC/0QKBgQCAArjp\nnzuu878MxQbGYEMGByb6D3+3IXYB723IJnE1Qpb37R6VSBQPcjRxphq/V/0NLBMQ\n5kutUmusESYCtglYi1B2m9vmoO/DZIDQXinsmLyV+9ecXr9npGBihP9v75h0f/Cd\nJnkRDKi0PJbMgsxu/k8rUTa8rtKr9ITPuH7BIQKBgHbY7pyGiKabJaC7diABEZw1\nn+Z4tBkzWmC+f5D48IE/6NwQBOFz3IslAKd+5iel2qvk1Q+EbGGwxgbXU5WaZX/A\nhFyLph6Ou87ZNx6qHhnmebeBvh/2ZCvlnscp14QegA/ZHff0Gc42R3QpKcptFCo6\njnkBB1zC70G60ksYQnKr\n-----END PRIVATE KEY-----\n",
//       "client_email": "mrcs-books-app@appspot.gserviceaccount.com",
//       "client_id": "1063184887557-d0acrbckq57611osdi414p30pusvv0p4.apps.googleusercontent.com",
//       "auth_uri": "https://accounts.google.com/o/oauth2/auth",
//       "token_uri": "https://oauth2.googleapis.com/token",
//       "auth_provider_x509_cert_url":
//           "https://www.googleapis.com/oauth2/v1/certs",
//       "client_x509_cert_url":
//           "https://www.googleapis.com/robot/v1/metadata/x509/mrcs-books-app%40appspot.gserviceaccount.com",
//       "universe_domain": "googleapis.com"
//     };
//     var accountCredentials = ServiceAccountCredentials.fromJson(serviceAccount);

//     AutoRefreshingAuthClient autoRefreshingAuthClient =
//         await clientViaServiceAccount(
//       accountCredentials,
//       [messagingScope],
//     );

//     /// initialization
//     _credentials = autoRefreshingAuthClient.credentials;

//     // when new credetials are available, _credentials will be updated
//     // (it checks if the current credentials is expired)
//     autoRefreshingAuthClient.credentialUpdates.listen((credentials) {
//       _credentials = credentials;
//     });
//   }

//   //region Registered Token

//   Future<void> requestMessagingToken() async {
//     // Get the token each time the application loads
//     String? token = await fcmInstance.getToken();

//     // Save the initial token to the database
//     await _saveTokenToSharedPreference(token!);

//     // Any time the token refreshes, store this in the database too.
//     fcmInstance.onTokenRefresh.listen(_saveTokenToSharedPreference);
//   }

//   /// Verifica a necessidade de persistir o token
//   Future<void> _saveTokenToSharedPreference(String token) async {
//     FlutterSecureStorage prefs = FlutterSecureStorage();

//     // verifica se é igual ao anterior
//     String? prev = await prefs.read(key: 'tokenMessaging');

//     if (prev == token) {
//       debugPrint('Device registered!');
//       return;
//     }

//     try {
//       await prefs.write(key: "tokenMessaging", value: token);
//       debugPrint('Firebase token saved!');
//     } catch (e) {
//       FirebaseCrashlytics.instance.recordError(e, null);
//       print(e);
//     }
//   }

//   Future<String?> get firebaseToken {
//     FlutterSecureStorage prefs = FlutterSecureStorage();
//     return prefs.read(key: 'tokenMessaging');
//   }

// //endregion
// }
