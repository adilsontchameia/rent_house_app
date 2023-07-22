//House Model Mock
class House {
  final String houseName;
  final String houseImage;
  final String houseCurrentPrice;
  final String houseOldPrice;
  final bool isAvailable;

  House({
    required this.houseName,
    required this.houseImage,
    required this.houseCurrentPrice,
    required this.houseOldPrice,
    required this.isAvailable,
  });
}

// House Category Mock
class HouseCategory {
  final String houseCategoryName;
  final String categoryCount;
  final String thumbnailImage;

  HouseCategory({
    required this.houseCategoryName,
    required this.categoryCount,
    required this.thumbnailImage,
  });
}

//List of categories
final categories = [
  HouseCategory(
    houseCategoryName: 'Small',
    categoryCount: '5.000',
    thumbnailImage:
        'https://images.unsplash.com/photo-1580587771525-78b9dba3b914?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=774&q=80',
  ),
  HouseCategory(
    houseCategoryName: 'Medium',
    categoryCount: '10.000',
    thumbnailImage:
        'https://plus.unsplash.com/premium_photo-1677010272095-229d42592cf3?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=796&q=80',
  ),
  HouseCategory(
    houseCategoryName: 'Big',
    categoryCount: '25.000',
    thumbnailImage:
        'https://images.unsplash.com/photo-1570129477492-45c003edd2be?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=870&q=80',
  )
];

