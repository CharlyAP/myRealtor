class Rent {
  const Rent({
    required this.client,
    required this.tenants,
    required this.kids,
    required this.pets,
    required this.propertyType,
    required this.totalBed,
    required this.totalBath,
    required this.parkingSpaces,
    required this.contractTerminationDate,
    required this.movingDate,
    required this.maxMonthlyPayment,
    required this.searchAreas,
    required this.additionalNotes,
  });

  //Client Personal information
  final Client client;
  final int tenants;
  final int kids;
  final String pets;
  final List<String> propertyType; //prop info
  final int totalBed;
  final int totalBath;
  final int parkingSpaces;
  final DateTime contractTerminationDate; //additional info
  final DateTime movingDate;
  final int maxMonthlyPayment;
  final String searchAreas;
  final String additionalNotes;
}

class Client {
  const Client({
    required this.phone,
    required this.name,
    required this.lastName,
    required this.email,
  });

  final String name;
  final String lastName;
  final String phone;
  final String email;
}

/*class Pet {
  Pet({required this.type, required this.quantity}) : id = uuid.v4();

  final String id;
  final String type;
  final int quantity;
}*/
