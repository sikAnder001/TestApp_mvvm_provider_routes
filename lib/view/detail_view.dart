
import 'package:carousel_indicator/carousel_indicator.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class DetailScreen extends StatefulWidget {
  const DetailScreen({Key? key}) : super(key: key);

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen>  with SingleTickerProviderStateMixin{
  late TabController _controller;
  TextEditingController nameController = TextEditingController();

  final items = [
    Image.asset('assets/led_img.png'),
    Image.asset('assets/led_img.png')
  ];

  @override
  void initState() {
    super.initState();
    _controller = TabController(length: 2, vsync: this);
  }

  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    final height=MediaQuery.of(context).size.height*1;
    final width=MediaQuery.of(context).size.width*1;
    return  Scaffold(
      appBar:   AppBar(
        title:   const Text('Detail page'),
        leading: IconButton(
          onPressed: (){
            Navigator.of(context).pop(context);
            },
          icon: const Icon(Icons.arrow_back),
        ),
      ),
      body:   ListView(
        children: <Widget>[
          SingleChildScrollView(
            child: Column(
              children: [
                CarouselSlider(
                  options: CarouselOptions(
                    autoPlay: true,
                    aspectRatio: 2,
                    viewportFraction: .7,
                    enlargeCenterPage: true,
                    onPageChanged: (index, reason) {
                      setState(() {
                        currentIndex = index;
                      });
                    },
                  ),
                  items: items,
                ),
                CarouselIndicator(
                  count: items.length,
                  index: currentIndex,
                  color: Colors.tealAccent,
                  activeColor: Colors.teal,

                )
              ],
            ),
          ),
          const SizedBox(height: 20,),
          Padding(
            padding: const EdgeInsets.all(5),
            child: TextFormField(
              controller: nameController,
              validator: (value) {
                if (value!.isEmpty) {
                  return "Please Enter Name";
                }
                return null;
              },
              decoration: InputDecoration(
                label: const Text("Name"),
                labelStyle: const TextStyle(color: Colors.blue),
                hintText: "Enter name",
                hintStyle: const TextStyle(color: Colors.grey),
                errorStyle: const TextStyle(color: Colors.yellow),
                filled: true,
                fillColor: Colors.black12,
                border: OutlineInputBorder(
                    borderSide: const BorderSide(width: 3),
                    /* borderSide: BorderSide.none,*/
                    borderRadius: BorderRadius.circular(10)),
              ),
              style: const TextStyle(color: Colors.black),
              cursorColor: Colors.blueAccent,
            ),
          ),

            Container(
            decoration:   BoxDecoration(color: Theme.of(context).primaryColor),
            child:   TabBar(
              indicatorSize: TabBarIndicatorSize.tab,
              indicatorColor: Colors.black,
              dividerColor: Colors.black,
              labelColor: Colors.orange,
              unselectedLabelColor: Colors.black,
              controller: _controller,
              tabs: const [
                Tab(
                  text: 'Address',
                ),
                Tab(
                  text: 'Location',
                ),
              ],
            ),
          ),
            SizedBox(
              height: height*.68,
            child: TabBarView(
                controller: _controller,
                children: <Widget>[
                  Card(
                    child: ListView.builder(
                    itemCount: 20,
                    itemBuilder: (BuildContext context, int index) {
                      return const ListTile(
                        leading: Icon(Icons.home),
                        title: TextField(
                          decoration: InputDecoration(
                              hintText: 'Search for address...'),
                        ),
                      );
                    },
                  ),
                ),
                Card(
                    child:   ListTile(
                      leading: const Icon(Icons.location_on),
                      title:   const Text('Latitude: 48.09342\nLongitude: 11.23403'),
                      trailing:   IconButton(icon: const Icon(Icons.my_location), onPressed: () {}),
                    ),
                  ),
                ],
              ),
            ),
          SizedBox(
            height: height*.1,
          ),
        ],
      ),
        floatingActionButton: SizedBox(
          width: width*.9,
          child: FloatingActionButton.extended(
              elevation: 5,
              onPressed: (){},
            label: const Text('Approve'),
            icon: const Icon(Icons.thumb_up),
            backgroundColor: Colors.pink,
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(5))
          ),
          ),
        ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }


}
