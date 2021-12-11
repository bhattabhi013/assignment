import 'package:flutter_neumorphic/flutter_neumorphic.dart';

class NeuLeadButton extends StatelessWidget {
  final VoidCallback onPressed;
  final Widget child;
  final double border;
  final Icon icon;
  final Color color;

  const NeuLeadButton(
      {
      required this.onPressed,
      required this.child,
      this.border = 8.0,
      required this.icon,
      this.color = Colors.indigo
      });

  @override
  Widget build(BuildContext context) {
    return NeumorphicButton(
        onPressed: this.onPressed,
        style: NeumorphicStyle(
            intensity: .3,
            color: Colors.grey[900],
            depth: 10,
            boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(200))),
        padding: EdgeInsets.all(this.border),
        child: Neumorphic(
            style: NeumorphicStyle(
                intensity: .4,
                color: this.color,
                depth: 5,
                boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(200))),
            child: SizedBox(
              height: double.maxFinite,
              child: Row(
                children: [
                  Container(
                    height: double.maxFinite,
                    margin: EdgeInsets.symmetric(vertical: 2.0).copyWith(left: 1.0),
                    padding: EdgeInsets.all(8.0),
                    decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.white38),
                    child: Center(child: this.icon),
                  ),
                  Spacer(),
                  this.child,
                  Spacer(),
                  SizedBox(
                    width: 10.0,
                  )
                ],
              ),
            )));
  }
}
