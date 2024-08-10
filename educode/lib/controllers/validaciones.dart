class Validacion {
  //CORREO
  String? validacionCorreo(String? textoValidar) {
    if (textoValidar == null || textoValidar.isEmpty) {
      return 'El correo es obligatorio';
    }
    if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(textoValidar)) {
      return 'Ingrese un correo válido';
    }
    if (!textoValidar.endsWith('unah.hn') && !textoValidar.endsWith('unah.edu.hn')) {
      return 'Ingrese un correo válido que termine en .unah.hn o .unah.edu.hn';
    }
    return null;
  }
  //CONTRASEÑA
  String? validacionPassword(String? textoValidar) {
    if (textoValidar == null || textoValidar.isEmpty) {
      return 'La contraseña es obligatoria';
    }
    if (textoValidar.length < 8) {
      return 'La contraseña debe tener al menos 8 caracteres';
    }
    return null;
  }
  //NOMBRE
  String? validacionNombre(String? textoValidar) {
    if (textoValidar == null || textoValidar.isEmpty) {
      return 'El nombre es obligatoria';
    }
    return null;
  }
  //APELLIDO
   String? validacionApellido(String? textoValidar) {
    if (textoValidar == null || textoValidar.isEmpty) {
      return 'El nombre es obligatoria';
    }
    return null;
  }
  
}
