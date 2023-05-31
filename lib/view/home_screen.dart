import 'package:flutter/material.dart';
import 'package:flutter_api_project_mvvm/res/color.dart';
import 'package:flutter_api_project_mvvm/utils/routes/routes_name.dart';
import 'package:flutter_api_project_mvvm/utils/utils.dart';
import 'package:flutter_api_project_mvvm/view/detail_view.dart';
import 'package:flutter_api_project_mvvm/view_model/user_list_view_model.dart';
import 'package:flutter_api_project_mvvm/view_model/user_view_model.dart';
import 'package:flutter_slider_drawer/flutter_slider_drawer.dart';
import 'package:provider/provider.dart';

import '../data/response/status.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<StatefulWidget> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  UserListViewModel uModel = UserListViewModel();

  @override
  void initState() {
    super.initState();
    uModel.getUserList();
  }

  @override
  Widget build(BuildContext context) {
    final uPreference = Provider.of<UserViewModel>(context);

    GlobalKey<SliderDrawerState> _key = GlobalKey<SliderDrawerState>();
    return Scaffold(
        body: SliderDrawer(
          key: _key,
          appBar: SliderAppBar(
            trailing: PopupMenuButton(
              itemBuilder: (BuildContext context) {
                return [
                  const PopupMenuItem(
                    value: 'Logout',
                    child: Text('Logout'),
                  ),
                ];
              },
              onSelected: (value) {
                if (value == 'Logout') {
                  uPreference.removeUser().then((value) =>
                      Navigator.pushNamed(context, RoutesName.login));
                }
              },
            ),
              appBarColor: Colors.blue,
              appBarHeight: 80,
              title: const Text("Yo Yo",
                  style: TextStyle(
                      fontSize: 22, fontWeight: FontWeight.w700))
          ),
          slider: Container(
            color: Colors.white,
            child: ListView(

              padding: EdgeInsets.zero,
              // Important: Remove any padding from the ListView.
              children: [
                DrawerHeader(
                  decoration: const BoxDecoration(
                    color: Colors.blue,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          const CircleAvatar(
                            radius: 50,
                            backgroundImage: AssetImage("assets/led_img.png"),
                          ),
                          Container(
                            padding: const EdgeInsets.only(left: 10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: const [
                                Text("Shiva",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                    )),
                                Text("24",
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 16)),
                              ],
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
                Card(
                  margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                  shape: RoundedRectangleBorder(
                    side: const BorderSide(color: Colors.white70, width: 1),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: ListTile(
                    leading: const Icon(Icons.home),
                    title: const Text('First'),
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
                Card(
                  margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                  shape: RoundedRectangleBorder(
                    side: const BorderSide(color: Colors.white70, width: 1),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: ListTile(
                    leading: const Icon(
                      Icons.home,
                    ),
                    title: const Text('Page 1'),
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
                Card(
                  margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                  shape: RoundedRectangleBorder(
                    side: const BorderSide(color: Colors.white70, width: 1),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: ListTile(
                    leading: const Icon(
                      Icons.train,
                    ),
                    title: const Text('Page 2'),
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
              ],
            ),
          ),
          child: Container(
            margin: const EdgeInsets.only(top: 0),

            color: Colors.white,
            child: ChangeNotifierProvider<UserListViewModel>(
              create: (BuildContext context) => uModel,
              child: Consumer<UserListViewModel>(
                builder: (context, value, _) {
                  switch (value.userList.status) {
                    case Status.LOADING:
                      return const Center(child: CircularProgressIndicator());
                    case Status.ERROR:
                      return Center(
                        child: Text(value.userList.message.toString()),
                      );
                    case Status.SUCESS:
                      return ListView.builder(
                          itemCount: value.userList.data!.data!.length,
                          itemBuilder: (context, index) {
                            return Card(
                              child: ListTile(
                                leading: SizedBox(
                                  width: 50,
                                  child: ClipOval(
                                    child: Image.network(
                                      fit: BoxFit.cover,
                                      value.userList.data!.data![index].avatar
                                          .toString(),
                                      errorBuilder: (context, error, stack) {
                                        return const Icon(
                                          Icons.error,
                                          color: AppColors.redColor,
                                        );
                                      },
                                    ),
                                  ),
                                ),
                                title: Text(
                                    '${value.userList.data!.data![index].firstName} ${value.userList.data!.data![index].lastName}'),
                                subtitle: Text(
                                    '${value.userList.data!.data![index].firstName}'),
                                onTap: () {
                                  WidgetsBinding.instance.addPostFrameCallback((_) {
                                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const DetailScreen()));
                                  });
                                  Navigator.pushNamed(
                                      context, RoutesName.detailScreen);
                                  Utils.flushBarErrorMessage(
                                      value.userList.data!.data![index].email
                                          .toString(),
                                      context);
                                },
                                trailing: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                        'Rating : ${value.userList.data!.data![index].id}'),
                                    const Icon(
                                      Icons.star,
                                      color: Colors.yellow,
                                    )
                                  ],
                                ),
                              ),
                            );
                          });
                  }
                  return Container();
                },
              ),
            ),
          )),
        );
  }
}
