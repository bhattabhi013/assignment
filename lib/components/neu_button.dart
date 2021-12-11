import 'package:flutter_neumorphic/flutter_neumorphic.dart';



class NeuButton extends StatelessWidget {
  final VoidCallback onPressed;
  final Widget child;
  final double border;
  final bool isActive;
  final bool isLoading;

  const NeuButton({
      required this.onPressed,
      required this.child,
      this.border = 8.0,
      this.isActive = true,
      this.isLoading = false});

  @override
  Widget build(BuildContext context) {
    return NeumorphicButton(
        onPressed:
            (this.isActive && !this.isLoading) ? this.onPressed : () => {},
        style: NeumorphicStyle(
            intensity: .4,
            color: Colors.grey[900],
            depth: 10,
            boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(200))),
        padding: EdgeInsets.all(this.border),
        child: Neumorphic(
            style: NeumorphicStyle(
                intensity: .4,
                color: (this.isActive && !this.isLoading)
                    ? Colors.indigo
                    : Colors.grey[600],
                depth: -10,
                boxShape:
                    NeumorphicBoxShape.roundRect(BorderRadius.circular(200))),
          ),
    );
  }
}
