import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:nexus/models/PostModel.dart';
import 'package:nexus/models/userModel.dart';
import 'package:nexus/providers/manager.dart';
import 'package:nexus/services/AuthService.dart';
import 'package:nexus/utils/devicesize.dart';
import 'package:provider/provider.dart';

class userProfile extends StatefulWidget {
  final String? uid;
  userProfile({this.uid});
  @override
  State<userProfile> createState() => _userProfileState();
}

class _userProfileState extends State<userProfile> {
  bool? loadScreen;
  User? currentUser;
  bool loadAfterFollowProcess = false;
  bool init = true;
  @override
  void initState() {
    loadScreen = true;
    super.initState();
    currentUser = FirebaseAuth.instance.currentUser;
  }

  @override
  void didChangeDependencies()async {
    if(init){
      Provider.of<usersProvider>(context).setPostsForThisProfile(widget.uid.toString()).then((value){
        loadScreen=false;
        init = false;
      });
    }

    super.didChangeDependencies();
  }



  @override
  Widget build(BuildContext context) {

    NexusUser? thisProfile = Provider.of<usersProvider>(context).fetchAllUsers[widget.uid.toString()];
    Map<String,PostModel>? posts = Provider.of<usersProvider>(context).fetchThisUserPosts;
    return Scaffold(
      body: SafeArea(
        child: Container(
          height: displayHeight(context),
          width: displayWidth(context),
          child: (loadScreen!)
              ? const Center(
                  child: CircularProgressIndicator(
                    color: Colors.orange,
                    backgroundColor: Colors.blue,
                  ),
                )
              : Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      height: displayHeight(context) * 0.295,
                      width: displayWidth(context),
                      //color: Colors.pink,
                      child: Stack(
                        alignment: Alignment.center,
                        fit: StackFit.expand,
                        children: [
                          Positioned(
                            top: 0,
                            child: Image.asset(
                              'images/cover.jpg',
                              height: displayHeight(context) * 0.2,
                              width: displayWidth(context),
                              fit: BoxFit.cover,
                            ),
                          ),
                          Container(
                            width: displayWidth(context),
                            decoration: const BoxDecoration(
                                gradient: LinearGradient(
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter,
                                    colors: [Colors.transparent, Colors.white],
                                    stops: [0, .7])),
                          ),
                          Positioned(
                              top: displayHeight(context) * 0.16,
                              child: Container(
                                height: displayHeight(context) * 0.1,
                                width: displayWidth(context) * 0.2,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(25),
                                  border: Border.all(
                                      color: Colors.orangeAccent, width: 2.3),
                                ),
                              )),
                          Positioned(
                              top: displayHeight(context) * 0.1655,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(25),
                                child: Image.asset(
                                  'images/male.jpg',
                                  height: displayHeight(context) * 0.0905,
                                  width: displayWidth(context) * 0.175,
                                ),
                              )),
                          Positioned(
                              top: displayHeight(context) * 0.02,
                              child: Text(
                                thisProfile!.title,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: displayWidth(context) * 0.05,
                                    letterSpacing: 0.8),
                              )),
                          Positioned(
                              left: displayWidth(context) * 0.02,
                              top: displayHeight(context) * 0.005,
                              child: InkWell(
                                onTap: () => Navigator.pop(context),
                                child: Card(
                                  elevation: 6,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10)),
                                  color: Colors.white70,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Center(
                                      child: Icon(
                                        Icons.arrow_back,
                                        color: Colors.black54,
                                        size: displayWidth(context) * 0.05,
                                      ),
                                    ),
                                  ),
                                ),
                              )),
                          Positioned(
                              right: displayWidth(context) * 0.02,
                              top: displayHeight(context) * 0.005,
                              child: IconButton(
                                iconSize: displayWidth(context) * 0.08,
                                icon: const Icon(Icons.more_vert),
                                onPressed: () async {},
                                color: Colors.white70,
                              )),
                        ],
                      ),
                    ),
                    Text(
                      thisProfile.username,
                      style: TextStyle(
                          color: Colors.black87,
                          fontSize: displayWidth(context) * 0.045,
                          fontWeight: FontWeight.bold),
                    ),
                    const Opacity(
                      opacity: 0.0,
                      child: Divider(
                        height: 2,
                      ),
                    ),
                    Container(
                      height: displayHeight(context) * 0.1,
                      width: displayWidth(context),
                      //color: Colors.red,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                              child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                thisProfile.followers.length.toString(),
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: displayWidth(context) * 0.04),
                              ),
                              Text(
                                'Followers',
                                style: TextStyle(
                                    color: Colors.grey,
                                    fontWeight: FontWeight.w600,
                                    fontSize: displayWidth(context) * 0.036),
                              )
                            ],
                          )),
                          Expanded(
                              child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                thisProfile.followings.length.toString(),
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: displayWidth(context) * 0.04),
                              ),
                              Text(
                                'Following',
                                style: TextStyle(
                                    color: Colors.grey,
                                    fontWeight: FontWeight.w600,
                                    fontSize: displayWidth(context) * 0.036),
                              ),
                            ],
                          )),
                          Expanded(
                              child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                posts.length.toString(),
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: displayWidth(context) * 0.04),
                              ),
                              Text(
                                'Posts',
                                style: TextStyle(
                                    color: Colors.grey,
                                    fontWeight: FontWeight.w600,
                                    fontSize: displayWidth(context) * 0.036),
                              )
                            ],
                          ))
                        ],
                      ),
                    ),
                    Opacity(
                      opacity: 0.0,
                      child: Divider(
                        height: displayHeight(context) * 0.01,
                      ),
                    ),
                    Container(
                      height: displayHeight(context) * 0.08,
                      width: displayWidth(context),
                      //color: Colors.red,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          InkWell(
                            onTap: () {
                              setState(() {
                                loadAfterFollowProcess = true;
                              });
                              if (thisProfile.followers
                                  .contains(currentUser!.uid.toString())) {
                                Provider.of<usersProvider>(context,
                                        listen: false)
                                    .unFollowUser(
                                        currentUser!.uid.toString(), thisProfile.uid)
                                    .then((value) {
                                  setState(() {
                                    loadAfterFollowProcess = false;
                                  });
                                });
                              } else {
                                Provider.of<usersProvider>(context,
                                        listen: false)
                                    .followUser(
                                        currentUser!.uid.toString(), thisProfile.uid)
                                    .then((value) {
                                  setState(() {
                                    loadAfterFollowProcess = false;
                                  });
                                });
                              }
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                gradient: LinearGradient(
                                    begin: Alignment.topRight,
                                    end: Alignment.bottomLeft,
                                    colors: [
                                      Colors.deepOrange,
                                      Colors.deepOrangeAccent,
                                      Colors.orange[600]!,
                                    ]),
                              ),
                              height: displayHeight(context) * 0.065,
                              width: displayWidth(context) * 0.4,
                              child: Center(
                                child: (loadAfterFollowProcess)
                                    ? const Center(
                                        child: Padding(
                                          padding: EdgeInsets.all(8.0),
                                          child: CircularProgressIndicator(
                                            color: Colors.black38,
                                            backgroundColor: Colors.white,
                                          ),
                                        ),
                                      )
                                    : Text(
                                        (thisProfile.followers.contains(
                                                currentUser!.uid.toString()))
                                            ? 'Unfollow'
                                            : 'Follow',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize:
                                                displayWidth(context) * 0.045),
                                      ),
                              ),
                            ),
                          ),
                          Opacity(opacity: 0.0, child: VerticalDivider()),
                          Card(
                              elevation: 5,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)),
                              color: Colors.white70,
                              child: Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: Icon(
                                  Icons.mail_outline,
                                  size: displayWidth(context) * 0.05,
                                  color: Colors.black54,
                                ),
                              ))
                        ],
                      ),
                    ),
                    Opacity(
                      opacity: 0.0,
                      child: Divider(
                        height: displayHeight(context) * 0.025,
                      ),
                    ),
                    Container(
                      height: displayHeight(context) * 0.08,
                      width: displayWidth(context) * 0.62,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(15)),
                      child:  Center(
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              left: 45.0,
                                              right: 45,
                                              top: 8,
                                              bottom: 8),
                                          child: Text(
                                            'Posts',
                                            style: TextStyle(
                                                color: Colors.black87,
                                                fontSize:
                                                    displayWidth(context) *
                                                        0.042,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                      ),
                                    ),
                                    GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      //dragStartBehavior: DragStartBehavior.down,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 3),
                      itemCount: posts.values.toList().length,
                      padding: const EdgeInsets.all(8),

                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: CachedNetworkImage(
                                height: displayHeight(context) * 0.1,
                                width: displayWidth(context) * 0.3,
                                fit: BoxFit.cover,
                                imageUrl: posts.values.toList()[index].image),
                          ),
                        );
                      },
                    ),



                  ],
                ),
        ),
      ),
    );
  }
}
