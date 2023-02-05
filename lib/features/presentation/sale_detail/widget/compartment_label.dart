import '../sale_details.dart';

class CompartmentsLabel extends StatelessWidget {
  const CompartmentsLabel({
    super.key,
    required this.icon,
    required this.label,
    required this.qty,
  });
  final IconData icon;
  final String label;
  final String qty;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          icon,
          size: 20.0,
          color: Colors.brown,
        ),
        const SizedBox(width: 10.0),
        Text(
          '$label: $qty',
          style: const TextStyle(
            fontWeight: FontWeight.w400,
            fontSize: 15.0,
          ),
          textAlign: TextAlign.justify,
        ),
      ],
    );
  }
}
