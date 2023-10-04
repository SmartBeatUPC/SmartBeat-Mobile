enum Entorno { desa, desamac, qa, prod}

class Environment {

  static Entorno entorno = Entorno.qa;

  static Map<Entorno, String> apis = {
    Entorno.desa: 'http://10.0.2.2:8080',
    Entorno.desamac: 'http://localhost:8080',
    Entorno.qa: 'http://18.119.148.8:3000'
  };
  static String api = apis[entorno]!;
}
