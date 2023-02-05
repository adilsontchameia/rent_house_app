import 'package:http/http.dart' as http;
import 'package:panorama/panorama.dart';
import 'package:rent_house_app/features/presentation/filtered_advertisiment/filtered_advertisiment.dart';

class ImmersiveViewerScreen extends StatefulWidget {
  static const routeName = "/panorama-screen";
  const ImmersiveViewerScreen({super.key, required this.imageIndex});
  final String imageIndex;

  @override
  State<ImmersiveViewerScreen> createState() => _ImmersiveViewerScreenState();
}

class _ImmersiveViewerScreenState extends State<ImmersiveViewerScreen> {
  Future<http.Response>? _fetchImageFuture;

  @override
  void initState() {
    super.initState();
    _fetchImage();
  }

  Future<void> _fetchImage() async {
    _fetchImageFuture = http.get(Uri.parse(widget.imageIndex));
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: FutureBuilder<http.Response>(
          future: _fetchImageFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(
                    color: Colors.brown,
                  ),
                  Text(
                    'Esta operação pode levar alguns instantes, por favor, aguarde.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.brown, fontWeight: FontWeight.w400),
                  )
                ],
              );
            } else if (snapshot.hasError) {
              return const ErrorIconOnFetching();
            } else if (snapshot.hasData && snapshot.data!.statusCode == 200) {
              return Stack(
                children: [
                  Panorama(
                    child: Image.network(widget.imageIndex),
                  ),
                  const CustomSmallButton(
                    onTap: null,
                    icon: FontAwesomeIcons.arrowLeft,
                  ),
                ],
              );
            } else {
              return const Text('Failed to fetch image.');
            }
          },
        ),
      ),
    );
  }
}
