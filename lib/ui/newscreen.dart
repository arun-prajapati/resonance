import 'dart:async';

import 'dart:io';

import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:in_app_review/in_app_review.dart';
import 'package:perfect_volume_control/perfect_volume_control.dart';
import 'package:resonance/ui/webview.dart';
import 'package:resonance/volume/colors.dart';
import 'package:resonance/volume/pref.dart';
import 'package:share_plus/share_plus.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';
import 'package:url_launcher/url_launcher.dart';

List<MusicData> showMeditation = [
  MusicData(
      image: 'assets/images/iconsforest.png',
      music: 'assets/audios/woodsmorning.wav',
      title: 'Woods morningr',
      id: '8'),
  MusicData(
      image: 'assets/images/iconsheavyrain.png',
      music: 'assets/audios/raintropical.wav',
      title: 'Rain Tropical',
      id: '9'),
  MusicData(
      image: 'assets/images/ic_thunderstorm.png',
      music: 'assets/audios/rainthunderstorm.wav',
      title: 'Rain Thunderstrom',
      id: '10'),
  MusicData(
      image: 'assets/images/ic_softrain.png',
      music: 'assets/audios/rainsoft.wav',
      title: 'Rain soft',
      id: '11'),
  MusicData(
      image: 'assets/images/ic_cricket.png',
      music: 'assets/audios/raincrickets.wav',
      title: 'Rain Cricket',
      id: '12'),
  MusicData(
      image: 'assets/images/ic_bird.png',
      music: 'assets/audios/forestbirds.wav',
      title: 'Forest Birds',
      id: '13'),
];

List<MusicData> showSleep = [
  MusicData(
      image: 'assets/images/iconairconditioner.png',
      music: 'assets/audios/aircond.wav',
      title: 'Air Conditioner',
      id: '1'),
  MusicData(
      image: 'assets/images/iconvacuumcleaner.png',
      music: 'assets/audios/vaccumcleaner.wav',
      title: 'Vaccum cleaner',
      id: '2'),
  MusicData(
      image: 'assets/images/whitewave.png',
      music: 'assets/audios/whitenoise.wav',
      title: 'White Noise',
      id: '3'),
  MusicData(
      image: 'assets/images/brownwave.png',
      music: 'assets/audios/brownnoise.wav',
      title: 'Brown Noise',
      id: '4'),
  MusicData(
      image: 'assets/images/pinkwave.png',
      music: 'assets/audios/pinknoise.wav',
      title: 'Pink Noise',
      id: '5'),
  MusicData(
      image: 'assets/images/iconhairdryer.png',
      music: 'assets/audios/hairdrier.wav',
      title: 'Hair Dryer',
      id: '6'),
  MusicData(
      image: 'assets/images/iconheartbeats.png',
      music: 'assets/audios/heartbeat.wav',
      title: 'Heartbeat',
      id: '7'),
];

List<MusicData> showSpa = [
  MusicData(
      image: 'assets/images/ic_park.png',
      music: 'assets/audios/citypark.wav',
      title: 'City park',
      id: '14'),
  MusicData(
      image: 'assets/images/iconskyscraper.png',
      music: 'assets/audios/citysky.wav',
      title: 'City skyscraper',
      id: '15'),
  MusicData(
      image: 'assets/images/ic_relax.png',
      music: 'assets/audios/morningloop.wav',
      title: 'Morningloop',
      id: '16'),
  MusicData(
      image: 'assets/images/iconshower.png',
      music: 'assets/audios/showerloop.wav',
      title: 'Showerloop',
      id: '17'),
  MusicData(
      image: 'assets/images/iconfan.png',
      music: 'assets/audios/largefan.wav',
      title: 'Fan',
      id: '18'),
  MusicData(
      image: 'assets/images/iconac.png',
      music: 'assets/audios/airfactory.wav',
      title: 'Acfan',
      id: '19'),
];

List<timerListvalue> showTImer = [
  timerListvalue(id: '1', value: '12960000', title: '∞'),
  timerListvalue(id: '2', value: '1800', title: '30m'),
  timerListvalue(id: '3', value: '3600', title: '1h'),
  timerListvalue(id: '4', value: '5400', title: '1:30h'),
  timerListvalue(id: '5', value: '10800', title: '3h'),
  timerListvalue(id: '6', value: '16200', title: '4:30h'),
  timerListvalue(id: '7', value: '21600', title: '6h'),
  timerListvalue(id: '8', value: '27000', title: '7:30h'),
  timerListvalue(id: '9', value: '33400', title: '9h'),
];

