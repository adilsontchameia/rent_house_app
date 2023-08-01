import '../sale_details.dart';

class CustomSmallButton extends StatelessWidget {
  const CustomSmallButton({super.key, required this.onTap, required this.icon});

  final VoidCallback? onTap;
  final IconData icon;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: GestureDetector(
        onTap: onTap ?? () => Navigator.pop(context),
        child: Container(
          height: 32.0,
          width: 32.0,
          margin: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
          decoration: const BoxDecoration(
            color: Colors.brown,
            shape: BoxShape.circle,
          ),
          child: Icon(
            icon,
            size: 15.0,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
