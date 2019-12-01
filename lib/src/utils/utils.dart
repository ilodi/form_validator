bool isNumeric(String s){


if (s.isEmpty)return false;
//se puede hacer un numero
final n = num.tryParse(s);

return (n == null) ? false : true;
}