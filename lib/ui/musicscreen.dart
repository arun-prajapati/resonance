import 'dart:async';
import 'dart:io';

import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:perfect_volume_control/perfect_volume_control.dart';
import 'package:resonance/volume/colors.dart';
import 'package:resonance/volume/pref.dart';
import 'package:share_plus/share_plus.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';

// import 'package:syncfusion_flutter_gauges/gauges.dart';
final assetsAudioPlayer = AssetsAudioPlayer();
bool isstart = false;
Timer? timer;

List<meditation> meditationList = [
  meditation('assets/images/iconsforest.png', 'Woods morning',
      'assets/audios/woodsmorning.wav'
      // 'https://drive.google.com/uc?export=view&id=1_R5atbP8ooy2iI6GJ1F4rly1lULVFUDu',
      ),
  meditation('assets/images/iconsheavyrain.png', 'Rain Tropical',
      'assets/audios/raintropical.wav'
      //'https://drive.google.com/uc?export=view&id=1j61OWDTC0tAJPtFgVvh0vbJTCx86VysR',
      ),
  meditation('assets/images/ic_thunderstorm.png', 'Rain Thunderstrom',
      'assets/audios/rainthunderstorm.wav'
      //'https://drive.google.com/uc?export=view&id=19fAjqD5XkyoxbmV2CJGevnYi_hCSd05a',
      ),
  meditation(
      'assets/images/ic_softrain.png', 'Rain soft', 'assets/audios/rainsoft.wav'
      // 'https://drive.google.com/uc?export=view&id=1bA2kVWY0cb6vrWKLoJsqJ4KaUl1b7a_q',
      ),
  meditation('assets/images/ic_cricket.png', 'Rain Cricket',
      'assets/audios/raincrickets.wav'
      //'https://drive.google.com/uc?export=view&id=1uSSq_6GOPnT06f-5aB0OujOVEQEr8wWa',
      ),
  meditation('assets/images/ic_bird.png', 'Forest Birds',
      'assets/audios/forestbirds.wav'
      //'https://drive.google.com/uc?export=view&id=1-bFkOKbBeNM3QeQKtA_E7WZEFBpYfZbi',
      ),
];

List<sleep> sleepList = [
  sleep('assets/images/iconairconditioner.png', 'Air Conditioner',
      'assets/audios/aircond.wav'
      //'https://drive.google.com/uc?export=view&id=16Cmc5I5g9WbpdZkLU6PsnuIp1KDL8jgO',
      ),
  sleep('assets/images/iconvacuumcleaner.png', 'Vaccum cleaner',
      'assets/audios/vaccumcleaner.wav'
      //'https://drive.google.com/uc?export=view&id=17KY0iG_wK-hZviqCJM18MBoJ02i8CcaD',
      ),
  sleep('assets/images/whitewave.png', 'White Noise',
      'assets/audios/whitenoise.wav'
      //'https://drive.google.com/uc?export=view&id=16aBslJFQsZoOP85HVERtU5t9j_UWI0IL',
      ),
  sleep('assets/images/brownwave.png', 'Brown Noise',
      'assets/audios/brownnoise.wav'
      //'https://drive.google.com/uc?export=view&id=1uX9ekTZyBrpBDbUx4N00d9uj2YgytACF',
      ),
  sleep(
      'assets/images/pinkwave.png', 'Pink Noise', 'assets/audios/pinknoise.wav'
      //'https://drive.google.com/uc?export=view&id=1cHxCk1U7TDGKAr1LoJIogeY9K0cmNWSo',
      ),
  sleep('assets/images/iconhairdryer.png', 'Hair Dryer',
      'assets/audios/hairdrier.wav'
      // 'https://drive.google.com/uc?export=view&id=1S3eeovKvyYs48sSa0oNK0p_It3hXvzEk',
      ),
  sleep('assets/images/iconheartbeats.png', 'Heartbeat',
      'assets/audios/heartbeat.wav'
      // 'https://drive.google.com/uc?export=view&id=1Cq6lggOFt6bdO4GDxGTo7QtJ_8kAgivT',
      ),
];
List<spa> spaList = [
  spa('assets/images/ic_park.png', 'City park', 'assets/audios/citypark.wav'
      //'https://drive.google.com/uc?export=view&id=15bLmonBjL509V5ktgqIL2vidtq6OIC7j',
      ),
  spa('assets/images/iconskyscraper.png', 'City skyscraper',
      'assets/audios/citysky.wav'
      //'https://drive.google.com/uc?export=view&id=1pMcTGXBtPH4V1QkkGWEk6_TsxQ4syYdx',
      ),
  spa('assets/images/ic_relax.png', 'Morningloop',
      'assets/audios/morningloop.wav'
      //'https://drive.google.com/uc?export=view&id=12Mo-RPrZle1AHfxnLxOOFVH0kCRnEwnW',
      ),
  spa('assets/images/iconshower.png', 'Showerloop',
      'assets/audios/showerloop.wav'
      // 'https://drive.google.com/uc?export=view&id=1E-oV2bzxY94PdN9j8A-sDrG29S9b-kz9',
      ),
  spa('assets/images/iconfan.png', 'Fan', 'assets/audios/largefan.wav'
      //'https://drive.google.com/uc?export=view&id=1b7FiMWjSpHIG5YF4Tp_80jt-PHoG4zX1',
      ),
  spa('assets/images/iconac.png', 'Acfan', 'assets/audios/airfactory.wav'
      //'https://drive.google.com/uc?export=view&id=1Lo8_9T85QXvouFU-Nrl9ErT6_DnRCyLT',
      ),
];
int? tappedIndex;
int? tappedIndex1;

