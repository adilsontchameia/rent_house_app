import 'dart:developer';

import '../sale_details.dart';

class VerifiedSeller extends StatelessWidget {
  VerifiedSeller({
    super.key,
    required this.sellerId,
  });

  final String sellerId;
  final SellerServiceManager _sellerServiceManager = SellerServiceManager();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<SellerModel>(
        stream: _sellerServiceManager.getByIdAsStream(sellerId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Container();
          } else if (snapshot.hasError) {
            log('${snapshot.hasError}');
            return Container();
          } else if (!snapshot.hasData) {
            return Container();
          } else {
            return Builder(builder: (context) {
              SellerModel sellerModel = snapshot.data!;
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        '${sellerModel.firstName} ${sellerModel.surnName}',
                        style: const TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 12.0,
                        ),
                      ),
                      const SizedBox(width: 5.0),
                      Row(
                        children: [
                          SellerBages(
                            state: sellerModel.isVerified!,
                            icon: FontAwesomeIcons.check,
                            containerColor: Colors.blue,
                          ),
                          const SizedBox(width: 5.0),
                          SellerBages(
                            state: sellerModel.isTopSeller!,
                            icon: FontAwesomeIcons.trophy,
                            containerColor: Colors.amber,
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              );
            });
          }
        });
  }
}
