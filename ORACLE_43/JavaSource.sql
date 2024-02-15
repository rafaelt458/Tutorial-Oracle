create or replace and compile JAVA SOURCE
NAMED Comunicar AS

    public class Comunicar {
        public static String saludar(String nombre) {
            return "Hola desde Java " + nombre;
        }
        
        public static String despedirse(String nombre) {
            return "Adios desde Java " + nombre;
        }
    }
;