int? tappedIndex2;

int? timerindex;

List<timerset> timersetlist = [
  timerset(
    3600 * 3600,
    // '3600*3600',
    '∞',
  ),
  timerset(
    //'1800',
    // 1800,
    60,
    '30m',
  ),
  timerset(
    //'3600*1',
    3600 * 1,
    '1h',
  ),
  timerset(
    //'3600+1800',
    3600 + 1800,
    '1:30h',
  ),
  timerset(
    //'3600*3',
    3600 * 3,
    '3h',
  ),
  timerset(
    //'3600*4+1800',
    3600 * 4 + 1800,
    '4:30h',
  ),
  timerset(
    //'3600*6',
    3600 * 6,
    '6h',
  ),
  timerset(
    //'3600*7+1800',
    3600 * 7 + 1800,
    '7:30h',
  ),
  timerset(
    //'3600*9',
    3600 * 9,
    '9h',
  ),
];

class meditation {
  final String imagePath;

  final String title;
  final String meditationsong;

  meditation(this.imagePath, this.title, this.meditationsong);
}

class musicscreen extends StatefulWidget {
  const musicscreen({super.key});

  @override
  State<musicscreen> createState() => _musicscreenState();
}

class sleep {
  final String imagePath;

  final String title;

  final String songname;

  sleep(
    this.imagePath,
    this.title,
    this.songname,
  );
}

class spa {
  final String imagePath;

  final String title;
  final String spasong;

  spa(this.imagePath, this.title, this.spasong);
}

class timerset {
  final int timehour;

  final String title;
  // final String meditationsong;

  timerset(
    this.timehour,
    this.title,
  );
}

class _musicscreenState extends State<musicscreen> {
  int volume = 0;
  bool liked = true;
  bool click = false;
  bool isplaying = false;
  bool isstart = false;
  bool isbgmusicstart = false;
  double currentvol = 0.0;
  int startmusic = 0;
  int startmusic1hour = 3600;
  int newStartmusic = 0;
  double currentVolume = 0.0; // Example initial value

  bool wait = false;
  bool connection = false;
  final assetsAudioPlayer = AssetsAudioPlayer();
  final assetsAudioplayer1 = AssetsAudioPlayer();
  final assetsAudioplayer2 = AssetsAudioPlayer();

  BannerAd? _bannerAd;
  bool _isLoaded = false;

