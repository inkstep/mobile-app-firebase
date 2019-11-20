import 'package:flutter/material.dart';
import 'package:inkstep/ui/components/feature_discovery.dart';

class DescribedIconButton extends StatelessWidget {
  const DescribedIconButton({
    Key key,
    @required this.icon,
    @required this.featureId,
    this.onPressed,
  }) : super(key: key);

  final IconData icon;
  final String featureId;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: Colors.grey.shade200,
        ),
      ),
      child: DescribedFeatureOverlay(
        featureId: featureId,
        icon: icon,
        color: Theme.of(context).accentColor,
        title: 'Care Information',
        description: 'Tap the care icon to see your current tattoo care information.',
        child: IconButton(
          icon: Icon(
            icon,
            color: Theme.of(context).backgroundColor,
            size: 20,
          ),
          onPressed: onPressed,
        ),
      ),
    );
  }
}
