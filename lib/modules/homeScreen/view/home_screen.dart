import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ops/modules/homeScreen/controller/home_screen_controller.dart';

import '../widgets/drawer.dart';

class HomeScreen extends StatefulWidget {
   const HomeScreen({Key? key,required this.number}) : super(key: key);
  final String number;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}


class _HomeScreenState extends State<HomeScreen> {
  final HomeScreenController controller = Get.put(HomeScreenController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: const Text('HomeScreen'),
        centerTitle: true,
        elevation: 0,
      ),
      drawer: MainDrawer(mobileNumber: widget.number,),

      body:SafeArea(child: Obx(() => controller.checkLoading().isTrue
          ? const Center(child: CircularProgressIndicator(backgroundColor: Colors.white,color: Colors.red,))
          : ListView(
        children: [
          Text('Welcome to HomeScreen!'),

        ],
      ),
      ),
      ),
    );
  }
}