  // TODO: replace this test ad unit with your own ad unit.
  final adUnitId = Platform.isAndroid
      ? 'ca-app-pub-3940256099942544/6300978111'
      : 'ca-app-pub-3940256099942544/2934735716';

  void loadAd() {
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

  //audio function
  audio() async {
    try {
      await assetsAudioplayer1.open(
        Audio("assets/audios/brain.wav",
            //"https://drive.google.com/uc?export=view&id=17m420i6btISeixZgxn0smbJBp6Wn8IAe",
            metas: Metas(
                //title: "Background",
                title: "Background",
                image: MetasImage.asset('assets/images/citysky.png'))),
        //showNotification: true,
        //headPhoneStrategy: HeadPhoneStrategy.pauseOnUnplug,
        autoStart: false,
      );
      LoopMode.single;
      // assetsAudioPlayer.setVolume(0.0);
      // assetsAudioPlayer.setVolume(volume.toDouble()/100);
      // print(volume.toDouble()/100);
      // print('hi');

      //volume = currentvol.toInt();
      volume = currentVolume.toInt();
    } catch (t) {
      //mp3 unreachable
    }
  }

  @override
  Widget build(BuildContext context) {
    // ignore: deprecated_member_use
    // SystemChrome.setSystemUIOverlayStyle(style)
    // SystemChrome.setEnabledSystemUIOverlays([]);
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);

    return Scaffold(
        // backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 0.0,
          //toolbarHeight: 60,
          backgroundColor: Color.fromARGB(255, 5, 4, 36),
          centerTitle: true,
          leading: Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Image.asset(
              'assets/images/resonancewhite.png',
              //fit: BoxFit.cover,
              height: 20,
              width: 20,
            ),
          ),
          actions: [
            IconButton(
              onPressed: () {
                click = !click;
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
                  child: Column(
                    children: [
                      SizedBox(
                        height: 15,
                      ),
                      Text(
                        'Contact us',
                        style: TextStyle(
                            color: Colors.black, fontWeight: FontWeight.w600),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Container(
                        height: 1,
                        color: Colors.black,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        'Terms Of Services',
                        style: TextStyle(
                            color: Colors.black, fontWeight: FontWeight.w600),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Container(
                        height: 1,
                        color: Colors.black,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        'Privacy Policy',
                        style: TextStyle(
                            color: Colors.black, fontWeight: FontWeight.w600),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Container(
                        height: 1,
                        color: Colors.black,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        'Copyright',
                        style: TextStyle(
                            color: Colors.black, fontWeight: FontWeight.w600),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Container(
                        height: 1,
                        color: Colors.black,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
                ),
                PopupMenuItem(
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
                child: Column(
                  children: [
                    Column(
                      children: [
                        Container(
                          height: MediaQuery.of(context).size.height / 3,
                          decoration: BoxDecoration(
                              gradient: LinearGradient(
                            colors: [
                              Color.fromARGB(255, 43, 43, 71).withOpacity(0.8),
                              Color.fromARGB(255, 43, 43, 71).withOpacity(0.8),
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
                                        MediaQuery.of(context).size.height / 4,
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
                                    // Call the function to set the volume using the new value
                                    setVolume(value);
                                  },
                                  onChangeStart: (double startValue) {
                                    // callback providing a starting value (when a pan gesture starts)
                                  },
                                  onChangeEnd: (double endValue) {
                                    print('end');

                                    // callback providing an ending value (when a pan gesture ends)
                                  },
                                  innerWidget: (double value) {
                                    //This the widget that will show current value
                                    return Center(
                                      child: GestureDetector(
                                        onTap: () {
                                          isbgmusicstart = !isbgmusicstart;
                                          setState(() {});
                                          if (isbgmusicstart) {
                                            print(assetsAudioPlayer
                                                .getCurrentAudioTitle
                                                .toString());

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
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(100))),
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
                                        isplaying = !isplaying;
                                        liked = !liked;
                                        wait = !wait;
                                        timerindex = null;
                                        // tappedIndex = null;
                                        setState(() {
                                          isbgmusicstart = false;
                                          wait = false;
                                          tappedIndex = null;
                                          tappedIndex1 = null;
                                          tappedIndex2 = null;
                                          startmusic = 00;
                                          startmusic1hour = 00;
                                          newStartmusic = 00;
                                          assetsAudioPlayer.stop();
                                          assetsAudioplayer1.stop();
                                          assetsAudioplayer2.stop();
                                          // assetsAudioPlayer.dispose();
                                        });
                                      },
                                      child: Container(
                                          child: Icon(
                                        Icons.stop_circle_outlined,
                                        size: 50,
                                        color: Colors.white.withOpacity(0.8),
                                      )),
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        liked = !liked;
                                        // setState(() {});
                                        showModalBottomSheet(
                                            backgroundColor: Colors.transparent,
                                            context: context,
                                            builder: (context) {
                                              return StatefulBuilder(builder:
                                                  (context,
                                                      StateSetter filterState) {
                                                return Container(
                                                  //height: 100,
                                                  height: 150,
                                                  decoration: BoxDecoration(
                                                      color: Color(0xffFFFFFF),
                                                      borderRadius:
                                                          // BorderRadius.circular(10),
                                                          BorderRadius.only(
                                                              topLeft: Radius
                                                                  .circular(25),
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
                                                                  fontSize: 20,
                                                                  fontFamily:
                                                                      'BeVietnam',
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w800),
                                                            ),
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .all(0.0),
                                                              child: InkWell(
                                                                onTap: () {
                                                                  // liked =
                                                                  //     !liked;
                                                                  //setState(() {});
                                                                  Navigator.pop(
                                                                      context);
                                                                },
                                                                child:
                                                                    Image.asset(
                                                                  'assets/images/close.png',
                                                                  fit: BoxFit
                                                                      .cover,
                                                                  height: 35,
                                                                  //color: Colors.black,
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        height: 50,
                                                        child: ListView.builder(
                                                            // padding: EdgeInsets.only(left: 20.0, right: 20),
                                                            scrollDirection:
                                                                Axis.horizontal,
                                                            itemCount:
                                                                timersetlist
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
                                        color:
                                            wait ? Colors.blue : Colors.white,
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
                                  'assets/images/ic_sleeping.png',
                                  fit: BoxFit.cover,
                                  height: 40,
                                  color: Colors.white,
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
                              // padding: EdgeInsets.only(left: 20.0, right: 20),
                              scrollDirection: Axis.horizontal,
                              itemCount: sleepList.length,
                              itemBuilder: (BuildContext context, int index) {
                                // CardModel card = cards[index];
                                return _buildsleepListItem(context, index);
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 15.0, right: 15, top: 0),
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
                                    color: Color.fromARGB(255, 172, 164, 164)),
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
                              //width: 55,
                            )),
                          ),
                          Container(
                            height: 1,
                            width: MediaQuery.of(context).size.width / 3,
                            decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                    blurRadius: 1.0,
                                    color: Color.fromARGB(255, 172, 164, 164)),
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
                                  // padding: EdgeInsets.only(left: 20.0, right: 20),
                                  scrollDirection: Axis.horizontal,
                                  itemCount: meditationList.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    // CardModel card = cards[index];
                                    return _buildmeditationListItem(
                                        context, index);
                                  }),
                            )),
                      ],
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 15.0, right: 15, top: 0),
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
                                    color: Color.fromARGB(255, 172, 164, 164)),
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
                              //width: 70,
                            )),
                          ),
                          Container(
                            height: 1,
                            width: MediaQuery.of(context).size.width / 3,
                            decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                    blurRadius: 1.0,
                                    color: Color.fromARGB(255, 172, 164, 164)),
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
                                  // padding: EdgeInsets.only(left: 20.0, right: 20),
                                  scrollDirection: Axis.horizontal,
                                  itemCount: spaList.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    // CardModel card = cards[index];
                                    return _buildspaListItem(context, index);
                                  }),
                            )),
                      ],
                    ),
                  ],
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
        ));
  }

  @override
  void initState() {
    super.initState();
    loadAd();
    audio();
    timeraudio();
    PerfectVolumeControl.hideUI =
        true; //set if system UI is hided or not on volume up/down
    Future.delayed(Duration.zero, () async {
      currentvol = await PerfectVolumeControl.getVolume();
      setState(() {
        //refresh UI
      });
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

  startTimer() {
    const onsec = Duration(seconds: 1);
    Timer timer = Timer.periodic(onsec, (timer) {
      if (startmusic == 0) {
        setState(() {
          timer.cancel();
          wait = false;
          assetsAudioplayer2.stop();
        });
      } else {
        setState(() {
          startmusic--;
        });
        assetsAudioplayer2.play();
      }
    });
  }

  startTimer1() {
    const onsec1 = Duration(seconds: 1);
    Timer timer1 = Timer.periodic(onsec1, (timer1) {
      if (startmusic1hour == 0) {
        setState(() {
          timer1.cancel();
          wait = false;
          assetsAudioPlayer.stop();
        });
      } else {
        setState(() {
          startmusic1hour--;
        });
        assetsAudioPlayer.play();
      }
    });
  }

  startTimers(String songName, String title, String album, String imagePath) {
    const onSec = Duration(seconds: 1);
    Timer timer = Timer.periodic(onSec, (timer) {
      if (startmusic == 0) {
        setState(() {
          timer.cancel();
          wait = false;
          timerindex = null;
          assetsAudioPlayer.stop();
        });
      } else {
        setState(() {
          startmusic--;
        });
        // Open and play the audio using assetsAudioPlayer
        assetsAudioPlayer.open(
          Audio(
            songName,
            metas: Metas(
              title: title,
              album: album,
              image: MetasImage.asset(imagePath),
            ),
          ),
          loopMode: LoopMode.single,
          showNotification: true,
          notificationSettings: NotificationSettings(
            nextEnabled: false,
            prevEnabled: false,
          ),
        );
      }
    });
  }

  timeraudio() async {
    var updatesong = '${getString('timersaudio')}';
    setState(() {
      updatesong;
    });
    try {
      await assetsAudioplayer2.open(
        Audio('$updatesong'),
        autoStart: false,
        showNotification: true,
      );
      LoopMode.single;
      volume = currentVolume.toInt();
    } catch (t) {
      //mp3 unreachable
    }
  }

  Widget _buildsleepListItem(BuildContext context, int index) {
    var sleep = sleepList[index];
    return Padding(
      padding: EdgeInsets.only(top: 0.0, left: 15),
      child: Column(
        children: [
          GestureDetector(
            onTap: () {
              isstart = !isstart;
              setState(() {
                tappedIndex = index;
                tappedIndex1 = null;
                tappedIndex2 = null;
                isstart;
              });

              if (isstart && timerindex == null) {
                // Stop any currently playing music
                // assetsAudioPlayer.stop();
                assetsAudioPlayer.open(
                    Audio('${sleep.songname}',
                        //cached: true,
                        metas: Metas(
                            title: sleep.title,
                            album: "Sleep",
                            image: MetasImage.asset("${sleep.imagePath}"))),
                    loopMode: LoopMode.single,
                    showNotification: true,
                    notificationSettings: NotificationSettings(
                      nextEnabled: false,
                      prevEnabled: false,
                    ));
              } else {
                // assetsAudioPlayer.stop();
                newStartmusic = startmusic;
                assetsAudioPlayer.open(
                    Audio('${sleep.songname}',
                        //cached: true,
                        metas: Metas(
                            title: sleep.title,
                            album: "Sleep",
                            image: MetasImage.asset("${sleep.imagePath}"))),
                    loopMode: LoopMode.single,
                    showNotification: false,
                    notificationSettings: NotificationSettings(
                      nextEnabled: false,
                      prevEnabled: false,
                    ));
                getString('timingaudio');
                const onsec = Duration(seconds: 1);
                Timer timer = Timer.periodic(onsec, (timer) {
                  //timer.cancel();
                  if (newStartmusic == 0) {
                    setState(() {
                      timer.cancel();
                      wait = false;
                      assetsAudioPlayer.stop();
                      timerindex = null;
                      tappedIndex = null;
                    });
                  } else {
                    setState(() {
                      newStartmusic--;
                      // tappedIndex = index;
                    });
                    assetsAudioPlayer.play();
                  }
                });

                tappedIndex = null;
                print('stop');
              }
            },
            child: Container(
              height: 70,
              width: 70,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  color: tappedIndex == index
                      ? Color.fromARGB(255, 247, 239, 246)
                      : Color.fromARGB(255, 247, 239, 246).withOpacity(0.2),
                  //Color.fromARGB(255, 29, 22, 46),
                  borderRadius: BorderRadius.all(Radius.circular(100))),
              // decoration:
              //     BoxDecoration(shape: BoxShape.circle, color: Colors.white),
              child: tappedIndex == index
                  ? Image.asset(sleep.imagePath,
                      fit: BoxFit.cover,
                      width: 40,
                      height: 40,
                      color: Colors.blue)
                  : Image.asset(
                      sleep.imagePath,
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

  Widget _buildmeditationListItem(BuildContext context, int index) {
    var meditation = meditationList[index];
    return Padding(
      padding: EdgeInsets.only(top: 0.0, left: 15),
      child: Column(
        children: [
          GestureDetector(
            onTap: () {
              isstart = !isstart;
              setState(() {
                tappedIndex1 = index;
                tappedIndex = null;
                tappedIndex2 = null;
                isstart;
              });
              if (isstart && timerindex == null) {
                // Stop any currently playing music
                // assetsAudioPlayer.stop();
                assetsAudioPlayer.open(
                    Audio(
                      '${meditation.meditationsong}',
                      metas: Metas(
                          title: meditation.title,
                          album: "Meditation",
                          image: MetasImage.asset("${meditation.imagePath}")),
                    ),
                    loopMode: LoopMode.single,
                    showNotification: true,
                    notificationSettings: NotificationSettings(
                      nextEnabled: false,
                      prevEnabled: false,
                    ));
              } else {
                //assetsAudioPlayer.stop();
                newStartmusic = startmusic;
                assetsAudioPlayer.open(
                    Audio(
                      '${meditation.meditationsong}',
                      metas: Metas(
                          title: meditation.title,
                          album: "Meditation",
                          image: MetasImage.asset("${meditation.imagePath}")),
                    ),
                    loopMode: LoopMode.single,
                    showNotification: false,
                    notificationSettings: NotificationSettings(
                      nextEnabled: false,
                      prevEnabled: false,
                    ));
                getString('timingaudio');
                const onsec = Duration(seconds: 1);
                Timer timer = Timer.periodic(onsec, (timer) {
                  //timer.cancel();
                  if (newStartmusic == 0) {
                    setState(() {
                      timer.cancel();
                      wait = false;
                      assetsAudioPlayer.stop();
                      timerindex = null;
                      tappedIndex1 = null;
                    });
                  } else {
                    setState(() {
                      newStartmusic--;
                      //tappedIndex1 = index;
                    });
                    assetsAudioPlayer.play();
                  }
                });

                tappedIndex1 = null;
                print('stop');
              }
              // setState(() {});
            },
            child: Container(
              height: 70,
              width: 70,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  color: tappedIndex1 == index
                      ? Color.fromARGB(255, 247, 239, 246)
                      : Color.fromARGB(255, 247, 239, 246).withOpacity(0.2),
                  //Color.fromARGB(255, 29, 22, 46),
                  borderRadius: BorderRadius.all(Radius.circular(100))),
              // decoration: BoxDecoration(shape: BoxShape.circle),
              child: tappedIndex1 == index
                  ? Image.asset(meditation.imagePath,
                      fit: BoxFit.cover,
                      width: 40,
                      height: 40,
                      color: Colors.blue)
                  : Image.asset(
                      meditation.imagePath,
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

  Widget _buildspaListItem(BuildContext context, int index) {
    var spa = spaList[index];
    return Padding(
      padding: EdgeInsets.only(top: 0.0, left: 15),
      child: Column(
        children: [
          GestureDetector(
            onTap: () {
              isstart = !isstart;
              setState(() {
                tappedIndex2 = index;
                tappedIndex = null;
                tappedIndex1 = null;
                isstart;
                // assetsAudioPlayer.stop;
              });
              if (isstart && timerindex == null) {
                // Stop any currently playing music
                // assetsAudioPlayer.stop();
                assetsAudioPlayer.open(
                    Audio(
                      '${spa.spasong}',
                      // cached: true,
                      metas: Metas(
                          title: spa.title,
                          album: "Spa",
                          image: MetasImage.asset("${spa.imagePath}")),
                    ),
                    loopMode: LoopMode.single,
                    showNotification: true,
                    notificationSettings: NotificationSettings(
                      nextEnabled: false,
                      prevEnabled: false,
                    ));
              } else {
                //assetsAudioPlayer.stop();
                newStartmusic = startmusic;
                assetsAudioPlayer.open(
                    Audio(
                      '${spa.spasong}',
                      // cached: true,
                      metas: Metas(
                          title: spa.title,
                          album: "Spa",
                          image: MetasImage.asset("${spa.imagePath}")),
                    ),
                    loopMode: LoopMode.single,
                    showNotification: false,
                    notificationSettings: NotificationSettings(
                      nextEnabled: false,
                      prevEnabled: false,
                    ));
                getString('timingaudio');

                const onsec = Duration(seconds: 1);
                // Timer timer =
                Timer.periodic(onsec, (timer) {
                  //timer.cancel();
                  if (newStartmusic == 0) {
                    setState(() {
                      timer.cancel();
                      wait = false;
                      assetsAudioPlayer.stop();
                      timerindex = null;
                      tappedIndex2 = null;
                    });
                  } else {
                    setState(() {
                      newStartmusic--;
                      // tappedIndex2 = index;
                    });
                    assetsAudioPlayer.play();
                  }
                });

                tappedIndex2 = null;
                print('stop');
              }
            },
            child: Container(
              height: 70,
              width: 70,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  color: tappedIndex2 == index
                      ? Color.fromARGB(255, 247, 239, 246)
                      : Color.fromARGB(255, 247, 239, 246).withOpacity(0.2),
                  //Color.fromARGB(255, 29, 22, 46),
                  borderRadius: BorderRadius.all(Radius.circular(100))),
              child: tappedIndex2 == index
                  ? Image.asset(spa.imagePath,
                      fit: BoxFit.cover,
                      width: 50,
                      height: 50,
                      color: Colors.blue)
                  : Image.asset(
                      spa.imagePath,
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
    var timerset = timersetlist[index];

    return GestureDetector(
      onTap: () {
        wait = !wait;
        // liked = !liked;
        setter(() {
          timerindex = index;
          // liked = !liked;
        });
        if (wait == false) {
          startmusic = 00;
          timerindex = null;
          print('Stop');
        } else {
          //startmusic = timerset.timehour.codeUnitAt(index);
          startmusic = timerset.timehour;
          setString('timingaudio', '$startmusic');
          //  startTimer();
          print('Start');
        }
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          // height: 50,
          width: 80,
          alignment: Alignment.center,
          decoration: BoxDecoration(
              color: timerindex == index
                  ? Color(0xffFFFFFF)
                  // Color.fromARGB(255, 29, 22, 46)
                  : Color(0xff000000),
              border: Border.all(color: Colors.black, width: 1),
              borderRadius: BorderRadius.all(Radius.circular(100))),
          child: Padding(
              padding: const EdgeInsets.only(right: 18.0, left: 18),
              child: Text(
                timerset.title.toString(),
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: timerindex == index ? Colors.blue : Colors.white),
              )),
        ),
      ),
    );
  }
}
