import '../models/food_item.dart';

const canteenMenu = <FoodItem>[
  FoodItem(
    id: 'nasi-goreng',
    name: 'Nasi Goreng',
    description:
        'Nasi goreng hangat dengan telur, sayuran segar, dan taburan bawang '
        'goreng. Dibuat setelah dipesan agar tetap nikmat.',
    price: 12000,
    imagePath: 'assets/images/nasi_goreng.png',
    category: 'Makanan berat',
    tagline: 'Favorit semua orang',
  ),
  FoodItem(
    id: 'mie-ayam',
    name: 'Mie Ayam',
    description:
        'Mie kenyal dengan potongan ayam berbumbu, sawi hijau, dan kuah '
        'gurih yang pas untuk teman istirahat.',
    price: 10000,
    imagePath: 'assets/images/mie_ayam.png',
    category: 'Makanan berat',
    tagline: 'Hangat dan gurih',
  ),
  FoodItem(
    id: 'roti-bakar',
    name: 'Roti Bakar Cokelat',
    description:
        'Roti panggang renyah dengan isian cokelat yang lumer. Pas untuk '
        'camilan di sela pelajaran.',
    price: 8000,
    imagePath: 'assets/images/roti_bakar.png',
    category: 'Camilan',
    tagline: 'Manisnya bikin semangat',
  ),
  FoodItem(
    id: 'bakso',
    name: 'Bakso Kuah',
    description:
        'Bakso daging dengan kuah kaldu hangat, bihun, dan seledri. '
        'Tersedia dengan sambal sesuai selera.',
    price: 11000,
    imagePath: 'assets/images/bakso.png',
    category: 'Makanan berat',
    tagline: 'Kuah kaldu hangat',
  ),
  FoodItem(
    id: 'es-teh',
    name: 'Es Teh Manis',
    description:
        'Teh melati yang diseduh segar dan disajikan dingin. Teman yang '
        'menyegarkan untuk makan siang.',
    price: 4000,
    imagePath: 'assets/images/es_teh.png',
    category: 'Minuman',
    tagline: 'Segar setiap saat',
  ),
  FoodItem(
    id: 'pisang-goreng',
    name: 'Pisang Goreng',
    description:
        'Pisang pilihan berbalut adonan tipis yang digoreng hingga keemasan. '
        'Enak dinikmati selagi hangat.',
    price: 6000,
    imagePath: 'assets/images/pisang_goreng.png',
    category: 'Camilan',
    tagline: 'Garing di luar, lembut di dalam',
  ),
];
