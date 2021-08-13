import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter/material.dart';

class ProfileWidget extends StatelessWidget {
  final String imagePath;
  final bool isEdit;
  final VoidCallback onClicked;

  const ProfileWidget({
    Key? key,
    required this.imagePath,
    this.isEdit = false,
    required this.onClicked,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme.primary;

    return Center(
      child: Stack(
        children: [
          buildImage(),
          Positioned(
            bottom: 0,
            right: 4,
            child: buildEditIcon(color),
          ),
        ],
      ),
    );
  }

  Widget buildImage() {
    final image = NetworkImage(imagePath);

    return ClipOval(
      child: Material(
        color: Colors.transparent,
        child: Ink.image(
          image: image,
          fit: BoxFit.cover,
          width: 128,
          height: 128,
          child: InkWell(onTap: onClicked),
        ),
      ),
    );
  }

  Widget buildEditIcon(Color color) => buildCircle(
        color: Colors.white,
        all: 3,
        child: buildCircle(
          color: color,
          all: 8,
          child: Icon(
            isEdit ? Icons.add_a_photo : Icons.edit,
            color: Colors.white,
            size: 20,
          ),
        ),
      );

  Widget buildCircle({
    required Widget child,
    required double all,
    required Color color,
  }) =>
      ClipOval(
        child: Container(
          padding: EdgeInsets.all(all),
          color: color,
          child: child,
        ),
      );
}





class ProfilesWidget extends StatelessWidget {
  const ProfilesWidget({
    required Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => ListView(
    physics: BouncingScrollPhysics(),
    children: [
      buildProfile(context),
      Divider(height: 32),
      buildPhotos(context),
    ],
  );

  Widget buildPhotos(BuildContext context) => Container(
    padding: EdgeInsets.symmetric(horizontal: 12),
    child: Column(
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            'PHOTOS',
            style: TextStyle(
              color: Theme.of(context).iconTheme.color,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        SizedBox(height: 12),
        buildPhotoGrid(),
      ],
    ),
  );

  Widget buildPhotoGrid() => StaggeredGridView.countBuilder(
    primary: false,
    shrinkWrap: true,
    crossAxisCount: 4,
    mainAxisSpacing: 8,
    crossAxisSpacing: 8,
    itemCount: 8,
    itemBuilder: (BuildContext context, int index) {
      final urlImage = 'https://source.unsplash.com/random?sig=$index';

      return Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          image: DecorationImage(
            image: NetworkImage(urlImage),
            fit: BoxFit.cover,
          ),
        ),
      );
    },
    staggeredTileBuilder: (int index) =>
        StaggeredTile.count(2, index.isEven ? 2 : 1),
  );

  Widget buildProfile(BuildContext context) => Column(
  );

  Widget buildCounters(context, String firstLine, String secondLine) => Column(
    children: [
      Text(
        firstLine,
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
      SizedBox(height: 8),
      Text(secondLine),
    ],
  );
}