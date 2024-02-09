abstract class ModelAdapter<Model, External> {
  Model toModel(External external);

  External fromModel(Model model);

  List<Model> toListModel(List<External> external) {
    return external.map<Model>((e) => toModel(e)).toList();
  }

  List<External> fromListModel(List<Model> models) {
    return models.map<External>((e) => fromModel(e)).toList();
  }
}