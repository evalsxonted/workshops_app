import 'package:flutter/material.dart';
import 'package:workshops/features/workshops/domain/entities/mini_workshop.dart';
import 'package:workshops/features/workshops/presentation/pages/workshop_page.dart';

class MiniWorkshopCard extends StatelessWidget {
  final MiniWorkshop miniWorkshop;
  const MiniWorkshopCard({Key key, this.miniWorkshop}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => WorkshopPage(
            workshopId: miniWorkshop.id,
          ),
        ));
      },
      child: Card(
        margin: EdgeInsets.all(10),
        shadowColor: Color(0xffF4D6CC),
        color: Color(0xff16DBC2),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  children: [
                    Text(
                      miniWorkshop.title,
                      style: TextStyle(fontSize: 22),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                  ],
                ),
              ),
            ),
            Image.network(
              miniWorkshop.image,
              width: 150,
              height: 150,
              fit: BoxFit.cover,
            ),
          ],
        ),
      ),
    );
  }
}