class MusicData {
  final String image;
  final String music;
  final String title;
  final String id;
  MusicData({
    required this.image,
    required this.music,
    required this.title,
    required this.id,
  });
}

class newscreen extends StatefulWidget {
  const newscreen({super.key});

  @override
  State<newscreen> createState() => _newscreenState();
}

class timerListvalue {
  final String id;
  final String value;
  final String title;
  timerListvalue({
    required this.id,
    required this.value,
    required this.title,
  });
}

class _newscreenState extends State<newscreen> {
  int volume = 0;
  bool liked = true;
  bool click = false;
  bool isPlayMusic = false;
  bool isbgmusicstart = false;
  double currentvol = 0.0;
  int startmusic = 0;
  int startmusic1hour = 3600;
  int newStartmusic = 0;
  double currentVolume = 0.0;

  bool wait = false;
  bool connection = false;
  final assetsAudioPlayer = AssetsAudioPlayer();
  final assetsAudioplayer1 = AssetsAudioPlayer();
  // final assetsAudioplayer2 = AssetsAudioPlayer();

  Timer? timer;
  String selectedID = '';
  String selectedSong = '';
  String selectedSongName = '';
  String selectedSongImage = '';
  String selectedTimerId = '';
  String selectedTimerValue = '';

  BannerAd? _bannerAd;
  bool _isLoaded = false;
  InterstitialAd? _interstitialAd;

  // TODO: replace this test ad unit with your own ad unit.
  final adUnitId = Platform.isAndroid

      ///live
      ? 'ca-app-pub-4241889053901858/6306847536'
      : 'ca-app-pub-4241889053901858/9407939009';

  // /// test
  // ? 'ca-app-pub-3940256099942544/6300978111'
  // : 'ca-app-pub-3940256099942544/2934735716';

  final adUnitIdFullScreen = Platform.isAndroid

      /// live
      ? 'ca-app-pub-4241889053901858/2814610499'
      : 'ca-app-pub-4241889053901858/3427449046';

  /// test
  // ? 'ca-app-pub-3940256099942544/1033173712'
  // : 'ca-app-pub-3940256099942544/4411468910';

  void loadAd() {
    InterstitialAd.load(
        adUnitId: adUnitIdFullScreen,
        request: const AdRequest(),
        adLoadCallback: InterstitialAdLoadCallback(
          // Called when an ad is successfully received.
          onAdLoaded: (ad) {
            debugPrint('$ad loaded.');
            // Keep a reference to the ad so you can show it later.
            _interstitialAd = ad;
          },
          // Called when an ad request failed.
          onAdFailedToLoad: (LoadAdError error) {
            debugPrint('InterstitialAd failed to load: $error');
          },
        ));
    _bannerAd = BannerAd(
      adUnitId: adUnitId,
      request: const AdRequest(),
      size: AdSize.banner,
      listener: BannerAdListener(
        // Called when an ad is successfully received.
        onAdLoaded: (ad) {
          debugPrint('$ad loaded.');
          setState(() {
            _isLoaded = true;
          });
        },
        // Called when an ad request failed.
        onAdFailedToLoad: (ad, error) {
          debugPrint('BannerAd failed to load: $error');
          // Dispose the ad here to free resources.
          ad.dispose();
        },
      ),
    )..load();
  }

  audio() async {
    try {
      await assetsAudioplayer1.open(
        Audio("assets/audios/brain.wav",
            metas: Metas(
                title: "Background",
                image: MetasImage.asset('assets/images/citysky.png'))),
        autoStart: false,
        loopMode: LoopMode.single,
        showNotification: false,
        notificationSettings: NotificationSettings(
          nextEnabled: false,
          prevEnabled: false,
        ),
        audioFocusStrategy:
            AudioFocusStrategy.request(resumeOthersPlayersAfterDone: true),
      );

      volume = currentVolume.toInt();
    } catch (t) {}
  }

