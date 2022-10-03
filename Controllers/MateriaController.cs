using Materia.Service;
using Estudiante.Models;
using Microsoft.AspNetCore.Mvc;

namespace Materia.Controllers
{
    public class MateriaController : Controller
    {
        MateriaService MateriaServiceS = new MateriaService();

        public IActionResult Index()
        {
            var Materias = MateriaServiceS.ListarMateria();
            return View(Materias);
        }

        [HttpPost]
        public string CrearActualizar(MateriaViewModel materia)
        {
            var resp = MateriaServiceS.CrearActualizarMateria(materia);
            return resp;
        }
    }
}
