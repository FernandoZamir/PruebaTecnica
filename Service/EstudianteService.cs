using CrudEstudiante.Conexion;
using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using Estudiante.Models;

namespace Estudiante.Service
{
    public class EstudianteService
    {
        public List<EstudianteViewModel> ListarEstudiante()
        {
            var estudiante = new List<EstudianteViewModel>();
            var consultaSql = new Conexion();

            Dictionary<string, string> datosDiccionario = new Dictionary<string, string>(){
                {"op", "LISTAR_ESTUDIANTE" }
            };

            var dataConsulta = consultaSql.EjecutarConsulta("sp_estudiante", datosDiccionario);

            if (dataConsulta.Rows.Count > 0) {
                for (int i = 0; i < dataConsulta.Rows.Count; i++)
                {
                    estudiante.Add(new EstudianteViewModel()
                    {
                        identificacion = Convert.ToString(dataConsulta.Rows[i]["identificacion"]),
                        primerNombre = Convert.ToString(dataConsulta.Rows[i]["primer_nombre"]),
                        segundoNombre = Convert.ToString(dataConsulta.Rows[i]["segundo_nombre"]),
                        primerApellido = Convert.ToString(dataConsulta.Rows[i]["primer_apellido"]),
                        segundoApellido = Convert.ToString(dataConsulta.Rows[i]["segundo_apellido"]),
                        fechaNacimiento = Convert.ToString(dataConsulta.Rows[i]["fecha_nacimiento"]),
                        genero = Convert.ToBoolean(dataConsulta.Rows[i]["genero"]),
                        tipoSangre = Convert.ToInt16(dataConsulta.Rows[i]["tipo_sangre"]),
                        residencia = Convert.ToString(dataConsulta.Rows[i]["residencia"]),
                        email = Convert.ToString(dataConsulta.Rows[i]["email"]),
                        telefonoRepresentante = Convert.ToString(dataConsulta.Rows[i]["telefono_representante"]),
                        estado = Convert.ToBoolean(dataConsulta.Rows[i]["estado"])
                    });
                }
            }
            return estudiante;
        }
        
        public string CrearActualizarEstudiante(EstudianteViewModel estudiante)
        {
            var consultaSql = new Conexion();
            Dictionary<string, string> datosDiccionario = new Dictionary<string, string>(){
                {"op", "GUARDAR_ESTUDIANTE" },
                {"identificacion", estudiante.identificacion.ToString() },
                {"primer_nombre", estudiante.primerNombre.ToString() },
                {"segundo_nombre", estudiante.segundoNombre.ToString() },
                {"primer_apellido", estudiante.primerApellido.ToString() },
                {"segundo_apellido", estudiante.segundoApellido.ToString() },
                {"fecha_nacimiento", estudiante.fechaNacimiento.ToString() },
                {"genero", estudiante.genero.ToString() },
                {"tipo_sangre", estudiante.tipoSangre.ToString() },
                {"residencia", estudiante.residencia.ToString() },
                {"email", estudiante.email.ToString() },
                {"telefono_representante", estudiante.telefonoRepresentante.ToString() },
                {"estado", estudiante.estado.ToString() },
                {"transaccion", "1" }
            };
            var dataConsulta = consultaSql.EjecutarConsulta("sp_estudiante", datosDiccionario);
            return JsonConvert.SerializeObject(dataConsulta);
        }
    }
}
