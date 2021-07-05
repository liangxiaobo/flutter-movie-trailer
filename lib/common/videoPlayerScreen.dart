import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:video_player/video_player.dart';

class VideoPlayerScreen extends StatefulWidget {
  VideoPlayerScreen({Key? key, required this.videoUrl}) : super(key: key);
  String videoUrl;
  @override
  State<StatefulWidget> createState() => _VoideoPlayerState();
}

class _VoideoPlayerState extends State<VideoPlayerScreen> {
  late VideoPlayerController _controller;
  late Future<void> _initializeVideoPlayerFuture;

  @override
  void initState() {
    // 创建并储存 VideoPlayerController视频控制器
    // 从不同资源中加载
    _controller = VideoPlayerController.network(widget.videoUrl);
    _initializeVideoPlayerFuture = _controller.initialize();
    // 循环播放
    _controller.setLooping(true);

    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        FutureBuilder(
          future: _initializeVideoPlayerFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasError) {
                print('获取视频地址出错');
              }
              // TODO AspectRatio 解释
              return GestureDetector(
                onTap: () {
                  setState(() {
                    if (_controller.value.isPlaying) {
                      _controller.pause();
                    } else {
                      _controller.play();
                    }
                  });
                },
                child: AspectRatio(
                  aspectRatio: _controller.value.aspectRatio,
                  child: Stack(
                    alignment: Alignment.bottomCenter,
                    children: [
                      /// 视频
                      VideoPlayer(_controller),
                      /// 显示播放按钮
                      AnimatedSwitcher(
                        duration: Duration(milliseconds: 50),
                        reverseDuration: Duration(milliseconds: 200),
                        child: _controller.value.isPlaying
                            ? SizedBox.shrink()
                            : Container(
                                color: Colors.black26,
                                child: Center(
                                  child: Icon(Icons.play_arrow, color: Colors.white, size: 80,),
                                ),
                        ),
                      ),
                      /// 显示进度条
                      VideoProgressIndicator(_controller, allowScrubbing: true),
                    ],
                  ),
                ),
              );
            } else {
              return Center(child: CircularProgressIndicator());
            }
          },
        ),

//        Positioned(
//          bottom: 20,
//          child: Container(
//            width: 20,
//            height: 20,
//            child: FloatingActionButton(
//              onPressed: () {
//                setState(() {
//                  if (_controller.value.isPlaying) {
//                    _controller.pause();
//                  } else {
//                    _controller.play();
//                  }
//                });
//              },
//              child: Icon(
//                _controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
//                size: 10,
//              ),
//            ),
//          ),
//        ),
      ],
    );
  }

}
