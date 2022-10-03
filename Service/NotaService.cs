using CrudEstudiante.Conexion;
using Estudiante.Models;
using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace Estudiante.Service
{
    public class NotaService
    {
        public List<NotasViewModel> ListarNota()
        {
            var nota = new List<NotasViewModel>();
            var consultaSql = new Conexion();

            Dictionary<string, string> datosDiccionario = new Dictionary<string, string>(){
                {"op", "LISTAR_NOTA" }
            };

            var dataConsulta = consultaSql.EjecutarConsulta("sp_nota", datosDiccionario);

            if (dataConsulta.Rows.Count > 0)
            {
                for (int i = 0; i < dataConsulta.Rows.Count; i++)
                {
                    nota.Add(new NotasViewModel()
                    {
                        idNota = Convert.ToInt32(dataConsulta.Rows[i]["id_nota"]),
                        idEstudiante = Convert.ToString(dataConsulta.Rows[i]["fk_id_estudiante"]),
                        idMateria = Convert.ToString(dataConsulta.Rows[i]["fk_id_materia"]),
                        nota = Convert.ToDecimal(dataConsulta.Rows[i]["nota"]),
                    });
                }
            }
            return nota;
        }

        public string CrearActualizarNota(NotasViewModel Nota)
        {
            var consultaSql = new Conexion();
            Dictionary<string, string> datosDiccionario = new Dictionary<string, string>(){
                {"op", "GUARDAR_NOTA" },
                {"id_nota", Nota.idNota.ToString() },
                {"id_estudiante", Nota.idEstudiante.ToString() },
                {"id_materia", Nota.idMateria.ToString() },
                {"nota", Nota.nota.ToString() },
                {"transaccion", "1" }
            };

            var dataConsulta = consultaSql.EjecutarConsulta("sp_nota", datosDiccionario);
            return JsonConvert.SerializeObject(dataConsulta);
        }
    }
}
