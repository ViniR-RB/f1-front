import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/models/notice.dart';
import '../home_controller.dart';
import '../states/home_state.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final HomeController _controller = Modular.get<HomeController>();

  @override
  void initState() {
    _controller.fetchNotices();
    _listeners();
    super.initState();
  }

  @override
  dispose() {
    super.dispose();
    _listeners();
  }

  _listeners() {
    _controller.addListener(() {
      if (_controller.state is HomeFetchExceptionState) {
        Modular.to.navigate('/');
        final state = _controller.state as HomeFetchExceptionState;
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(state.message),
        ));
      } else if (_controller.state is HomeExceptionState) {
        Modular.to.navigate('/');
        final state = _controller.state as HomeExceptionState;
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(state.message),
        ));
      } else if (_controller.state is HomeUnathorizedState) {
        final state = _controller.state as HomeUnathorizedState;
        print('Exception');
        Modular.to.navigate('/');
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(state.message),
        ));
      } else if (_controller.state is HomeExceptionState) {
        print('Exception');
        final state = _controller.state as HomeUnathorizedState;
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(state.message),
        ));
        Modular.to.navigate('/');
      }
      setState(
        () {},
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget body = Container();
    if (_controller.state is HomeLoadedState) {
      final HomeLoadedState state = _controller.state as HomeLoadedState;
      final List<NoticeModel> notices = state.notice;

      body = notices.isNotEmpty
          ? SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: Expanded(
                child: ListView.builder(
                  itemCount: notices.length,
                  itemBuilder: (context, index) {
                    final NoticeModel notice = notices[index];
                    return Padding(
                      key: Key('${notice.id}'),
                      padding: const EdgeInsets.all(16.0),
                      child: Container(
                        decoration: const BoxDecoration(
                          color: Color(0xff3C3838),
                          shape: BoxShape.rectangle,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(32),
                            topRight: Radius.circular(32),
                          ),
                        ),
                        width: MediaQuery.of(context).size.width,
                        child: Column(children: [
                          ClipRRect(
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(32),
                              topRight: Radius.circular(32),
                            ),
                            child: Image.network(
                              notice.image,
                              fit: BoxFit.cover,
                              height: 188,
                              width: MediaQuery.of(context).size.width,
                            ),
                          ),
                          const SizedBox(
                            height: 7,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 4.0),
                            child: Text(
                              notice.title,
                              textAlign: TextAlign.justify,
                              softWrap: true,
                              style: GoogleFonts.poppins(
                                  textStyle: const TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      overflow: TextOverflow.clip,
                                      color: Colors.white)),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 4.0),
                            child: Text(
                              notice.body,
                              softWrap: true,
                              textAlign: TextAlign.justify,
                              maxLines: 3,
                              style: GoogleFonts.poppins(
                                textStyle: const TextStyle(
                                  fontSize: 16,
                                  color: Color(0xffA4A4A4),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 4,
                          ),
                          const SizedBox(
                            height: 53,
                          ),
                          Text("${notice.creator} - ${notice.creationDate}",
                              textAlign: TextAlign.start,
                              overflow: TextOverflow.clip,
                              style: GoogleFonts.poppins(
                                textStyle: const TextStyle(
                                  fontSize: 14,
                                  color: Color(0xffA4A4A4),
                                ),
                              )),
                          const SizedBox(
                            height: 32,
                          )
                        ]),
                      ),
                    );
                  },
                ),
              ),
            )
          : const Center(
              child: Text('Não há notícias'),
            );
    } else if (_controller.state is HomeLoadignState) {
      body = const Center(
        child: CircularProgressIndicator(),
      );
    }
    return Scaffold(
      drawer: const Drawer(),
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: const Color.fromRGBO(119, 18, 18, 1),
        title: const Text('Noticias'),
        actions: [
          IconButton(
            onPressed: () => _controller.fetchNotices(),
            icon: const Icon(Icons.refresh),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.search),
          ),
        ],
      ),
      body: body,
    );
  }
}
