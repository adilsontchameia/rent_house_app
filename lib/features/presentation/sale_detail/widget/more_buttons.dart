import 'dart:developer';

import 'package:rent_house_app/features/presentation/chat_messages/chat_messages_screen.dart';

import '../sale_details.dart';

class MoreButtons extends StatelessWidget {
  const MoreButtons({super.key, required this.advertisement});
  final AdvertisementModel advertisement;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        ElevatedButton.icon(
          icon: const Icon(
            FontAwesomeIcons.ellipsis,
            color: Colors.white,
          ),
          label: const Text(
            'Mais',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
          ),
          onPressed: () => _openContextMenu(context, advertisement),
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(Colors.brown),
            shape: MaterialStateProperty.all(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5.0),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Future<void> _openContextMenu(
    BuildContext context,
    AdvertisementModel advertisementModel,
  ) async {
    List<PopupMenuEntry<String>> menuItems = [
      PopupMenuItem<String>(
        value: 'Option 1',
        child: ElevatedButton.icon(
          icon: const Icon(
            Icons.phone,
            color: Colors.white,
          ),
          label: const Text(
            'Ligar',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 15.0,
            ),
          ),
          onPressed: () => _openDialPad(advertisementModel.contact!),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.brown,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5.0),
            ),
          ),
        ),
      ),
      PopupMenuItem<String>(
        value: 'Option 2',
        child: ElevatedButton.icon(
          icon: const Icon(
            Icons.message,
            color: Colors.white,
          ),
          label: const Text(
            'Chat',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 15.0,
            ),
          ),
          onPressed: () => Navigator.pushNamed(
              context, ChatMessagesScreen.routeName,
              arguments: {
                'name': advertisementModel.sellerName,
                'uid': advertisementModel.sellerId,
              }),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.brown,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5.0),
            ),
          ),
        ),
      ),
      PopupMenuItem<String>(
        value: 'Option 3',
        child: ElevatedButton.icon(
          icon: const Icon(
            Icons.map,
            color: Colors.white,
          ),
          label: const Text(
            'Mapa',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 15.0,
            ),
          ),
          onPressed: () => _openGoogleMap(
              advertisementModel.latitude!, advertisementModel.longitude!),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.brown,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5.0),
            ),
          ),
        ),
      ),
      PopupMenuItem<String>(
        value: 'Option 4',
        child: ElevatedButton.icon(
          icon: const Icon(
            Icons.share,
            color: Colors.white,
          ),
          label: const Text(
            'Partilhar',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 15.0,
            ),
          ),
          onPressed: () {
            _shareContent(advertisement);
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.brown,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5.0),
            ),
          ),
        ),
      ),
    ];

    // Get the render box of the widget that triggers the context menu (in this case, the ElevatedButton).
    final RenderBox button = context.findRenderObject() as RenderBox;

    // Calculate the position where the menu should be displayed.
    final RenderBox overlay =
        Overlay.of(context).context.findRenderObject() as RenderBox;
    final RelativeRect position = RelativeRect.fromRect(
      Rect.fromPoints(
        button.localToGlobal(button.size.bottomLeft(Offset.zero),
            ancestor: overlay),
        button.localToGlobal(button.size.bottomRight(Offset.zero),
            ancestor: overlay),
      ),
      Offset.zero & overlay.size,
    );

    // Show the context menu.
    final String? selectedOption = await showMenu<String>(
      context: context,
      position: position,
      items: menuItems,
    );

    // Handle the selected option (if any).
    if (selectedOption != null) {
      log('Selected option: $selectedOption');
      if (selectedOption == 'Option 4') {
        _shareContent(advertisementModel);
      }
    }
  }

  Future<void> _openDialPad(String phoneNumber) async {
    Uri url = Uri(scheme: "tel", path: phoneNumber);
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      log("Can't open dial pad.");
    }
  }

  Future<void> _openGoogleMap(double lat, double lng) async {
    var uri = Uri.parse("google.navigation:q=$lat,$lng&mode=d");
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      throw 'Could not launch ${uri.toString()}';
    }
  }

  Future<void> _shareContent(AdvertisementModel advertisement) async {
    // List of content to be shared
    List<String> contentList = [
      'Proprietário: Adilson Tchameia',
      'Quartos: ${advertisement.bedRooms}',
      'WC: ${advertisement.bathRoom}',
      'Cozinha: ${advertisement.kitchen}',
      'Sala: ${advertisement.livingRoom}',
      'Tipo: ${advertisement.type}',
      'Quintal: ${advertisement.yard}',
      'Eletricidade: ${advertisement.electricity}',
      'Água: ${advertisement.water}',
      'Endereço: ${advertisement.address}',
      'Contact: ${advertisement.contact}',
      'Mensalidade: ${KwanzaFormatter.formatKwanza(advertisement.monthlyPrice!)}',
      'Mais Detalhes: ${advertisement.additionalDescription}',
    ];

    // To split each
    String content = contentList.join('\n');

    // Subject for the sharing action
    String subject = 'Casa disponível';

    // Call the share function
    await Share.share(content, subject: subject);
  }
}
