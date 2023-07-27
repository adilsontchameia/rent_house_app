import '../filtered_advertisiment.dart';

class TopPickedCardContent extends StatelessWidget {
  const TopPickedCardContent({
    super.key,
    required this.icon,
    required this.content,
  });

  final IconData icon;
  final String content;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Icon(
          icon,
          size: 15.0,
          color: Colors.white,
        ),
        Expanded(
          child: Text(
            content,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 12.0,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),
      ],
    );
  }
}
