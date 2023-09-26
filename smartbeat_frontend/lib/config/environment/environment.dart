enum Entorno { desa, desamac, qa, prod}

class Environment {

  static Entorno entorno = Entorno.desa;

  static Map<Entorno, String> apis = {
    Entorno.desa: 'http://18.119.148.8:3000',
    Entorno.desamac: 'http://localhost:8080',
    Entorno.qa: ''
  };
  static String api = apis[entorno]!;
}
