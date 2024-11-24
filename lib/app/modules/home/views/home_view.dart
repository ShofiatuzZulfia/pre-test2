import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pretest2/app/modules/home/controllers/home_controller.dart';
import 'package:pretest2/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeView extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Padding(
                  padding:
                      const EdgeInsets.only(left: 10.0), // Add left padding
                  child: const Text(
                    'Hello, Shofia!',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(width: 150),
                IconButton(
                  icon: const Icon(Icons.notifications_active_rounded),
                  onPressed: () {},
                ),
              ],
            ),
            PopupMenuButton<String>(
              onSelected: (value) {
                if (value == 'logout') {
                  controller.logout();
                }
              },
              itemBuilder: (BuildContext context) {
                return [
                  PopupMenuItem<String>(
                    value: 'logout',
                    child: Row(
                      children: [
                        Icon(Icons.logout, color: Colors.purple[200]),
                        const SizedBox(width: 10),
                        const Text('Logout'),
                      ],
                    ),
                  ),
                ];
              },
              icon: const Icon(Icons.menu, size: 28),
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder<QuerySnapshot<Object?>>(
              stream: controller.streamData(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.active) {
                  if (snapshot.data!.size != 0) {
                    var data = snapshot.data!.docs;
                    return ListView.builder(
                      itemCount: data.length,
                      itemBuilder: (context, index) {
                        return Card(
                          margin: const EdgeInsets.symmetric(
                              vertical: 8, horizontal: 16),
                          elevation: 2,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Container(
                            height: 100,
                            child: ListTile(
                              contentPadding: const EdgeInsets.only(left: 4),
                              onTap: () => Get.toNamed(Routes.UPDATE,
                                  arguments: data[index].id),
                              title: Padding(
                                padding:
                                    const EdgeInsets.only(left: 15, right: 15),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      data[index]['name'],
                                      style: const TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      data[index]['title'],
                                      style: const TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w100,
                                        color: Colors.black87,
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      '${data[index]['moments']}',
                                      style: const TextStyle(
                                        fontSize: 10,
                                        color: Colors.black54,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              trailing: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  IconButton(
                                    onPressed: () =>
                                        controller.deleteData(data[index].id),
                                    icon: const Icon(Icons.delete,
                                        color: Colors.red),
                                  ),
                                  const SizedBox(width: 8),
                                  const Icon(
                                    Icons.arrow_forward_ios,
                                    color: Colors.black38,
                                    size: 20,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  } else {
                    return const Center(
                      child: Text('Data Belum Ditambahkan'),
                    );
                  }
                } else {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
              },
            ),
          ),
        ],
      ),
      floatingActionButton: ClipOval(
        child: Material(
          color: Colors.purple[200],
          child: InkWell(
            splashColor: Colors.white,
            child: const SizedBox(
              width: 55,
              height: 55,
              child: Icon(Icons.add, color: Colors.white),
            ),
            onTap: () {
              Get.toNamed(Routes.CREATE);
            },
          ),
        ),
      ),
    );
  }
}
