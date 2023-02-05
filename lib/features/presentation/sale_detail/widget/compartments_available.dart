import '../sale_details.dart';

class AllCompartmentsAvailable extends StatelessWidget {
  const AllCompartmentsAvailable({
    super.key,
    required this.advertisement,
  });

  final AdvertisementModel advertisement;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      direction: Axis.horizontal,
      spacing: 20.0,
      children: [
        CompartmentsLabel(
          icon: FontAwesomeIcons.circleInfo,
          label: 'Descrição Breve',
          qty: '${advertisement.title}',
        ),
        CompartmentsLabel(
          icon: FontAwesomeIcons.bed,
          label: 'Quartos',
          qty: '${advertisement.bedRooms}',
        ),
        CompartmentsLabel(
          icon: FontAwesomeIcons.toilet,
          label: 'WC',
          qty: '${advertisement.bathRoom}',
        ),
        CompartmentsLabel(
          icon: FontAwesomeIcons.bowlFood,
          label: 'Cozinha',
          qty: '${advertisement.kitchen}',
        ),
        CompartmentsLabel(
          icon: FontAwesomeIcons.tv,
          label: 'Sala',
          qty: '${advertisement.livingRoom}',
        ),
        CompartmentsLabel(
          icon: FontAwesomeIcons.houseCircleCheck,
          label: 'Tipo',
          qty: '${advertisement.type}',
        ),
        CompartmentsBoolLabel(
            icon: FontAwesomeIcons.doorOpen,
            label: 'Quintal',
            isTrue: advertisement.yard!),
        CompartmentsBoolLabel(
          icon: FontAwesomeIcons.cableCar,
          label: 'Eletricidade',
          isTrue: advertisement.electricity!,
        ),
        CompartmentsBoolLabel(
          icon: FontAwesomeIcons.water,
          label: 'Água',
          isTrue: advertisement.water!,
        ),
        CompartmentsLabel(
          icon: FontAwesomeIcons.addressBook,
          label: 'Endereço',
          qty: '${advertisement.address}',
        ),
        CompartmentsLabel(
            icon: FontAwesomeIcons.phone,
            label: 'Telefone',
            qty: advertisement.contact!),
        CompartmentsLabel(
          icon: FontAwesomeIcons.moneyBillTransfer,
          label: 'Mensalidade',
          qty: KwanzaFormatter.formatKwanza(
              double.parse(advertisement.monthlyPrice!.toString())),
        ),
      ],
    );
  }
}

class CompartmentsBoolLabel extends StatelessWidget {
  const CompartmentsBoolLabel({
    super.key,
    required this.icon,
    required this.isTrue,
    required this.label,
  });
  final IconData icon;
  final bool isTrue;
  final String label;
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
          isTrue ? '$label: Sim' : '$label: Não',
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
