import 'package:first_project/presentation/providers/app_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:card_swiper/card_swiper.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Login"),
      ),
      body: Center(
          child: Column(
        children: [
          const Text(
            "This is login screen",
            style: TextStyle(fontSize: 18),
          ),
          Swiper(
            itemBuilder: (BuildContext context, int index) {
              return Image.network(
                "https://via.placeholder.com/350x150",
                fit: BoxFit.fill,
              );
            },
            itemCount: 3,
            pagination: const SwiperPagination(),
            control: const SwiperControl(),
          ),
          ElevatedButton(
              onPressed: () async {
                await Provider.of<AppProvider>(context, listen: false)
                    .clearData();
              },
              child: const Text(
                "Clear Data",
                style: TextStyle(fontSize: 18),
              ))
        ],
      )),
    );
  }
}
