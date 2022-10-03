using CrudEstudiante.Conexion;
using Estudiante.Models;
using Newtonsoft.Json;
using System;
using System.Collections.Generic;

namespace Materia.Service
{
    public class MateriaService
    {
        public List<MateriaViewModel> ListarMateria()
        {
            var materia = new List<MateriaViewModel>();
            var consultaSql = new Conexion();

            Dictionary<string, string> datosDiccionario = new Dictionary<string, string>(){
                {"op", "LISTAR_MATERIA" }
            };

            var dataConsulta = consultaSql.EjecutarConsulta("sp_materia", datosDiccionario);

            if (dataConsulta.Rows.Count > 0) {
                for (int i = 0; i < dataConsulta.Rows.Count; i++)
                {
                    materia.Add(new MateriaViewModel()
                    {
                        idMateria = Convert.ToInt32(dataConsulta.Rows[i]["id_materia"]),
                        titulo = Convert.ToString(dataConsulta.Rows[i]["titulo"]),
                        descripcion = Convert.ToString(dataConsulta.Rows[i]["descripcion"]),
                        fechaRegistro = Convert.ToString(dataConsulta.Rows[i]["fecha_creado"]),
                        estado = Convert.ToBoolean(dataConsulta.Rows[i]["estado"])
                    });
                }
            }      
            return materia;
        }
        
        public string CrearActualizarMateria(MateriaViewModel Materia)
        {
            var consultaSql = new Conexion();
            Dictionary<string, string> datosDiccionario = new Dictionary<string, string>(){
                {"op", "GUARDAR_MATERIA" },
                {"id_materia", Materia.idMateria.ToString() },
                {"titulo", Materia.titulo.ToString() },
                {"descripcion", Materia.descripcion.ToString() },
                {"estado", Materia.estado.ToString() },
                {"transaccion", "1" }
            };

            var dataConsulta = consultaSql.EjecutarConsulta("sp_materia", datosDiccionario);
            return JsonConvert.SerializeObject(dataConsulta);
        }
    }
}
