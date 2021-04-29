class CategoryModel {
  String categoryName = '';
  // CategoryModel(this.categoryName);
}

List<CategoryModel> getCategory() {
  List<CategoryModel> myCategories = [];
  CategoryModel categoryModel;

  categoryModel = new CategoryModel();
  categoryModel.categoryName = 'General';
  myCategories.add(categoryModel);

  categoryModel = new CategoryModel();
  categoryModel.categoryName = 'Entertainment';
  myCategories.add(categoryModel);

  categoryModel = new CategoryModel();
  categoryModel.categoryName = 'Business';
  myCategories.add(categoryModel);

  categoryModel = new CategoryModel();
  categoryModel.categoryName = 'Health';
  myCategories.add(categoryModel);

  categoryModel = new CategoryModel();
  categoryModel.categoryName = 'Science';
  myCategories.add(categoryModel);

  categoryModel = new CategoryModel();
  categoryModel.categoryName = 'Sports';
  myCategories.add(categoryModel);

  categoryModel = new CategoryModel();
  categoryModel.categoryName = 'Technology';
  myCategories.add(categoryModel);

  return myCategories;
}
