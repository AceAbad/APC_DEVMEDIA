import 'package:dostv_app/json/videoinfo.dart';
import 'package:dostv_app/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class LivestreamVideoPage extends StatefulWidget {
  String thumbnail;
  String title;
  String videoUrl;

  LivestreamVideoPage({Key key, this.thumbnail, this.title, this.videoUrl})
      : super(key: key);
  @override
  _LivestreamVideoPageState createState() => _LivestreamVideoPageState();
}

class _LivestreamVideoPageState extends State<LivestreamVideoPage> {
  bool isSwitched = true;

  // for video player
  VideoPlayerController _controller;
  Future<void> _initializeVideoPlayerFuture;
  int _playBackTime;
  //The values that are passed when changing quality
  Duration newCurrentPosition;
  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.asset(widget.videoUrl)
      ..initialize().then((_) {
        // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
        setState(() {
          _controller.play();
        });
      });
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF232D3D),
      body: getBody(),
    );
  }

  Widget getBody() {
    var size = MediaQuery.of(context).size;
    return SafeArea(
      child: Column(
        children: <Widget>[
          _controller.value.initialized
              ? Stack(
                  children: [
                    AspectRatio(
                      aspectRatio: _controller.value.aspectRatio,
                      child: VideoPlayer(_controller),
                    ),
                    AspectRatio(
                      aspectRatio: _controller.value.aspectRatio,
                      child: Center(
                        child: IconButton(
                          icon: Icon(
                            _controller.value.isPlaying
                                ? null
                                : Icons.play_arrow,
                            size: 60,
                            color: Colors.white,
                          ),
                          onPressed: () {
                            setState(() {
                              _controller.value.isPlaying
                                  ? _controller.pause()
                                  : _controller.play();
                            });
                          },
                        ),
                      ),
                    ),
                  ],
                )
              : Container(
                  width: size.width,
                  height: 250,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage(widget.thumbnail),
                          fit: BoxFit.contain)),
                ),
          Expanded(
              child: Container(
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 10, right: 10, top: 10),
                    child: Column(
                      children: <Widget>[
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Container(
                              width: size.width - 80,
                              child: Text(
                                widget.title,
                                style: TextStyle(
                                    fontSize: 18,
                                    color: white.withOpacity(0.8),
                                    fontWeight: FontWeight.w500,
                                    height: 1.3),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 10, right: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Divider(
                    color: white.withOpacity(0.1),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 0, left: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          "More DOSTv",
                          style: TextStyle(
                              fontSize: 14,
                              color: white.withOpacity(0.4),
                              fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 0, right: 0),
                    child: SingleChildScrollView(
                      child: Column(
                        children: List.generate(livestream.length, (index) {
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 20),
                            child: Column(
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 10, right: 10),
                                  child: InkWell(
                                    onTap: () {
                                      _startPlay(livestream[index]);
                                    },
                                    child: Container(
                                      height: 200,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(3),
                                          image: DecorationImage(
                                              colorFilter: ColorFilter.mode(
                                                  Colors.black.withOpacity(0.6),
                                                  BlendMode.dstATop),
                                              image: AssetImage(
                                                  livestream[index]
                                                      ['thumnail_img']),
                                              fit: BoxFit.cover)),
                                      child: new Align(
                                        alignment: Alignment.bottomCenter,
                                        child: Container(
                                            width: double.infinity,
                                            padding: EdgeInsets.only(
                                                left: 0,
                                                top: 0,
                                                bottom: 0,
                                                right: 0),
                                            child: new Stack(
                                              children: <Widget>[
                                                new Positioned(
                                                  child: new Align(
                                                    alignment:
                                                        Alignment.topRight,
                                                    child: Container(
                                                      width: 50,
                                                      height: 20,
                                                      color: Color(0xFF161A20),
                                                      child: Center(
                                                        child: Text(
                                                          livestream[index][
                                                              'video_duration'],
                                                          style: new TextStyle(
                                                            fontWeight:
                                                                FontWeight.w800,
                                                            fontSize: 12.0,
                                                            color: Colors.white,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                new Positioned(
                                                  child: new Align(
                                                    child: Icon(
                                                      Icons.play_arrow,
                                                      size: 60,
                                                      color: Color(0xFF3EC4B2),
                                                    ),
                                                  ),
                                                ),
                                                new Positioned(
                                                  left: 10.0,
                                                  bottom: 15.0,
                                                  child: new Text(
                                                      livestream[index]
                                                          ['title'],
                                                      style: new TextStyle(
                                                        fontWeight:
                                                            FontWeight.w700,
                                                        fontSize: 18.0,
                                                        color: Colors.white,
                                                      )),
                                                ),
                                                new Positioned(
                                                  right: 5.0,
                                                  bottom: 13.0,
                                                  child: Icon(
                                                    Icons.bookmark_outline,
                                                    size: 30,
                                                    color: Color(0xFF3EC4B2),
                                                  ),
                                                ),
                                              ],
                                            )),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        }),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ))
        ],
      ),
    );
  }

  Future<bool> _clearPrevious() async {
    await _controller?.pause();
    return true;
  }

  Future<void> _startPlay(videoItem) async {
    setState(() {
      _initializeVideoPlayerFuture = null;
    });
    Future.delayed(const Duration(milliseconds: 200), () {
      _clearPrevious().then((_) {
        _initializePlay(videoItem['video_url']);
      });
    });

    // new state of video object
    setState(() {
      widget.title = videoItem['title'];
    });
  }

  Future<void> _initializePlay(String videoPath) async {
    _controller = VideoPlayerController.asset(videoPath);
    _controller.addListener(() {
      setState(() {
        _playBackTime = _controller.value.position.inSeconds;
      });
    });
    _initializeVideoPlayerFuture = _controller.initialize().then((_) {
      _controller.seekTo(newCurrentPosition);
      _controller.play();
    });
  }
}
