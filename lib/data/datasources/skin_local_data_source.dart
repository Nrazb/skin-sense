import 'package:skin_sense/domain/entities/skin_analysis.dart';

/// Data hardcode sementara.
/// TODO: ganti dengan skin_remote_data_source.dart (HTTP/Dio) atau inferensi model.
class SkinLocalDataSource {
  const SkinLocalDataSource();

  Future<SkinAnalysis> getLatestAnalysis() async {
    await Future<void>.delayed(const Duration(milliseconds: 600));
    return const SkinAnalysis(
      scanWidthPx: 1280,
      dominantType: SkinType.oily,
      probabilities: {
        SkinType.oily: 0.62,
        SkinType.normal: 0.20,
        SkinType.dry: 0.18,
      },
      needs: SkinNeedProfile(oilControl: 53, hydration: 30, smoothness: 90),
      priorityNote: 'Prioritas Regulasi Sebum & Pori Bersih',
      meaning:
          'Kelenjar sebasea aktif menghasilkan sebum berlebih. Kondisi ini membuat kulit lebih rentan terhadap pori tersumbat dan kilap berlebih, namun memiliki keunggulan alami yaitu cenderung lebih lambat mengalami garis halus penuaan.',
      specialNote:
          'Karakteristik kulit kombinasi akan tercermin lebih spesifik pada profil kebutuhan Anda di tahap rekomendasi rutinitas.',
      morningRoutine: [
        RoutineStep(
          title: 'Gentle Gel Cleanser',
          description:
              'Pembersih lembut tanpa SLS untuk menjaga kelembapan alami',
        ),
        RoutineStep(
          title: 'Niacinamide Serum 5%',
          description:
              'Meredakan produksi sebum berlebih & mencerahkan warna kulit',
        ),
        RoutineStep(
          title: 'Oil-Free Gel Moisturizer',
          description:
              'Hidrasi ringan berbasis air tanpa memicu pori tersumbat',
        ),
        RoutineStep(
          title: 'Sunscreen SPF 50 PA++++',
          description:
              'Perlindungan UV dengan hasil matte non-greasy tahan lama',
        ),
      ],
      nightRoutine: [
        RoutineStep(
          title: 'Micellar Water / Cleansing Oil',
          description:
              'Double cleansing mengangkat residu tabir surya dan polutan',
        ),
        RoutineStep(
          title: 'BHA / Salicylic Acid 1-2% Exfoliant',
          description:
              'Eksfoliasi penetrasi ke dalam pori untuk mencegah timbulnya komedo',
          frequency: '2x Seminggu',
        ),
        RoutineStep(
          title: 'Calming Barrier Moisturizer',
          description:
              'Memperbaiki dan memperkuat skin barrier selama waktu istirahat',
        ),
      ],
      recommendedIngredients: [
        'Niacinamide',
        'Hyaluronic Acid',
        'Zinc PCA',
        'Centella Asiatica',
      ],
      avoidedIngredients: [
        'Alkohol Denat',
        'Parfum Sintetis',
        'Minyak Mineral Berat',
      ],
    );
  }
}