//List of categories
final products = [
  House(
    houseName: 'T2',
    houseImage:
        'https://images.unsplash.com/photo-1570129477492-45c003edd2be?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=870&q=80',
    houseCurrentPrice: '10.000',
    houseOldPrice: '15.000',
    isAvailable: false,
  ),
  House(
    houseName: 'T4',
    houseImage:
        'https://plus.unsplash.com/premium_photo-1677010272095-229d42592cf3?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=796&q=80',
    houseCurrentPrice: '50.000',
    houseOldPrice: '85.000',
    isAvailable: false,
  ),
  House(
    houseName: 'T2',
    houseImage:
        'https://images.unsplash.com/photo-1570129477492-45c003edd2be?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=870&q=80',
    houseCurrentPrice: '10.000',
    houseOldPrice: '15.000',
    isAvailable: false,
  ),
  House(
    houseName: 'T4',
    houseImage:
        'https://plus.unsplash.com/premium_photo-1677010272095-229d42592cf3?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=796&q=80',
    houseCurrentPrice: '50.000',
    houseOldPrice: '85.000',
    isAvailable: false,
  ),
  House(
    houseName: 'T2',
    houseImage:
        'https://images.unsplash.com/photo-1570129477492-45c003edd2be?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=870&q=80',
    houseCurrentPrice: '10.000',
    houseOldPrice: '15.000',
    isAvailable: false,
  ),
  House(
    houseName: 'T4',
    houseImage:
        'https://plus.unsplash.com/premium_photo-1677010272095-229d42592cf3?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=796&q=80',
    houseCurrentPrice: '50.000',
    houseOldPrice: '85.000',
    isAvailable: false,
  ),
  House(
    houseName: 'T2',
    houseImage:
        'https://images.unsplash.com/photo-1570129477492-45c003edd2be?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=870&q=80',
    houseCurrentPrice: '10.000',
    houseOldPrice: '15.000',
    isAvailable: false,
  ),
  House(
    houseName: 'T4',
    houseImage:
        'https://plus.unsplash.com/premium_photo-1677010272095-229d42592cf3?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=796&q=80',
    houseCurrentPrice: '50.000',
    houseOldPrice: '85.000',
    isAvailable: false,
  ),
  House(
    houseName: 'T2',
    houseImage:
        'https://images.unsplash.com/photo-1570129477492-45c003edd2be?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=870&q=80',
    houseCurrentPrice: '10.000',
    houseOldPrice: '15.000',
    isAvailable: false,
  ),
  House(
    houseName: 'T4',
    houseImage:
        'https://plus.unsplash.com/premium_photo-1677010272095-229d42592cf3?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=796&q=80',
    houseCurrentPrice: '50.000',
    houseOldPrice: '85.000',
    isAvailable: false,
  ),
  House(
    houseName: 'T2',
    houseImage:
        'https://images.unsplash.com/photo-1570129477492-45c003edd2be?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=870&q=80',
    houseCurrentPrice: '10.000',
    houseOldPrice: '15.000',
    isAvailable: false,
  ),
  House(
    houseName: 'T4',
    houseImage:
        'https://plus.unsplash.com/premium_photo-1677010272095-229d42592cf3?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=796&q=80',
    houseCurrentPrice: '50.000',
    houseOldPrice: '85.000',
    isAvailable: false,
  ),
  House(
    houseName: 'T2',
    houseImage:
        'https://images.unsplash.com/photo-1570129477492-45c003edd2be?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=870&q=80',
    houseCurrentPrice: '10.000',
    houseOldPrice: '15.000',
    isAvailable: false,
  ),
  House(
    houseName: 'T4',
    houseImage:
        'https://plus.unsplash.com/premium_photo-1677010272095-229d42592cf3?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=796&q=80',
    houseCurrentPrice: '50.000',
    houseOldPrice: '85.000',
    isAvailable: false,
  ),
  House(
    houseName: 'T2',
    houseImage:
        'https://images.unsplash.com/photo-1570129477492-45c003edd2be?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=870&q=80',
    houseCurrentPrice: '10.000',
    houseOldPrice: '15.000',
    isAvailable: false,
  ),
  House(
    houseName: 'T4',
    houseImage:
        'https://plus.unsplash.com/premium_photo-1677010272095-229d42592cf3?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=796&q=80',
    houseCurrentPrice: '50.000',
    houseOldPrice: '85.000',
    isAvailable: false,
  ),
  House(
    houseName: 'T2',
    houseImage:
        'https://images.unsplash.com/photo-1570129477492-45c003edd2be?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=870&q=80',
    houseCurrentPrice: '10.000',
    houseOldPrice: '15.000',
    isAvailable: false,
  ),
  House(
    houseName: 'T4',
    houseImage:
        'https://plus.unsplash.com/premium_photo-1677010272095-229d42592cf3?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=796&q=80',
    houseCurrentPrice: '50.000',
    houseOldPrice: '85.000',
    isAvailable: false,
  ),
  House(
    houseName: 'T2',
    houseImage:
        'https://images.unsplash.com/photo-1570129477492-45c003edd2be?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=870&q=80',
    houseCurrentPrice: '10.000',
    houseOldPrice: '15.000',
    isAvailable: false,
  ),
  House(
    houseName: 'T4',
    houseImage:
        'https://plus.unsplash.com/premium_photo-1677010272095-229d42592cf3?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=796&q=80',
    houseCurrentPrice: '50.000',
    houseOldPrice: '85.000',
    isAvailable: false,
  ),
  House(
    houseName: 'T2',
    houseImage:
        'https://images.unsplash.com/photo-1570129477492-45c003edd2be?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=870&q=80',
    houseCurrentPrice: '10.000',
    houseOldPrice: '15.000',
    isAvailable: false,
  ),
  House(
    houseName: 'T4',
    houseImage:
        'https://plus.unsplash.com/premium_photo-1677010272095-229d42592cf3?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=796&q=80',
    houseCurrentPrice: '50.000',
    houseOldPrice: '85.000',
    isAvailable: false,
  ),
  House(
    houseName: 'T2',
    houseImage:
        'https://images.unsplash.com/photo-1570129477492-45c003edd2be?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=870&q=80',
    houseCurrentPrice: '10.000',
    houseOldPrice: '15.000',
    isAvailable: false,
  ),
  House(
    houseName: 'T4',
    houseImage:
        'https://plus.unsplash.com/premium_photo-1677010272095-229d42592cf3?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=796&q=80',
    houseCurrentPrice: '50.000',
    houseOldPrice: '85.000',
    isAvailable: false,
  ),
];
