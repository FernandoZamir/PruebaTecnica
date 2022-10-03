namespace Estudiante.Models
{
    public class EstudianteViewModel
    {
        // public int idEstudiante { get; set; }
        public string identificacion { get; set; }
        public string primerNombre { get; set; }
        public string segundoNombre { get; set; }
        public string primerApellido { get; set; }
        public string segundoApellido { get; set; }
        public int tipoSangre { get; set; }
        public bool genero { get; set; }
        public string residencia { get; set; }  
        public string fechaNacimiento { get; set; }
        public string email { get; set; }
        public string telefonoRepresentante { get; set; }
        public bool estado { get; set; }
    }
}