  // _sendingMails() async {
  //   var url = Uri.parse("http://flutter.dev.com");
  //   if (await canLaunchUrl(url)) {
  //     await launchUrl(url);
  //   } else {
  //     throw 'Could not launch $url';
  //   }
  // }
  sendEmail(String email) async {
    String? encodeQueryParameters(Map<String, String> params) {
      return params.entries
          .map((e) =>
              '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}')
          .join('&');
    }

    final Uri emailLaunchUri = Uri(
        scheme: 'mailto',
        path: '$email',
        query: encodeQueryParameters(<String, String>{
          'subject': 'Default subject',
          'body': 'Default body',
        }));

    await launch(emailLaunchUri.toString());
  }

  playMusic() async {
    if (selectedSong.isNotEmpty) {
      if (!isPlayMusic) {
        if (selectedTimerId.isEmpty) {
          isPlayMusic = true;
          print(true);
          assetsAudioPlayer.open(
              Audio(
                selectedSong,
                metas: Metas(
                    title: selectedSongName,
                    album: "Meditation",
                    image: MetasImage.asset(selectedSongImage)),
              ),
              loopMode: LoopMode.single,
              showNotification: true,
              audioFocusStrategy: AudioFocusStrategy.request(
                  resumeOthersPlayersAfterDone: true),
              notificationSettings: NotificationSettings(
                nextEnabled: false,
                prevEnabled: false,
              ));
          setState(() {});
        } else {
          newStartmusic = int.parse(selectedTimerValue);
          assetsAudioPlayer.open(
              Audio(
                selectedSong,
                metas: Metas(
                    title: selectedSongName,
                    album: "Meditation",
                    image: MetasImage.asset(selectedSongImage)),
              ),
              loopMode: LoopMode.single,
              showNotification: false,
              audioFocusStrategy: AudioFocusStrategy.request(
                  resumeOthersPlayersAfterDone: true),
              notificationSettings: NotificationSettings(
                nextEnabled: false,
                prevEnabled: false,
              ));
          getString('timingaudio');
          const onsec = Duration(seconds: 1);
          Timer? me;

          Timer.periodic(onsec, (timer) {
            if (newStartmusic == 0) {
              setState(() {
                timer.cancel();
                wait = false;
                assetsAudioPlayer.stop();
                selectedID = '';
                selectedSongImage = '';
                selectedSongName = '';
                selectedSong = '';
                selectedTimerId = '';
                selectedTimerValue = '';
              });
            } else {
              setState(() {
                newStartmusic--;
              });
              assetsAudioPlayer.play();
            }
          });
        }
      } else {
        print(false);
        isPlayMusic = false;
        assetsAudioPlayer.stop();

        if (timer != null) {
          timer!.cancel();
        }
        setState(() {});
        playMusic();
      }
    } else {
      print(false);
      isPlayMusic = false;
      assetsAudioPlayer.stop();
      newStartmusic = 0;
      if (timer != null) {
        timer!.cancel();
      }
      setState(() {});

      // playMusic();
    }
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
    return WillPopScope(
      onWillPop: () async {
        return true;
      },
      child: Scaffold(
          appBar: AppBar(
            elevation: 0.0,
            backgroundColor: Color.fromARGB(255, 5, 4, 36),
            centerTitle: true,
            leading: Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Image.asset(
                'assets/images/resonancewhite.png',
                height: 20,
                width: 20,
              ),
            ),
            title: GestureDetector(
              onTap: () async {
                if (Platform.isIOS) {
                  await launchUrl(
                    Uri.parse(
                        "https://apps.apple.com/us/app/resonance-baby-sleep/id6463153916"),
                    mode: LaunchMode.externalApplication,
                  );
                } else {
                  await launchUrl(
                    Uri.parse(
                        "https://play.google.com/store/apps/details?id=com.amin.resonnce_all"),
                    mode: LaunchMode.externalApplication,
                  );
                }
              },
              child: Image.asset(
                'assets/images/noads.png',
                height: 40,
                fit: BoxFit.cover,
                color: Colors.white,
              ),
            ),
            actions: [
              IconButton(
                onPressed: () {
                  click = !click;
                  //  _openAppReview();
                  setState(() {});
                },
                icon: Image.asset(
                  'assets/images/iconsheart.png',
                  fit: BoxFit.cover,
                  color: click ? Colors.red : Colors.white,
                  height: 30,
                ),
              ),
              IconButton(
                onPressed: () {
                  Share.share('com.amin.resonance');
                },
                color: Colors.white,
                icon: Image.asset(
                  'assets/images/ic_sharing.png',
                  fit: BoxFit.cover,
                  color: Colors.white,
                  height: 30,
                ),
              ),
              PopupMenuButton(
                position: PopupMenuPosition.under,
                icon: Icon(
                  Icons.more_horiz_rounded,
                ),
                offset: Offset(
                  100,
                  10,
                ),
                elevation: 8,
                color: Color.fromARGB(255, 255, 255, 255),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                tooltip: '',
                itemBuilder: (context) => [
                  PopupMenuItem(
                    value: 1,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Contact us',
                          style: TextStyle(
                              color: Colors.black, fontWeight: FontWeight.w600),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          height: 1,
                          color: Colors.black,
                        ),
                      ],
                    ),
                  ),
                  PopupMenuItem(
                    value: 2,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Terms Of Services',
                          style: TextStyle(
                              color: Colors.black, fontWeight: FontWeight.w600),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          height: 1,
                          color: Colors.black,
                        ),
                      ],
                    ),
                  ),
                  PopupMenuItem(
                    value: 3,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Privacy Policy',
                          style: TextStyle(
                              color: Colors.black, fontWeight: FontWeight.w600),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          height: 1,
                          color: Colors.black,
                        ),
                      ],
                    ),
                  ),
                  PopupMenuItem(
                    value: 4,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Copyright',
                          style: TextStyle(
                              color: Colors.black, fontWeight: FontWeight.w600),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          height: 1,
                          color: Colors.black,
                        ),
                      ],
                    ),
                  ),
                  PopupMenuItem(
                    value: 5,
                    child: Center(
                      child: Container(
                          height: 30,
                          alignment: Alignment.center,
                          width: 50,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.black,
                          ),
                          child: Text(
                            'Ok',
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          )),
                    ),
                  ),
                ],
                onSelected: (value) async {
                  if (value == 1) {
                    sendEmail('the.resonance.app@gmail.com');
                  } else if (value == 2) {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => webscreen()));
                  } else if (value == 3) {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => webscreen()));
                  } else if (value == 4) {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => webscreen()));
                  } else {}
                },
              ),
            ],
          ),
          body: Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
              colors: [
                Color.fromARGB(255, 5, 4, 36),
                Color.fromARGB(255, 5, 4, 36),
              ],
              begin: Alignment.center,
              end: Alignment.bottomRight,
            )),
            child: Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Column(
                          children: [
                            Container(
                              height: MediaQuery.of(context).size.height / 3,
                              decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                colors: [
                                  Color.fromARGB(255, 43, 43, 71)
                                      .withOpacity(0.8),
                                  Color.fromARGB(255, 43, 43, 71)
                                      .withOpacity(0.8),
                                ],
                                begin: Alignment.center,
                                end: Alignment.bottomRight,
                              )),
                              width: MediaQuery.of(context).size.width,
                              child: Stack(
                                alignment: Alignment.bottomCenter,
                                children: [
                                  Center(
                                    child: SleekCircularSlider(
                                      appearance: CircularSliderAppearance(
                                        startAngle: 90,
                                        angleRange: 360,
                                        size:
                                            MediaQuery.of(context).size.height /
                                                4,
                                        customWidths: CustomSliderWidths(
                                          trackWidth: 20,
                                          progressBarWidth: 20,
                                          handlerSize: 20,
                                        ),
                                        customColors: CustomSliderColors(
                                            hideShadow: true,
                                            progressBarColors: colors = [
                                              Colors.indigo,
                                              Colors.green,
                                            ],
                                            trackColor: Colors.black,
                                            dotColor: Colors.white),
                                      ),
                                      min: 0,
                                      max: 1,
                                      initialValue: currentVolume,
                                      onChange: (value) {
                                        setState(() {
                                          currentVolume = value;
                                        });
                                        setVolume(value);
                                      },
                                      onChangeStart: (double startValue) {},
                                      onChangeEnd: (double endValue) {
                                        print('end');
                                      },
                                      innerWidget: (double value) {
                                        return Center(
                                          child: GestureDetector(
                                            onTap: () {
                                              isbgmusicstart = !isbgmusicstart;
                                              setState(() {});
                                              if (isbgmusicstart) {
                                                // print(assetsAudioPlayer
                                                //     .getCurrentAudioTitle
                                                //     .toString());
                                                assetsAudioplayer1.play();
                                              } else {
                                                assetsAudioplayer1.stop();
                                              }
                                            },
                                            child: Container(
                                                alignment: Alignment.center,
                                                height: MediaQuery.of(context)
                                                        .size
                                                        .height /
                                                    6,
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width /
                                                    2.9,
                                                decoration: BoxDecoration(
                                                    color: isbgmusicstart
                                                        ? Color.fromARGB(
                                                            255, 247, 239, 246)
                                                        : Color.fromARGB(
                                                                96, 175, 175, 219)
                                                            .withOpacity(0.2),
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                100))),
                                                child: isbgmusicstart
                                                    ? Image.asset(
                                                        'assets/images/bluebrain.png',
                                                        height: 80,
                                                        fit: BoxFit.cover,
                                                        color: Colors.cyan,
                                                      )
                                                    : Image.asset(
                                                        'assets/images/blackbrain.png',
                                                        height: 80,
                                                        fit: BoxFit.cover,
                                                        color: Colors.white,
                                                      )),
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(18.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              liked = !liked;
                                              wait = !wait;
                                              // selectedTImer = '';
                                              selectedTimerId = '';
                                              selectedTimerValue = '';
                                              // timerindex = null;
                                              isbgmusicstart = false;
                                              wait = false;
                                              isPlayMusic = false;
                                              selectedID = '';
                                              selectedSong = '';
                                              selectedSongName = '';
                                              selectedSongImage = '';
                                              startmusic = 00;
                                              startmusic1hour = 00;
                                              newStartmusic = 00;
                                              assetsAudioPlayer.stop();
                                              assetsAudioplayer1.stop();
                                              // assetsAudioplayer2.stop();
                                            });
                                            if (_interstitialAd != null) {
                                              _interstitialAd!.show();
                                              loadAd();
                                            }
                                          },
                                          child: Container(
                                              child: Icon(
                                            Icons.stop_circle_outlined,
                                            size: 50,
                                            color:
                                                Colors.white.withOpacity(0.8),
                                          )),
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            isbgmusicstart = false;
                                            selectedID = '';
                                            selectedSong = '';
                                            selectedSongName = '';
                                            selectedSongImage = '';
                                            selectedTimerId = '';
                                            selectedTimerValue = '';
                                            startmusic = 00;
                                            startmusic1hour = 00;
                                            newStartmusic = 00;
                                            assetsAudioPlayer.stop();
                                            assetsAudioplayer1.stop();
                                            isPlayMusic = false;
                                            if (timer != null) {
                                              timer!.cancel();
                                            }
                                            setState(() {});
                                            showModalBottomSheet(
                                                backgroundColor:
                                                    Colors.transparent,
                                                context: context,
                                                builder: (context) {
                                                  return StatefulBuilder(
                                                      builder: (context,
                                                          StateSetter
                                                              filterState) {
                                                    return Container(
                                                      height: 150,
                                                      decoration: BoxDecoration(
                                                          color:
                                                              Color(0xffFFFFFF),
                                                          borderRadius:
                                                              BorderRadius.only(
                                                                  topLeft: Radius
                                                                      .circular(
                                                                          25),
                                                                  topRight: Radius
                                                                      .circular(
                                                                          25))),
                                                      child: Column(
                                                        children: [
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(10.0),
                                                            child: Row(
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .center,
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceBetween,
                                                              children: [
                                                                Text('  '),
                                                                Text(
                                                                  'Choose the duration',
                                                                  style: TextStyle(
                                                                      color: Colors
                                                                          .black,
                                                                      fontSize:
                                                                          20,
                                                                      fontFamily:
                                                                          'BeVietnam',
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w800),
                                                                ),
                                                                Padding(
                                                                  padding:
                                                                      const EdgeInsets
                                                                          .all(
                                                                          0.0),
                                                                  child:
                                                                      InkWell(
                                                                    onTap: () {
                                                                      Navigator.pop(
                                                                          context);
                                                                    },
                                                                    child: Image
                                                                        .asset(
                                                                      'assets/images/close.png',
                                                                      fit: BoxFit
                                                                          .cover,
                                                                      height:
                                                                          35,
                                                                    ),
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                          SizedBox(
                                                            height: 50,
                                                            child: ListView
                                                                .builder(
                                                                    scrollDirection:
                                                                        Axis
                                                                            .horizontal,
                                                                    itemCount:
                                                                        showTImer
                                                                            .length,
                                                                    itemBuilder:
                                                                        (BuildContext
                                                                                context,
                                                                            int index) {
                                                                      return _buildtimerset(
                                                                          context,
                                                                          index,
                                                                          filterState);
                                                                    }),
                                                          ),
                                                        ],
                                                      ),
                                                    );
                                                  });
                                                });
                                          },
                                          child: Container(
                                              child: Image.asset(
                                            'assets/images/ic_stopwatch.png',
                                            fit: BoxFit.cover,
                                            height: 50,
                                            color: wait
                                                ? Colors.blue
                                                : Colors.white,
                                          )),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 0,
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                left: 15.0,
                                right: 15,
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    height: 1,
                                    width:
                                        MediaQuery.of(context).size.width / 3,
                                    decoration: BoxDecoration(
                                      boxShadow: [
                                        BoxShadow(
                                            blurRadius: 1.0,
                                            color: Color.fromARGB(
                                                255, 172, 164, 164)),
                                      ],
                                    ),
                                  ),
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(0),
                                    child: Container(
                                        child: Image.asset(
                                      'assets/images/ic_sleeping.png',
                                      fit: BoxFit.cover,
                                      height: 40,
                                      color: Colors.white,
                                    )),
                                  ),
                                  Container(
                                    height: 1,
                                    width:
                                        MediaQuery.of(context).size.width / 3,
                                    decoration: BoxDecoration(
                                      boxShadow: [
                                        BoxShadow(
                                            blurRadius: 1.0,
                                            color: Color.fromARGB(
                                                255, 172, 164, 164)),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            SizedBox(
                              height: MediaQuery.of(context).size.height / 9,
                              child: MediaQuery.removePadding(
                                removeTop: true,
                                context: context,
                                child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: showSleep.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return _buildsleepListItem(context, index);
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 15.0, right: 15, top: 0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                height: 1,
                                width: MediaQuery.of(context).size.width / 3,
                                decoration: BoxDecoration(
                                  boxShadow: [
                                    BoxShadow(
                                        blurRadius: 1.0,
                                        color:
                                            Color.fromARGB(255, 172, 164, 164)),
                                  ],
                                ),
                              ),
                              ClipRRect(
                                borderRadius: BorderRadius.circular(0),
                                child: Container(
                                    child: Image.asset(
                                  'assets/images/ic_meditations.png',
                                  fit: BoxFit.cover,
                                  height: 40,
                                )),
                              ),
                              Container(
                                height: 1,
                                width: MediaQuery.of(context).size.width / 3,
                                decoration: BoxDecoration(
                                  boxShadow: [
                                    BoxShadow(
                                        blurRadius: 1.0,
                                        color:
                                            Color.fromARGB(255, 172, 164, 164)),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Column(
                          children: [
                            SizedBox(
                                height: MediaQuery.of(context).size.height / 9,
                                child: MediaQuery.removePadding(
                                  removeTop: true,
                                  context: context,
                                  child: ListView.builder(
                                      scrollDirection: Axis.horizontal,
                                      itemCount: showMeditation.length,
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        return _buildmeditationListItem(
                                            context, index);
                                      }),
                                )),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 15.0, right: 15, top: 0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                height: 1,
                                width: MediaQuery.of(context).size.width / 3,
                                decoration: BoxDecoration(
                                  boxShadow: [
                                    BoxShadow(
                                        blurRadius: 1.0,
                                        color:
                                            Color.fromARGB(255, 172, 164, 164)),
                                  ],
                                ),
                              ),
                              ClipRRect(
                                borderRadius: BorderRadius.circular(0),
                                child: Container(
                                    child: Image.asset(
                                  'assets/images/ic_lotus.png',
                                  fit: BoxFit.cover,
                                  height: 40,
                                )),
                              ),
                              Container(
                                height: 1,
                                width: MediaQuery.of(context).size.width / 3,
                                decoration: BoxDecoration(
                                  boxShadow: [
                                    BoxShadow(
                                        blurRadius: 1.0,
                                        color:
                                            Color.fromARGB(255, 172, 164, 164)),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Column(
                          children: [
                            SizedBox(
                                height: MediaQuery.of(context).size.height / 9,
                                child: MediaQuery.removePadding(
                                  removeTop: true,
                                  context: context,
                                  child: ListView.builder(
                                      scrollDirection: Axis.horizontal,
                                      itemCount: showSpa.length,
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        return _buildspaListItem(
                                            context, index);
                                      }),
                                )),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                if (_bannerAd != null)
                  SafeArea(
                    child: SizedBox(
                      width: _bannerAd!.size.width.toDouble(),
                      height: _bannerAd!.size.height.toDouble(),
                      child: AdWidget(ad: _bannerAd!),
                    ),
                  )
              ],
            ),
          )),
    );
  }

  @override
  void initState() {
    super.initState();
    loadAd();
    audio();
    PerfectVolumeControl.hideUI = true;
    Future.delayed(Duration.zero, () async {
      currentvol = await PerfectVolumeControl.getVolume();
      setState(() {});
    });

    PerfectVolumeControl.stream.listen((volume) {
      setState(() {
        currentvol = volume;
      });
    });
  }

  void menuAction(String value) {
    switch (value) {
      case 'Contact us':
        print('Hello');
        break;
    }
  }

  void setVolume(double value) async {
    await assetsAudioplayer1.setVolume(value);
  }

  Widget _buildmeditationListItem(BuildContext context, int index) {
    var meditation = showMeditation[index];
    return Padding(
      padding: EdgeInsets.only(top: 0.0, left: 15),
      child: Column(
        children: [
          GestureDetector(
            onTap: () {
              if (meditation.id == selectedID) {
                selectedID = '';
                selectedSong = '';
                selectedSongImage = '';
                selectedSongName = '';
                if (timer != null) {
                  timer!.cancel();
                }

                playMusic();
                setState(() {});
              } else {
                selectedID = meditation.id;
                selectedSong = meditation.music;
                selectedSongImage = meditation.image;
                selectedSongName = meditation.title;
                setState(() {});
                playMusic();
              }
            },
            child: Container(
              height: 70,
              width: 70,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  color: selectedID == meditation.id
                      ? Color.fromARGB(255, 247, 239, 246)
                      : Color.fromARGB(255, 247, 239, 246).withOpacity(0.2),
                  borderRadius: BorderRadius.all(Radius.circular(100))),
              child: selectedID == meditation.id
                  ? Image.asset(meditation.image,
                      fit: BoxFit.cover,
                      width: 40,
                      height: 40,
                      color: Colors.blue)
                  : Image.asset(
                      meditation.image,
                      fit: BoxFit.cover,
                      width: 40,
                      height: 40,
                      color: Colors.white,
                    ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }

  // newStartmusic = startmusic;
  //               assetsAudioPlayer.open(
  //                   Audio(
  //                     '${meditation.meditationsong}',
  //                     metas: Metas(
  //                         title: meditation.title,
  //                         album: "Meditation",
  //                         image: MetasImage.asset("${meditation.imagePath}")),
  //                   ),
  //                   loopMode: LoopMode.single,
  //                   showNotification: false,
  //                   notificationSettings: NotificationSettings(
  //                     nextEnabled: false,
  //                     prevEnabled: false,
  //                   ));
  //               getString('timingaudio');
  //               const onsec = Duration(seconds: 1);
  //               Timer timer = Timer.periodic(onsec, (timer) {
  //                 //timer.cancel();
  //                 if (newStartmusic == 0) {
  //                   setState(() {
  //                     timer.cancel();
  //                     wait = false;
  //                     assetsAudioPlayer.stop();
  //                     timerindex = null;
  //                     tappedIndex1 = null;
  //                   });
  //                 } else {
  //                   setState(() {
  //                     newStartmusic--;
  //                     //tappedIndex1 = index;
  //                   });
  //                   assetsAudioPlayer.play();
  //                 }
  //               });
  Widget _buildsleepListItem(BuildContext context, int index) {
    var sleep = showSleep[index];
    return Padding(
      padding: EdgeInsets.only(top: 0.0, left: 15),
      child: Column(
        children: [
          GestureDetector(
            onTap: () {
              if (sleep.id == selectedID) {
                selectedID = '';
                selectedSong = '';
                selectedSongImage = '';
                selectedSongName = '';
                if (timer != null) {
                  timer!.cancel();
                }
                playMusic();
                setState(() {});
              } else {
                selectedID = sleep.id;
                selectedSong = sleep.music;
                selectedSongImage = sleep.image;
                selectedSongName = sleep.title;
                setState(() {});
                playMusic();
              }
              //  const onsec = Duration(seconds: 1);
              //  Timer timer = Timer.periodic(onsec, (timer) {
              //     //timer.cancel();
              //     if (newStartmusic == 0) {
              //       setState(() {
              //         timer.cancel();
              //         wait = false;
              //         assetsAudioPlayer.stop();
              //         timerindex = null;
              //         tappedIndex1 = null;
              //       });
              //     } else {
              //       setState(() {
              //         newStartmusic--;
              //         //tappedIndex1 = index;
              //       });
              //      playMusic();
              //     }
              //   });
            },
            child: Container(
              height: 70,
              width: 70,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: selectedID == sleep.id
                    ? Color.fromARGB(255, 247, 239, 246)
                    : Color.fromARGB(255, 247, 239, 246).withOpacity(0.2),
                borderRadius: BorderRadius.all(Radius.circular(100)),
              ),
              child: selectedID == sleep.id
                  ? Image.asset(
                      sleep.image,
                      fit: BoxFit.cover,
                      width: 40,
                      height: 40,
                      color: Colors.blue,
                    )
                  : Image.asset(
                      sleep.image,
                      fit: BoxFit.cover,
                      width: 40,
                      height: 40,
                    ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }

  Widget _buildspaListItem(BuildContext context, int index) {
    var spa = showSpa[index];
    return Padding(
      padding: EdgeInsets.only(top: 0.0, left: 15),
      child: Column(
        children: [
          GestureDetector(
            onTap: () {
              if (spa.id == selectedID) {
                selectedID = '';
                selectedSong = '';
                selectedSongImage = '';
                selectedSongName = '';
                if (timer != null) {
                  timer!.cancel();
                }
                playMusic();
                setState(() {});
              } else {
                selectedID = spa.id;
                selectedSong = spa.music;
                selectedSongImage = spa.image;
                selectedSongName = spa.title;
                setState(() {});
                playMusic();
              }
            },
            child: Container(
              height: 70,
              width: 70,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  color: selectedID == spa.id
                      ? Color.fromARGB(255, 247, 239, 246)
                      : Color.fromARGB(255, 247, 239, 246).withOpacity(0.2),
                  borderRadius: BorderRadius.all(Radius.circular(100))),
              child: selectedID == spa.id
                  ? Image.asset(spa.image,
                      fit: BoxFit.cover,
                      width: 50,
                      height: 50,
                      color: Colors.blue)
                  : Image.asset(
                      spa.image,
                      fit: BoxFit.cover,
                      width: 50,
                      height: 50,
                      color: Colors.white,
                    ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }

  Widget _buildtimerset(BuildContext context, int index, StateSetter setter) {
    var timerset = showTImer[index];
    return GestureDetector(
      onTap: () {
        setter(() {
          if (selectedTimerId == timerset.id) {
            selectedTimerId = '';
            selectedTimerValue = '';
          } else {
            selectedTimerId = timerset.id;
            selectedTimerValue = timerset.value;
          }
          playMusic();
        });
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          width: 80,
          alignment: Alignment.center,
          decoration: BoxDecoration(
              color: selectedTimerId == timerset.id
                  ? Color(0xffFFFFFF)
                  : Color(0xff000000),
              border: Border.all(color: Colors.black, width: 1),
              borderRadius: BorderRadius.all(Radius.circular(100))),
          child: Padding(
              padding: const EdgeInsets.only(right: 18.0, left: 18),
              child: Text(
                timerset.title.toString(),
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: selectedTimerId == timerset.id
                        ? Colors.blue
                        : Colors.white),
              )),
        ),
      ),
    );
  }

  void _openAppReview() async {
    final InAppReview inAppReview = InAppReview.instance;

    if (await inAppReview.isAvailable()) {
      /// NOTE: use this SPARINGLY -> restricted by quota
      /// triggers the In-App Review prompt
      //inAppReview.requestReview();

      /// NOTE: NOT restricted by quota
      ///
      /// opens:
      /// - Google Play Store on Android,
      /// - App Store with a review screen on IOS & MacOS
      /// - Microsoft Store on Windows.
      ///
      /// Use this if you want to permanently provide a button or other
      /// call-to-action to let users leave a review
      ///
      /// appStoreId is only required on IOS and MacOS and can be found in
      /// App Store Connect under General > App Information > Apple ID.
      ///   exp: https://apps.apple.com/app/app-name/id1111111111
      ///     -> id: id1111111111
      ///
      /// microsoftStoreId is only required on Windows:
      ///   exp: https://www.microsoft.com/store/apps/<microsoftStoreId>
      inAppReview.openStoreListing(
        appStoreId: '...',
        microsoftStoreId: '...',
      );
    }
  }
}
