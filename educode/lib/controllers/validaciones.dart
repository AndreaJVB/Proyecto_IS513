class Validacion {
  

   String? validacionCorreo (textoValidar){
       if (textoValidar == null || textoValidar.isEmpty) {
                return 'El correo es obligatorio';
              }
              if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(textoValidar) ||
                  !textoValidar.endsWith('unah.hn')) {
                return 'Ingrese un correo válido que termine en .edu.hn';
              }
              return null;
            }
   }
   
