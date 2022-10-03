using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace Estudiante.Models
{
    public class NotasViewModel
    {
        public int idNota { get; set; }
        public string idEstudiante { get; set; }
        public string idMateria { get; set; }
        public decimal nota { get; set; }
        //public EstudianteViewModel primerNombre { get; set; }
        //public EstudianteViewModel PrimerApellido { get; set; }
        public string fechaRegistro { get; set; }
    }
}
