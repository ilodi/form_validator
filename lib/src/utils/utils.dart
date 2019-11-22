bool isNumeric(String s){


if (s.isEmpty)return false;
//SE puede hacer un numero
final n = num.tryParse(s);

return (n == null) ? false : true;
}