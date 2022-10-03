using Estudiante.Service;
using Microsoft.AspNetCore.Mvc;
using Estudiante.Models;

namespace Estudiante.Controllers
{
    public class EstudianteController : Controller
    {
        EstudianteService EstudianteServiceS = new EstudianteService();
        public IActionResult Index()
        {
            var estudiante = EstudianteServiceS.ListarEstudiante();
            return View(estudiante);
        }

        [HttpPost]
        public string CrearActualizar(EstudianteViewModel estudiante)
        {
            var resp = EstudianteServiceS.CrearActualizarEstudiante(estudiante);
            return resp;
        }
    }
}
