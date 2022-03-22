String? validateFormEmptyText(String? value) {
  if (value != null && value.isEmpty) {
    return 'O campo não pode ser vazio';
  }
  return null;
}

String? validateFormQuantity(String? value) {
  final quantity = int.tryParse(value!) ?? 0;
  if (quantity == 0 || quantity > 100) {
    return 'Informe um valor entre 1 e 100';
  }
  return null;
}
