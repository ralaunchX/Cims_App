class AppConstants {
  static int loginValidityDays = 7;
  static const user = 'user1';
  static const password = '12345';
  static const List<String> idTypes = ['None', 'ID', 'Passport'];
  static const String notSelected = '----';
  static const List<String> maritalStatuses = [
    notSelected,
    'Single',
    'Married',
    'Divorced',
    'Separated',
    'Widowed',
  ];

  static const List<String> marriageTypes = [
    notSelected,
    'In Community of Property',
    'Out of Community of Property',
    'Customary',
    'None',
    'Traditional',
    'Other',
  ];

  static const List<String> districts = [notSelected, 'Botha-Bothe', 'Leribe'];

  static const List<String> routes = [
    notSelected,
    '1. WTW',
    '2. Ha Molapo - Ha Phakela',
    '3. Ha Khabo - Pitsi’s Nek',
    '4. Literapeng - Levi’s Nek',
    '5. Pitsi’s Nek - Rampai',
    '6. Mpharoane - Molapo',
    '7. Liphakoeng - Qholaqhoe',
    '8. Ha Majara - ‘Makong',
    '9. Qalo - Maloseng',
    '10. Maloseng - Marakabei - Rasekila',
    '11. Ha Mopeli - Ha Majara',
    '12. Mpharoane - Makeneng',
    '13. Levi\'s Nek - Nqechane',
    '14. Rampai - Shepheseli - Nkoeng',
    '15. Motsoane - Boribeng',
    '16. Levi\'s Nek - Maiseng',
    '17. Ha Sechele - Ha Shepheseli',
    '18. Rampai - Matlakeng',
    '19. Mopeli - Majara Junction',
    '20. Pokane - Qalo',
    '21. Serutle - Manamela',
    '22. Qholaqhoe - Mpharoane',
    '23. Khabo - Molotha - St Dennis',
    '24. Rasekila - Katamelo',
    '25. Maloseng - Makhoahla - Selomo',
  ];

  static const List<String> communityCouncils = [
    notSelected,
    'Ngoajane B01',
    'Likila B02',
    'Nqoe B03',
    'Tsa le Moleka B04',
    'Urban Council B05',
    'Menkhoaneng C05',
    'Maisa Phoka C06',
    'Sephokong C07',
  ];

  static const List<String> institutionTypes = [
    notSelected,
    'Business',
    'Church',
    'Community Organisation',
    'Graveyard',
    'School',
    'Other',
  ];
  static const List<String> genderList = [
    notSelected,
    'Male',
    'Female',
    'Other'
  ];

  static const List<String> wallOptions = [
    notSelected,
    'Stick / Mud',
    'Block / Stones',
    'Natural Stone',
    'Bricks with No Plaster',
    'Bricks with Plaster',
    'Mud Block',
    'Corrugated Iron Sheets',
    'Other',
  ];
  static const List<String> roofOptions = [
    notSelected,
    'Thatch / Grass',
    'Corrugated Iron',
    'Tile',
    'Other',
  ];
  static const List<String> floorOptions = [
    notSelected,
    'Mud, Earth, Dung',
    'Concrete, Cement',
    'Tile/Carpet/Vinyl finish',
    'Other',
  ];

  static const List<String> dwellingOwnership = [notSelected, 'Own', 'Rent'];
  static const List<String> structuresServicesOptions = [
    'Separate kitchen',
    'Store/shed/barn',
    'Latrine',
    'Water in homestead',
    'Electricity in homestead',
    'Grain storage',
    'Cattle/Smallstock kraal',
    'Stable',
    'Pig sty',
    'Poultry coup',
    'Bird shelter',
    'NONE',
  ];

  static const List<String> otherStructuresOptions = [
    'Malaene',
    'Muk’huk’hu (temporary structure)',
    'Shelter for animals',
    'Shop or Business site',
    'NONE',
  ];

  static const List<String> householdItemsOptions = [
    'Lounge suite / couch / chairs',
    'Dining room suite / table and chairs',
    'Kitchen unit(s)/cupboards',
    'Bed and mattress',
    'Wardrobe/ Dresser',
    'None of these',
  ];

  static const List<String> appliancesOptions = [
    'Radio',
    'Television',
    'Refrigerator',
    'Stove (gas, electric, coal, solar)',
    'Paraffin cooker',
    'Sewing machine',
    'Heater (Gas, Electric, Paraffin etc)',
    'Mobile phone',
    'Tablet',
    'Computer/Laptop',
    'Generator',
    'None of these',
  ];

  static const List<String> agriculturalEquipmentOptions = [
    'Hand held implements (Hoe, harrow, spade, sickle, saw)',
    'Animal-drawn plough or planter',
    'Animal-drawn cart',
    'Tractor',
    'Tractor-drawn plough',
    'Tractor-drawn planter',
    'Tractor drawn wagon',
    'Saddles and bridles',
    'Wheelbarrow',
    'Car',
    'Truck',
    'Van',
    'Bicycle',
    'None of these',
  ];
  static const List<String> livelihoodTypes = [
    notSelected,
    'Employment/Casual labour',
    'Own business/enterprise/self-employment',
    'Crop and vegetable production',
    'Livestock rearing and sales',
    'Production, sale of natural materials and products',
    'Grants received from government or other sources',
    'No secondary source of livelihood',
  ];
  static const List<String> incomeSources = [
    'Full-time/Part-time Employment Locally',
    'Remittances from Employment Elsewhere',
    'Irregular Employment (Casual/Seasonal Jobs)',
    'Income from Own Business/Informal Trade',
    'Livestock Sales',
    'Livestock Product Sales (Milk, Meat, Skins)',
    'Poultry Product Sales (Chickens, Eggs)',
    'Sale of Crops, Vegetables, Fruit, Seedlings',
    'Sale of Fish and Fish Products',
    'Sale of Wild Fruits',
    'Sale of Natural Products (Wood, Reeds, Grasses)',
    'Grants',
    'Cash Support from Family or Others',
    'Other (Specify)',
  ];
  static const List<String> grantList = [
    'Old Age Pension',
    'Private Pension',
    'Military Pension',
    'Orphans and Vulnerable Children Grant',
    'Civil Servants Pension',
    'Disability Allowance',
    'TEBA Grant'
  ];

  static const List<String> frequencyChoices = [
    notSelected,
    'Monthly',
    'Regularly, but not every month Occasionally',
    'Occasionally',
  ];

  static const List<String> householdGivingSupportChoices = [
    notSelected,
    'none',
    'Financial assistance',
    'Food',
    'Labour',
    'Care-giving',
  ];

  static const List<String> relationSupportedHouseholdChoices = [
    notSelected,
    '(Grand-)Parents',
    '(Grand-)Children',
    'Relatives',
    'Friend/Neighbour',
  ];
}
