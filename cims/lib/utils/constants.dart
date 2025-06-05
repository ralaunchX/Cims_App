class AppConstants {
  static String devUrl = 'https://cims-dev-968023981384.us-east1.run.app/api';
  static const prodUrl = '';
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

  static const Map<int, String> wallMaterialOptions = {
    0: notSelected,
    1: 'Stick / Mud',
    2: 'Block / Stones',
    3: 'Natural Stone',
    4: 'Bricks with No Plaster',
    5: 'Bricks with Plaster',
    6: 'Mud Block',
    7: 'Corrugated Iron Sheets',
    8: 'Other',
  };

  static const Map<int, String> roofMaterialOptions = {
    0: notSelected,
    1: 'Thatch / Grass',
    2: 'Corrugated Iron',
    3: 'Tile',
    4: 'Other',
  };

  static const Map<int, String> floorMaterialOptions = {
    0: notSelected,
    1: 'Mud, Earth, Dung',
    2: 'Concrete, Cement',
    3: 'Tile/Carpet/Vinyl finish',
    4: 'Other',
  };

  static const Map<int, String> dwellingOwnership = {
    0: notSelected,
    1: 'Own',
    2: 'Rent',
  };

  static const Map<int, String> structuresServicesOptions = {
    1: 'Separate kitchen',
    2: 'Store/shed/barn',
    3: 'Latrine',
    4: 'Water in homestead',
    5: 'Electricity in homestead',
    6: 'Grain storage',
    7: 'Cattle/Smallstock kraal',
    8: 'Stable',
    9: 'Pig sty',
    10: 'Poultry coup',
    11: 'Bird shelter',
    0: 'None of these',
  };

  static const Map<int, String> otherStructuresOptions = {
    1: 'Malaene',
    2: 'Muk’huk’hu (temporary structure)',
    3: 'Shelter for animals',
    4: 'Shop or Business site',
    0: 'None of these',
  };

  static const Map<int, String> householdItemsOptions = {
    1: 'Lounge suite / couch / chairs',
    2: 'Dining room suite / table and chairs',
    3: 'Kitchen unit(s)/cupboards',
    4: 'Bed and mattress',
    5: 'Wardrobe/ Dresser',
    0: 'None of these',
  };

  static const Map<int, String> appliancesOptions = {
    1: 'Radio',
    2: 'Television',
    3: 'Refrigerator',
    4: 'Stove (gas, electric, coal, solar)',
    5: 'Paraffin cooker',
    6: 'Sewing machine',
    7: 'Heater (Gas, Electric, Paraffin etc)',
    8: 'Mobile phone',
    9: 'Tablet',
    10: 'Computer/Laptop',
    11: 'Generator',
    0: 'None of these',
  };

  static const Map<int, String> agriculturalEquipmentOptions = {
    1: 'Hand held implements (Hoe, harrow, spade, sickle, saw)',
    2: 'Animal-drawn plough or planter',
    3: 'Animal-drawn cart',
    4: 'Tractor',
    5: 'Tractor-drawn plough',
    6: 'Tractor-drawn planter',
    7: 'Tractor drawn wagon',
    8: 'Saddles and bridles',
    9: 'Wheelbarrow',
    10: 'Car',
    11: 'Truck',
    12: 'Van',
    13: 'Bicycle',
    0: 'None of these',
  };

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

  static const Map<int, String> frequencyChoicesMap = {
    0: notSelected,
    1: 'Monthly',
    2: 'Regularly, but not every month Occasionally',
    3: 'Occasionally',
  };

  static const Map<int, String> householdGivingSupportChoicesMap = {
    0: notSelected,
    99: 'none',
    1: 'Financial assistance',
    2: 'Food',
    3: 'Labour',
    4: 'Care-giving',
  };

  static const Map<int, String> relationSupportedHouseholdChoicesMap = {
    0: notSelected,
    1: '(Grand-)Parents',
    2: '(Grand-)Children',
    3: 'Relatives',
    4: 'Friend/Neighbour',
  };

  static const List<String> cropGrownHarvested = [
    notSelected,
    'Maize',
    'Wheat',
    'Sorghum',
    'Gars/Barley',
    'Beans',
    'Peas',
    'Rape Turnips',
    'Pumpkin',
    'Potatoes',
    'Dagga',
  ];
  static const List<String> foodGardenChoice = [
    notSelected,
    'Don\'t have a food garden',
    'Garden in homestead area',
    'Garden in communal area',
  ];

  static const List<String> cropUseChoices = [
    notSelected,
    'Household Food',
    'Selling',
    'Both Food and Selling',
    'Animal Feed',
    'Both Food and Animal Feed',
  ];

  static const List<String> irrigationMethods = [
    notSelected,
    'Not irrigated',
    'Irrigated by hand from site',
    'Irrigated by hand, carting water',
  ];

  static const List<String> fertilizationChoices = [
    notSelected,
    'Mostly manure',
    'Mostly compost',
    'Mostly fertilizers',
    'Combination of 1,2 and 3 above',
    'No fertilization',
  ];
  static const List<String> nonCultivationReasons = [
    notSelected,
    'Drought',
    'Lack of draught animals',
    'Lack of implements',
    'Lack of money to buy inputs (seed, etc.)',
    'Lack of labour',
  ];
  static const List<String> ownershipChoices = [
    notSelected,
    'Own field',
    'Rented',
    'Sharecropping',
    'Shared ownership',
    'Borrowed from another person (friend neighbour relative)',
  ];
  static const List<String> cultivationMethodChoices = [
    notSelected,
    'Own tractor',
    'Own cattle/donkeys',
    'Hired tractor',
    'Hired cattle/donkeys',
    'Government ploughing service',
    'Shared use of cattle/donkeys',
    'By hand',
    'None',
  ];
  static const List<String> seedChoices = [
    notSelected,
    'Kept seed (untreated)',
    'Kept and self-treated seed',
    'Purchased common seed',
    'Purchased special (hybrid/GMO) seed',
  ];
  static const List<String> treeTypes = [
    notSelected,
    'None',
    'Apple',
    'Apricot',
    'Peach',
    'Pear',
    'Prune',
    'Quinces',
    'Wild Grape',
    'Prickly Pear',
    'Wild Cherry',
    'Pomegranate',
  ];
  static const List<String> expenditureItems = [
    notSelected,
    'Food (staple)',
    'Personal Items (toiletries, washing powder, etc.)',
    'Transport (bus fares, taxi fees)',
    'School Fees',
    'Clothes',
    'Savings (bank, society)',
    'Burial Society/Insurance Scheme',
    'Household Energy (paraffin, gas, etc.)',
    'Airtime',
    'Water (Transport or Pumping Costs)',
    'Medical Expenses',
    'Furniture/household equipment',
    'Rental (housing/accommodation)',
    'Crops production and/or marketing',
    'Livestock production and/or marketing',
    'Other (specify)',
  ];
  static const List<String> frequencyOptionsExpenditure = [
    notSelected,
    'Monthly',
    'Quarterly (4 times a year)',
    'Annually (once or twice a year)',
    'Free Service – no expense',
  ];
  static const List<String> transportFrequency = [
    notSelected,
    'Once a day (leave in morning, return in evening)',
    'Twice a day (leave in morning and around midday)',
    'More frequently (regular trips on the same day)',
    'Not every day',
  ];
  static const List<String> transportModes = [
    notSelected,
    'Never used',
    'On foot',
    'On horseback/donkey',
    'Taxi (4+1)',
    'Minibus',
    'Vehicle for hire',
    'Own Motor Transport',
  ];

  static const List<String> fundingGroupChoices = [
    notSelected,
    'Self-selected group (Rotating Savings and Credit Association)',
    'Burial Society',
    'Savings and Credit Club',
  ];

  static const List<String> fundingFrequencyChoices = [
    notSelected,
    'Weekly',
    'Monthly',
    'Quarterly',
    'Annually',
    'On Rotation',
    'On Special Occasion',
  ];

  static const List<String> fundingIncomeSourceChoices = [
    notSelected,
    'Salary from employment',
    'Cash generated from informal economic activity',
    'Savings',
    'Social grant',
    'Gifted (cash from Family Member)',
  ];

  static const List<String> fundingLivelihoodContributionChoices = [
    notSelected,
    'Pay School Fees',
    'Acquire Assets such as livestock and farming equipment',
    'Pay for Health care',
    'Buy food, clothes',
    'Capital to start or expand an income-generating activity',
    'Pay for Burial Society Services',
  ];
  static const List<String> relationshipChoices = [
    notSelected,
    'Household Head (HH)',
    'Spouse',
    'Parent/Parent-in-Law',
    'Grandparent',
    'Son/daughter',
    'Son-in-law/daughter-in-law',
    'Grandchild',
    'Sibling',
    'Nephew/niece/cousin',
    'Adopted/foster/stepchild',
    'Non-related dependent',
    'Other relative',
    'Other (SPECIFY)',
  ];

  static const List<String> residentialStatusChoices = [
    notSelected,
    'This homestead',
    'This village',
    'This district',
    'Elsewhere in Lesotho',
    'Elsewhere outside Lesotho',
  ];

  static const List<String> educationLevelChoices = [
    notSelected,
    'No education',
    'Primary',
    'Junior Secondary (Form A – C)',
    'Senior Secondary (Form D – E)',
    'Technical/Vocational',
    'Tertiary',
  ];

  static const List<String> occupationChoices = [
    notSelected,
    'Working for remuneration, formally/informally',
    'Any form of self-employment',
    'Subsistence farming (Crop Farming, Livestock rearing)',
    'School-going/Youngster',
    'Unemployed (18 years or older)',
    'Retired from formal employment',
    'Homemaker/Housewife',
    'Domestic responsibilities',
    'Herdboy',
    'Pensioner',
    'Old and no longer economically active',
  ];

  static const List<String> disabilityChoices = [
    notSelected,
    'Physical (crippled e.g. arm, leg, hand, feet)',
    'Mental/intellectual (retarded, madness)',
    'Hearing/deafness',
    'Visual Impairment',
    'Multiple Disability',
  ];

  static const List<String> chronicIllnessChoices = [
    notSelected,
    'High blood pressure (Hypertension)',
    'High blood sugar (Diabetes)',
    'Heart (Cardio-vascular) disease',
    'Asthma (Chronic respiratory disease)',
    'Tuberculosis (TB)/HIV',
    'Arthritis',
    'Cancer',
    'Epilepsy',
  ];
  static const List<String> yesNoOption = [
    notSelected,
    'Yes',
    'No',
  ];

  static const List<String> schoolLevelChoices = [
    notSelected,
    'Pre-School',
    'Primary',
    'Junior Secondary (Form A – C)',
    'Senior Secondary (Form D – E)',
    'Technical/Vocational',
    'Tertiary',
    'Other (Specify)',
  ];

  static const List<String> nonAttendanceReasonChoices = [
    notSelected,
    'Not yet of school-going age',
    'Too far to walk',
    'Child does not like school',
    'Too expensive/Household too poor to afford education',
    'Child is needed to work',
    'Child is a girl, and she doesn’t need education',
    'Child is too ill to attend school',
    'Child is disabled',
    'Pregnant/child to care for',
    'Other (Specify)',
  ];
  static const List<String> employmentTypeChoices = [
    notSelected,
    'Regularly employed (full-time)',
    'Regularly employed (part-time)',
    'Irregularly employed (seasonal, casual, piece jobs)',
    'Regularly self-employed',
  ];

  static const List<String> employmentSectorChoices = [
    notSelected,
    'Agriculture (government/commercial farming sector fato- fato)',
    'Agriculture (subsistence farming including herders and Labourers, farmworkers)',
    'Public service (Government and Utilities)',
    'Education',
    'Mining and Quarrying',
    'Manufacturing and Processing',
    'Construction',
    'Wholesale and retail',
    'Repairs: motor vehicles/appliances',
    'Transport (goods, people)',
    'Hospitality (catering, accommodation)',
    'Communication (Telecommunications, newspapers, media)',
    'Financial and Insurance activities (Banks, insurance companies)',
    'Professional (doctors, lawyers), scientific (labs), and technical activities',
    'Administrative and clerical work (security services, legal)',
    'Human health and social work activities (nursing, health care workers, social workers)',
    'Arts, entertainment and recreation',
    'All domestic services (domestic workers, gardeners, child-minders)',
    'Personal Service (E.g. Hair and Beauty care, Tailoring Sewing , knitting)',
    'Don’t Know',
  ];

  static const List<String> employmentCategoryChoices = [
    notSelected,
    'Management',
    'Technical',
    'Admin/Clerical',
    'Labour/General Assistant',
    'Unskilled labour',
    'Don’t Know',
  ];

  static const List<String> placeOfWorkChoices = [
    notSelected,
    'This village',
    'Within the district',
    'Elsewhere in Lesotho',
    'Elsewhere outside Lesotho',
  ];
  static const List<String> unemploymentReasonChoices = [
    notSelected,
    'No longer actively searching for a job',
    'Could not find work in home district',
    'Could not find work outside the home district elsewhere in Lesotho',
    'Could not find work outside Lesotho',
    'Not able to work (e.g., disabled, chronically ill)',
    'Recently retrenched and have not found a new job yet',
  ];

  static const List<String> skillChoices = [
    notSelected,
    'Beer brewing',
    'Bookkeeping',
    'Child-minding',
    'Cooking/Baking/Hospitality services',
    'Hair and Beauty Care',
    'Hospice / Care Giving',
    'IT Computer Technology',
    'Marketing of services (e.g Public phones)',
    'Pottery',
    'Saddlery',
    'Selling / Hawking goods and produce',
    'Sewing / Tailoring',
    'Shoe Making / Leather craft',
    'Traditional medicine/pharmacy',
    'Weaving',
    'Bricklaying/Building/Stone Mason',
    'Brickmaking',
    'Cabinetmaker',
    'Painting',
    'Plastering',
    'Roofing/Carpentry',
    'Thatching',
    'Electrical repairs / Electrician',
    'Driving heavy vehicles',
    'Driving light vehicles',
    'Vehicle service and repair',
    'Plumbing',
    'Welding',
    'Application of livestock medicine and dosing',
    'Breeding and raising livestock',
    'Diagnosing and treating livestock',
    'Handling and herding livestock',
    'Crop production/growing',
    'Tractor driving',
    'Tree-felling',
    'Vegetable growing',
  ];

  static const List<String> skillAcquisitionChoices = [
    notSelected,
    'Acquired on the job as employee',
    'Acquired through formal training',
    'Self-taught: acquired from seeing others doing the same thing or learned it by “trial and error”',
    'Acquired as part of household/domestic responsibilities',
  ];

  static const List<String> incomeEarningChoices = [
    notSelected,
    'No, not at present',
    'Yes, occasionally',
    'Yes, regularly',
  ];

  static const List<String> literacyLevelChoices = [
    notSelected,
    'Cannot read or write',
    'Read and write Sesotho',
    'Read and write English',
    'Read and write Sesotho and English',
    'Can read and write and is also Computer Literate',
  ];
  static const List<String> businessTypeChoices = [
    notSelected,
    'Beer brewing/shebeen',
    'Bricklaying/Building/Stone Mason',
    'Appliance service and repair (electronics)',
    'Hire of draught animals (e.g., oxen/donkey)',
    'Bookkeeping',
    'Electrical repairs',
    'Hire of riding horse',
    'Cabinetmaker',
    'Brickmaking',
    'Painting',
    'Motorised Transport/haulage',
    'Sale of natural resources (raw material e.g., reeds, thatch grass)',
    'Plastering',
    'Plumbing',
    'Tractor hire services (ploughing, haulage)',
    'Hair and Beauty care',
    'Roofing/Carpentry',
    'Vehicle service and repair',
    'IT/Computer technology',
    'Marketing of services (e.g., public phones)',
    'Pottery',
    'Saddlery',
    'Selling/Hawking of soft goods and produce',
    'Sewing/Tailoring',
    'Shoe-making/Leather craft',
    'Spaza/café/small retailer',
    'Traditional healer/Pharmacy',
    'Weaving',
  ];

  static const List<String> positionInBusinessChoices = [
    notSelected,
    'Owner of the small/informal business',
    'Assistant to the owner',
    'Don’t know',
  ];

  static const List<String> useOfIncomeChoices = [
    notSelected,
    'Only for his/her personal use',
    'Used directly for the Household',
    'For personal use and sharing with Household',
    'Don’t know',
  ];
  static const List<String> stapleFoodOptions = [
    notSelected,
    'Maize',
    'Wheat',
    'Sorghum'
  ];
  static const List<String> sourceOptions = [
    notSelected,
    'Own produced staple',
    'Mostly bought'
  ];
  static const List<String> months = [
    'January',
    'February',
    'March',
    'April',
    'May',
    'June',
    'July',
    'August',
    'September',
    'October',
    'November',
    'December'
  ];

  static const List<String> hungerReasons = [
    "Could not produce enough food",
    "No money to buy food",
    "Not enough land to produce food",
    "Not enough labour to help produce food",
    "Natural calamities (e.g., bushfire, drought, pests)",
    'None'
  ];

  static const List<String> stapleStorageOptions = ["As Grain", "On Cobs"];
  static const List<String> sideDishSourceOptions = [
    "Own produced side dish",
    "Mostly bought side dish",
  ];
}
