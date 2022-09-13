import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
 
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';

import 'fullscreenedired.dart';
class GalleryImage extends StatefulWidget {
  final List<String> imageUrls;
  final String titileGallery;

  const GalleryImage({@required this.imageUrls, this.titileGallery});
  @override
  _GalleryImageState createState() => _GalleryImageState();
}
Widget getEmptyWidget() {
  /// reference
  /// https://stackoverflow.com/a/55796929/2172590
  return SizedBox.shrink();
}

// to view image in full screen
class GalleryImageViewWrapper extends StatefulWidget {
  final LoadingBuilder loadingBuilder;
  final Decoration backgroundDecoration;
  final int initialIndex;
  final PageController pageController;
  final List<GalleryItemModel> galleryItems;
  final Axis scrollDirection;
  final String titileGallery;

  GalleryImageViewWrapper({
    this.loadingBuilder,
    this.titileGallery,
    this.backgroundDecoration,
    this.initialIndex,
    @required this.galleryItems,
    this.scrollDirection = Axis.horizontal,
  }) : pageController = PageController(initialPage: initialIndex);

  @override
  State<StatefulWidget> createState() {
    return _GalleryImageViewWrapperState();
  }
}

class _GalleryImageViewWrapperState extends State<GalleryImageViewWrapper> {
  int currentIndex;
  final minScale = PhotoViewComputedScale.contained * 0.8;
  final maxScale = PhotoViewComputedScale.covered * 8;





double dy=0;
double opac=1;
double sdy=0;
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
     backgroundColor: Colors.white.withOpacity(opac),
      appBar: AppBar(
        title: Text(widget.titileGallery ?? "Galley"),
      ),
      body: GestureDetector(
           onVerticalDragStart: (f){

          sdy=  f.globalPosition.dy ;
           },
                onVerticalDragEnd:(f){
                  if(dy>200||dy<-200)
                  Navigator.of(context).pop();
                  else{
                    setState(() {
                                          dy=0;
                                          sdy=0;
                                          opac=1;
                                        });
                  }
                },
                  onVerticalDragUpdate: (details) {
                    opac=0;
                    dy=sdy-details.globalPosition.dy;
                    setState(() {
                                          
                                        });
                  },
        child: Container(
        
          
          constraints: BoxConstraints.expand(
            
            height: MediaQuery.of(context).size.height,
          ),
          child: Stack(
            children: [
              Positioned(
                top: -1*dy,left: 0,right: 0,bottom: 0,
                child: PhotoViewGallery.builder(
                  scrollPhysics: const BouncingScrollPhysics(),
                  builder: _buildImage, 
                  itemCount: widget.galleryItems.length,
                  loadingBuilder: widget.loadingBuilder,
                  backgroundDecoration:BoxDecoration(color: Colors.white.withOpacity(opac)),
                  pageController: widget.pageController,
                  scrollDirection: widget.scrollDirection,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

// build image with zooming
  PhotoViewGalleryPageOptions _buildImage(BuildContext context, int index) {
    final GalleryItemModel item = widget.galleryItems[index];
    return PhotoViewGalleryPageOptions.customChild(
      child: Container(
        child: CachedNetworkImage(
       
          imageUrl: item.imageUrl,
          placeholder: (context, url) =>
              Center(child: CircularProgressIndicator()),
          errorWidget: (context, url, error) => Icon(Icons.error),
        ),
      ),
 
     // initialScale: PhotoViewComputedScale.covered  ,
      minScale: minScale,
      maxScale: maxScale,
     

      heroAttributes: PhotoViewHeroAttributes(tag: item.id),
    );
  }
}

class GalleryItemModel {
  GalleryItemModel({this.id, this.imageUrl});
// id image (image url) to use in hero animation
  final String id;
  // image url
  final String imageUrl;
}
class GalleryItemThumbnail extends StatelessWidget {
  const GalleryItemThumbnail({Key key, this.galleryItem, this.onTap})
      : super(key: key);

  final GalleryItemModel galleryItem;

  final GestureTapCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: GestureDetector(
        onTap: onTap,
        child: Hero(
          tag: galleryItem.id,
          child: CachedNetworkImage(
            fit: BoxFit.cover,
            imageUrl: galleryItem.imageUrl,
            height: 150.0,
            placeholder: (context, url) =>
                Center(child: CircularProgressIndicator()),
            errorWidget: (context, url, error) => Icon(Icons.error),
          ),
        ),
      ),
    );
  }
}

class _GalleryImageState extends State<GalleryImage> {
  List<GalleryItemModel> galleryItems = <GalleryItemModel>[];
  @override
  void initState() {
    buildItemsList(widget.imageUrls);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.all(10),
        child: galleryItems.isEmpty
            ? getEmptyWidget():galleryItems.length==1?GalleryItemThumbnail(
                              galleryItem: galleryItems[0],
                              onTap: () {
                                openImageFullScreen(0);
                              },
                            )
            : GridView.builder(
                primary: false,
                itemCount: galleryItems.length > 3 ? 3 : galleryItems.length,
                padding: EdgeInsets.all(0),
                semanticChildCount: 1,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  
                    crossAxisCount: galleryItems.length==1?1: galleryItems.length==2?2: 3, mainAxisSpacing: 0, crossAxisSpacing: 5),
                shrinkWrap: true,
                itemBuilder: (BuildContext context, int index) {
                  return ClipRRect(
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                      // if have less than 4 image w build GalleryItemThumbnail
                      // if have mor than 4 build image number 3 with number for other images
                      child: galleryItems.length > 3 && index == 2
                          ? buildImageNumbers(index)
                          : GalleryItemThumbnail(
                              galleryItem: galleryItems[index],
                              onTap: () {
                                openImageFullScreen(index);
                              },
                            ));
                }));
  }

// build image with number for other images
  Widget buildImageNumbers(int index) {
    return GestureDetector(
      onTap: () {
        openImageFullScreen(index);
      },
      child: Stack(
        alignment: AlignmentDirectional.center,
        fit: StackFit.expand,
        children: <Widget>[
          GalleryItemThumbnail(
            galleryItem: galleryItems[index],
          ),
          Container(
            color: Colors.black.withOpacity(.7),
            child: Center(
              child: Text(
                "+${galleryItems.length - index}",
                style: TextStyle(color: Colors.white, fontSize: 25),
              ),
            ),
          ),
        ],
      ),
    );
  }

// to open gallery image in full screen
  void openImageFullScreen(final int indexOfImage) {
    Navigator.of(context).push(
    
      MaterialTransparentRoute(
        builder: (context) => GalleryImageViewWrapper(
          titileGallery: widget.titileGallery,
          galleryItems: galleryItems,
          backgroundDecoration: const BoxDecoration(
            color: Colors.black,
          ),
          initialIndex: indexOfImage,
          scrollDirection: Axis.horizontal,
        ),
      ),
    );
  }

// clear and build list
  buildItemsList(List<String> items) {
    galleryItems.clear();
    items.forEach((item) {
      galleryItems.add(
        GalleryItemModel(id: item, imageUrl: item),
      );
    });
  }
}
