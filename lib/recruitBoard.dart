import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class Post {
  final String title;
  final String content;

  Post(this.title, this.content);
}

class PostProvider extends ChangeNotifier {
  List<Post> _recruitmentPosts = [];
  List<Post> _recommendationPosts = [];

  List<Post> get recruitmentPosts => _recruitmentPosts;
  List<Post> get recommendationPosts => _recommendationPosts;

  void addRecruitmentPost(Post post) {
    _recruitmentPosts.add(post);
    notifyListeners();
  }

  void addRecommendationPost(Post post) {
    _recommendationPosts.add(post);
    notifyListeners();
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => PostProvider(),
      child: MaterialApp(
        title: '게시판',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: MainScreen(),
      ),
    );
  }
}

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _selectedIndex == 0
          ? AppBarExample()
          : Center(child: Text('마이페이지')),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: '게시판',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: '마이페이지',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}

class AppBarExample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    final Color oddItemColor = colorScheme.primary.withOpacity(0.05);
    final Color evenItemColor = colorScheme.primary.withOpacity(0.15);
    const int tabsCount = 2;

    return DefaultTabController(
      initialIndex: 0,
      length: tabsCount,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('신사동'),
          bottom: TabBar(
            tabs: <Widget>[
              Tab(
                text: '모집중인 크루',
              ),
              Tab(
                text: '추천 크루',
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: <Widget>[
            RecruitmentCrewPage(),
            RecommendationCrewPage(),
          ],
        ),
      ),
    );
  }
}

class RecruitmentCrewPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<PostProvider>(
        builder: (context, postProvider, child) {
          return ListView.builder(
            shrinkWrap: true,
            itemCount: postProvider.recruitmentPosts.length,
            itemBuilder: (context, index) {
              final post = postProvider.recruitmentPosts[index];
              return ListTile(
                leading: CircleAvatar(
                  radius: 50, // CircleAvatar의 크기를 조절하는 부분
                  backgroundImage: AssetImage('assets/your_image.png'), // 이미지 경로 설정
                ),

                title: Text(
                  post.title,
                  style: TextStyle(fontSize: 60, fontWeight: FontWeight.bold),
                ),
                subtitle: Text(
                  post.content,
                  style: TextStyle(fontSize: 30),
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PostDetailScreen(post: post),
                    ),
                  );
                },
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddPostScreen(isRecruitment: true),
            ),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}

class RecommendationCrewPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<PostProvider>(
        builder: (context, postProvider, child) {
          return ListView.builder(
            shrinkWrap: true,
            itemCount: postProvider.recommendationPosts.length,
            itemBuilder: (context, index) {
              final post = postProvider.recommendationPosts[index];
              return ListTile(
                leading: CircleAvatar(
                  radius: 50, // CircleAvatar의 크기를 조절하는 부분
                  backgroundImage: AssetImage('assets/your_image.png'), // 이미지 경로 설정
                ),

                title: Text(
                  post.title,
                  style: TextStyle(fontSize: 60, fontWeight: FontWeight.bold),
                ),
                subtitle: Text(
                  post.content,
                  style: TextStyle(fontSize: 30),
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PostDetailScreen(post: post),
                    ),
                  );
                },
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddPostScreen(isRecruitment: false),
            ),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}



class AddPostScreen extends StatefulWidget {
  final bool isRecruitment;

  AddPostScreen({required this.isRecruitment});

  @override
  _AddPostScreenState createState() => _AddPostScreenState();
}

class _AddPostScreenState extends State<AddPostScreen> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _contentController = TextEditingController();
  final TextEditingController _urlController = TextEditingController();
  String _selectedLocation = ''; // 선택한 지역을 저장하는 변수

  void _showLocationDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('지역 선택'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                title: Text('서울'),
                onTap: () {
                  setState(() {
                    _selectedLocation = '서울';
                  });
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: Text('인천'),
                onTap: () {
                  setState(() {
                    _selectedLocation = '인천';
                  });
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: Text('대전'),
                onTap: () {
                  setState(() {
                    _selectedLocation = '대전';
                  });
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.isRecruitment
              ? '모집중인 크루 게시물 추가'
              : '추천 크루 게시물 추가',
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(height: 30),
            ElevatedButton(
              onPressed: _showLocationDialog, // 지역 선택 다이얼로그 띄우기
              child: Text('지역 찾기'),
            ),
            SizedBox(height: 70),
            TextFormField(
              controller: _titleController,
              maxLines: 2,
              decoration: InputDecoration(
                labelText: '모임이름',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 70),
            TextFormField(
              controller: _contentController,
              maxLines: 15,
              decoration: InputDecoration(
                labelText: '모임에 대해 설명해주세요',
                border: OutlineInputBorder(),
              ),
            ),
            TextFormField(
              controller: _urlController,
              maxLines: 2,
              decoration: InputDecoration(
                labelText: '카카오톡 오픈채팅 URL',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                final postProvider =
                Provider.of<PostProvider>(context, listen: false);
                if (widget.isRecruitment) {
                  postProvider.addRecruitmentPost(
                    Post(_titleController.text, _contentController.text),
                  );
                } else {
                  postProvider.addRecommendationPost(
                    Post(_titleController.text, _contentController.text),
                  );
                }
                Navigator.pop(context);
              },
              child: Text('크루 만들기'),
            ),
          ],
        ),
      ),
    );
  }
}

class PostDetailScreen extends StatelessWidget {
  final Post post;

  PostDetailScreen({required this.post});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(post.title),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Text(post.content),
      ),
    );
  }
}
