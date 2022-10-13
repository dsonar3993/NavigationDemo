import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyStatefulWidget(),
    );
  }
}

class MyStatefulWidget extends StatefulWidget {
  const MyStatefulWidget({Key? key}) : super(key: key);
  @override
  State<MyStatefulWidget> createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  
  
  int _selectedIndex = 0; // By Default App will open from Home Page (i.e Index of Home Page is 0)
  final TextStyle selectedOptionStyle = const TextStyle(fontSize: 16, fontWeight: FontWeight.bold); // Style for Unselected Labels
  final TextStyle unselectedOptionStyle = const TextStyle(fontSize: 14, fontWeight: FontWeight.bold); // Style for Selected Lable
  List<Widget> bodyWidget = []; // List of Body Widgets
  
  // Function to handle change in Screen from BottomNavigaton or Drawer Menu.
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  // Build list of widgets
  void buildScreenBody(Size screenSize){
    bodyWidget = <Widget>[
    CustomContainer(
      screenSize: screenSize,
      childWidget:Center(
        child: Text(
          'Home Screen',
          style: selectedOptionStyle,
        ),
      ),
    ),
    CustomContainer(
      screenSize: screenSize, 
      childWidget:  Center(
        child: Text(
          'Video Screen',
          style: selectedOptionStyle,
        ),
      ),
    ),
    CustomContainer(
      screenSize: screenSize,
      childWidget: Center(
        child: Text(
          'Music Screen',
          style: selectedOptionStyle,
        ),
      ),
    ),
    CustomContainer(
      screenSize: screenSize,
      childWidget: Center(
        child: Text(
          'Account Screen',
          style: selectedOptionStyle,
        ),
      ),
    ),
  ];
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    buildScreenBody(screenSize); // Create and Initialize Body Widget
    return Scaffold(
      appBar: AppBar(
        title: const Text('Navigation Example'),
      ),
      // Drawer widget
      drawer: Drawer(
        child: Column(
          children: [
            // Drawer Header
            const DrawerHeader(child: Center(child: Text("App Bar Header"),)),
            Expanded(
              child: ListView(   
                children: [
                  ListTile(
                    leading: const Icon(Icons.home),
                    title: const Text("Home"),
                    selected: _selectedIndex==0?true:false,
                    onTap: (){
                      _onItemTapped(0);
                      Navigator.pop(context);
                    } ),
                  const Divider(),
                  ListTile(
                    leading: const Icon(Icons.videocam),
                    title:const Text("Video"),
                    selected: _selectedIndex==1?true:false,
                    onTap: (){
                      _onItemTapped(1);
                      Navigator.pop(context);
                    } ,),
                  ListTile(
                    leading: const Icon(Icons.person),
                    title:const Text("Account"),
                    selected: _selectedIndex==3?true:false,
                    onTap: (){
                      _onItemTapped(3);
                      Navigator.pop(context);
                    }),
                  const Divider(),
                  ListTile(
                    leading: const Icon(Icons.music_note),
                    title:const Text("Music"),
                    selected: _selectedIndex==2?true:false,
                    onTap: (){
                      _onItemTapped(2);
                      Navigator.pop(context);
                    }),
                  const Divider()
                ],
              ),
            ),
          ],
        ),
      ),
      body: bodyWidget.elementAt(_selectedIndex), // Fetch Widget according to selected Index
      bottomNavigationBar: BottomNavigationBar(
        unselectedLabelStyle: unselectedOptionStyle,
        selectedLabelStyle: selectedOptionStyle,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.videocam),
            label: 'Video',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.music_note),
            label: 'Music',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Account',
          ),
        ],
        currentIndex: _selectedIndex, // Identify active index
        selectedItemColor: Colors.black, 
        unselectedItemColor: Colors.grey,
        showUnselectedLabels: true,
        onTap: _onItemTapped, // Handle Navigation from BottomNavigationBar Items.
      ),
    );
  }
}

// Custom Widget for Container

class CustomContainer extends StatelessWidget {
  final Size screenSize;
  final Widget childWidget;
  const CustomContainer({
    Key? key,
    required this.screenSize,
    required this.childWidget
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: screenSize.width,
      height: screenSize.height/3,
      margin: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        border: Border.all()
      ),
      child: childWidget
    );
  }
}
