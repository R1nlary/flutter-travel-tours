import '../models/tour.dart';

const tours = [
  Tour(
    id: 1,
    title: 'Norway Fjord Cruise',
    location: 'Stavanger, Norway',
    description:
        'Sail between steep mountains and deep blue water. The trip includes '
        'a boat cruise, a hike to the viewpoint and a local lunch.',
    image: 'assets/images/fjord.jpg',
    category: 'Sea',
    price: 650,
    rating: 4.8,
    days: 4,
    tags: ['Boat', 'Viewpoint', 'Lunch included'],
  ),
  Tour(
    id: 2,
    title: 'Forest Waterfall Hike',
    location: 'Oregon, USA',
    description:
        'A one-day hike through a green forest to a huge waterfall. '
        'Suitable for beginners, a guide and a picnic are included.',
    image: 'assets/images/waterfall.jpg',
    category: 'Hiking',
    price: 120,
    rating: 4.6,
    days: 1,
    tags: ['Beginners', 'Guide', 'Picnic'],
  ),
  Tour(
    id: 3,
    title: 'Bavarian Castle Tour',
    location: 'Bavaria, Germany',
    description:
        'Visit a fairytale castle on a hill, walk around the old town and '
        'taste traditional food. Transport from the city is included.',
    image: 'assets/images/castle.jpg',
    category: 'City',
    price: 210,
    rating: 4.7,
    days: 2,
    tags: ['History', 'Food', 'Transport'],
  ),
  Tour(
    id: 4,
    title: 'Himalaya Winter Camp',
    location: 'Nepal',
    description:
        'Three days in a snow camp near the high mountains. Warm tents, '
        'hot meals and an experienced mountain guide.',
    image: 'assets/images/camp.jpg',
    category: 'Mountains',
    price: 890,
    rating: 4.9,
    days: 3,
    tags: ['Snow', 'Tents', 'Mountain guide'],
  ),
  Tour(
    id: 5,
    title: 'Highlands Road Trip',
    location: 'Scotland, UK',
    description:
        'Drive along winding roads between green cliffs and misty hills. '
        'You get a car, a route with the best stops and cozy hotels.',
    image: 'assets/images/highlands.jpg',
    category: 'Road trip',
    price: 480,
    rating: 4.5,
    days: 5,
    tags: ['Car', 'Hotels', 'Photo stops'],
  ),
  Tour(
    id: 6,
    title: 'Valley Camping Weekend',
    location: 'Yosemite, USA',
    description:
        'Two nights by the river under tall pine trees. Tents, a campfire '
        'dinner and a morning walk to the rocks are included.',
    image: 'assets/images/valley.jpg',
    category: 'Hiking',
    price: 160,
    rating: 4.4,
    days: 2,
    tags: ['Campfire', 'River', 'Tents'],
  ),
];
