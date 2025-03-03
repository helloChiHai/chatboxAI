import 'package:flutter/material.dart';
import 'package:stock_flutter/models/user_model.dart';
import 'package:stock_flutter/repositories/auth_repository.dart';
import 'package:stock_flutter/services/service_locator.dart';

class UserInformation extends StatefulWidget {
  const UserInformation({super.key});

  @override
  State<UserInformation> createState() => _UserInformationState();
}

class _UserInformationState extends State<UserInformation> {
  Future<User?>? userFuture;

  @override
  void initState() {
    super.initState();
    getUserInformation();
  }

  void getUserInformation() {
    setState(() {
      userFuture = locator<AuthRepository>().getUserFromStorage();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Thông tin người dùng'),
      ),
      body: Center(
        child: FutureBuilder<User?>(
          future: userFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError || !snapshot.hasData) {
              return const Center(child: Text('Không có dữ liệu người dùng!'));
            }

            final user = snapshot.data!;

            return Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('ID: ${user.id}', style: const TextStyle(fontSize: 18)),
                  const SizedBox(height: 8),
                  Text('Tên: ${user.userName}',
                      style: const TextStyle(fontSize: 18)),
                  const SizedBox(height: 8),
                  Text('Email: ${user.email}',
                      style: const TextStyle(fontSize: 18)),
                  const SizedBox(height: 8),
                  Text('Token: ${user.token}',
                      style: const TextStyle(fontSize: 18)),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
