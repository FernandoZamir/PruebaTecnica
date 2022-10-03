using Estudiante.Models;
using Estudiante.Service;
using Microsoft.AspNetCore.Mvc;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace Estudiante.Controllers
{
    public class NotaController : Controller
    {
        NotaService NotaServiceS = new NotaService();

        public IActionResult Index()
        {
            var nota = NotaServiceS.ListarNota();
            return View(nota);
        }

        [HttpPost]
        public string CrearActualizarNota(NotasViewModel nota)
        {
            var resp = NotaServiceS.CrearActualizarNota(nota);
            return resp;
        }
    }
}
