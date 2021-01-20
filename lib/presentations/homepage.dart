import 'dart:io';
import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive/hive.dart';
import 'package:image_picker/image_picker.dart';
import 'package:photo_app_assignment/presentations/custom/image_post.dart';
import 'package:photo_app_assignment/utils/string_values.dart';
import 'package:photo_app_assignment/utils/styles.dart';

class HomePage extends StatefulWidget {
  static const routeName = "HomePage";
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Box<ImagePost> postsBox;
  // final ValueNotifier<Box<ImagePost>> postsBox =
  //     ValueNotifier<Box<ImagePost>>(Hive.box<ImagePost>(StringValue.postsWord));

  @override
  void initState() {
    super.initState();
    postsBox = Hive.box<ImagePost>(StringValue.postsWord);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(StringValue.appTitle),
        centerTitle: true,
      ),
      bottomNavigationBar: bottomBar(),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: Center(
          child: Container(
            padding: EdgeInsets.symmetric(
                horizontal: ScreenUtil().setWidth(10),
                vertical: ScreenUtil().setHeight(5)),
            child: (postsBox == null || postsBox.length == 0)
                ? Text("No Image")
                : ListView.separated(
                    separatorBuilder: (_, index) => Divider(),
                    itemCount: postsBox.length,
                    shrinkWrap: true,
                    itemBuilder: (BuildContext ctxt, int index) {
                      return imagePost(postsBox.get(index), index);
                    },
                  ),
          ),
        ),
      ),
    );
  }

  bottomBar() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: ScreenUtil().setHeight(5)),
      child: IconButton(
        icon: Icon(Icons.add_circle_outline_rounded),
        onPressed: showOption,
        iconSize: ScreenUtil().setHeight(40),
      ),
      //height: ScreenUtil().setHeight(60),
      width: double.infinity,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
      ),
    );
  }

  showOption() {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(StringValue.pickImage),
        content: Container(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              FlatButton(
                onPressed: openCamera,
                child: Text(StringValue.takePhoto),
              ),
              Divider(),
              FlatButton(
                onPressed: openGallery,
                child: Text(StringValue.openGallery),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future openCamera() async {
    PickedFile image = await ImagePicker().getImage(source: ImageSource.camera);
    if (image != null) {
      postsBox.put(postsBox.length,
          ImagePost(image.path, 0, List<String>(), false, false));
      setState(() {});
    }
    Navigator.of(context).pop();
  }

  Future openGallery() async {
    PickedFile image =
        await ImagePicker().getImage(source: ImageSource.gallery);
    if (image != null) {
      postsBox.put(postsBox.length,
          ImagePost(image.path, 0, List<String>(), false, false));
      setState(() {});
    }
    Navigator.of(context).pop();
  }

  imagePost(ImagePost post, int index) {
    TextEditingController currComment = TextEditingController();
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // photo and username
          Row(
            children: [
              CircleAvatar(
                // radius: ScreenUtil().setHeight(50),
                backgroundImage: AssetImage(Styles.userPhoto),
                backgroundColor: Colors.grey,
              ),
              SizedBox(width: ScreenUtil().setWidth(10)),
              Text(
                StringValue.username,
                style: TextStyle(
                    fontSize: ScreenUtil().setSp(16),
                    fontWeight: FontWeight.bold),
              )
            ],
          ),
          SizedBox(height: ScreenUtil().setHeight(10)),
          // main image
          Container(
              width: double.infinity,
              height: ScreenUtil().setHeight(300),
              child: Image.file(File(post.image))),
          // like and comment button
          Row(children: [
            IconButton(
              icon: Icon(Icons.thumb_up_alt_outlined),
              onPressed: () {
                setState(() {
                  ++post.likes;
                  postsBox.put(index, post);
                });
              },
            ),
            IconButton(
              icon: Icon(Icons.message_outlined),
              onPressed: () {
                setState(() {
                  post.typeComment = true;
                  postsBox.put(index, post);
                });
              },
            ),
          ]),
          // no of likes
          Text(
            "   ${post.likes} Likes",
            style: TextStyle(
                fontSize: ScreenUtil().setSp(14), fontWeight: FontWeight.bold),
          ),
          SizedBox(height: ScreenUtil().setHeight(10)),
          // username
          Text(
            "  " + StringValue.username,
            style: TextStyle(
                fontSize: ScreenUtil().setSp(16), fontWeight: FontWeight.bold),
          ),
          // type comment
          Container(
            child: (!(post.typeComment))
                ? SizedBox(height: ScreenUtil().setHeight(1))
                : Column(
                    children: [
                      TextField(
                        controller: currComment,
                        decoration: InputDecoration(
                          hintText: StringValue.saySomething,
                          suffixIcon: IconButton(
                            icon: Icon(Icons.check_circle_outline),
                            onPressed: () {
                              setState(() {
                                if (currComment.text != "") {
                                  post.comments.add(currComment.text);
                                }
                                post.typeComment = !post.typeComment;
                                postsBox.put(index, post);
                              });
                            },
                          ),
                        ),
                      ),
                      SizedBox(height: ScreenUtil().setHeight(10)),
                    ],
                  ),
          ),
          // view all comments button
          Container(
            margin: EdgeInsets.only(top: ScreenUtil().setHeight(6)),
            child: ((post.comments).length > 0 && !(post.showComments))
                ? InkWell(
                    onTap: () {
                      setState(() {
                        post.showComments = true;
                        postsBox.put(index, post);
                      });
                    },
                    child: Text("   View all ${post.comments.length} comments"),
                  )
                : SizedBox(height: ScreenUtil().setHeight(1)),
          ),
          // showing all comments and hide comments button
          Container(
            // padding: EdgeInsets.symmetric(vertical: ScreenUtil().setHeight(2)),
            child: !(post.showComments)
                ? SizedBox(height: ScreenUtil().setHeight(1))
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ListView.builder(
                        // controller: ,
                        shrinkWrap: true,
                        itemCount: post.comments.length,
                        itemBuilder: (BuildContext ctxt, int idx) {
                          return Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Icon(Icons.chevron_right),
                              SizedBox(width: ScreenUtil().setWidth(4)),
                              Expanded(
                                child: Text(
                                  post.comments[idx],
                                  style: TextStyle(color: Colors.black),
                                ),
                              )
                            ],
                          );
                        },
                      ),
                      SizedBox(height: ScreenUtil().setHeight(5)),
                      InkWell(
                        onTap: () {
                          setState(() {
                            post.showComments = false;
                          });
                        },
                        child: Text(
                            "   Hide all ${post.comments.length} comments"),
                      ),
                      SizedBox(height: ScreenUtil().setHeight(10)),
                    ],
                  ),
          ),
          SizedBox(height: ScreenUtil().setHeight(20)),
        ],
      ),
    );
  }
}
