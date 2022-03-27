String? validateFormEmptyText(String? value) {
  if (value != null && value.isEmpty) {
    return 'O campo não pode ser vazio';
  }
  return null;
}

String? validateFormQuantity(String? value) {
  final quantity = int.tryParse(value!) ?? 0;
  if (quantity == 0 || quantity > 1000) {
    return 'Informe um valor entre 1 e 1000';
  }
  return null;
}
