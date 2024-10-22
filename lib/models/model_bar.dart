class ComponentsIndividualBar {
  final int x;
  final double totalNutrition;
  const ComponentsIndividualBar({
    required this.x,
    required this.totalNutrition,
  });
}

class Bar {
  final List<double> totalNutritions;

  Bar({
    required this.totalNutritions,
  }) {
    if (totalNutritions.length < 7) {
      totalNutritions.addAll(List.filled(7 - totalNutritions.length, 0));
    }
  }

  List<ComponentsIndividualBar> dataBar = [];

  void initialDataBar() {
    if (totalNutritions.isEmpty) {
      throw StateError("TotalNutritions list is empty.");
    }

    int startValue = 1;

    if (totalNutritions.length > 7) {
      startValue = totalNutritions.length - 11;
    }

    int offset = startValue - 1;

    for (int i = 0; i < 7; i++) {
      int dataIndex = offset + i;
      if (dataIndex < totalNutritions.length) {
        dataBar.add(
          ComponentsIndividualBar(
            x: dataIndex + 1,
            totalNutrition: totalNutritions[dataIndex],
          ),
        );
      } else {
        dataBar.add(
          ComponentsIndividualBar(
            x: i + 1,
            totalNutrition: 0,
          ),
        );
      }
    }
  }
}
