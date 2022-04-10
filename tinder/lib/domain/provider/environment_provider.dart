enum EnviromentFlavor {
  dev,
  verify,
  stg,
  prod,
}

abstract class EnviromentProvider {
  EnviromentFlavor getCurrentFlavor();
  setFlavor({required EnviromentFlavor flavor});
}
