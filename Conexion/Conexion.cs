using Microsoft.Extensions.Configuration;
using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.IO;

namespace CrudEstudiante.Conexion
{
    public class Conexion
    {
        private static SqlConnection instancia = null;

        public Conexion()
        {
            //var builderConexion = new ConfigurationBuilder().SetBasePath(Directory.GetCurrentDirectory()).AddJsonFile("appsettings.json").Build();
            //stringSql = builderConexion.GetSection("ConnectionStrings:samtel").Value;
        }

        //private SqlConnection ObtenerCadenaSql()
        //{
        //    var builderConexion = new ConfigurationBuilder().SetBasePath(Directory.GetCurrentDirectory()).AddJsonFile("appsettings.json").Build(); 
        //    string stringSqlCadena = builderConexion.GetSection("ConnectionStrings:samtel").Value;
        //    stringSql2 = new SqlConnection(stringSqlCadena);
        //    return stringSql2;
        //}

        // Ejecutamos cualquier tipo de consulta y devolvemos un JSON de respuesta
        public DataTable EjecutarConsulta(string spNombre, Dictionary<String, String> parametros)
        {
            //string cadenaSql = ObtenerCadenaSql();

            DataTable table = new DataTable();
            try
            {              
                instancia = new SqlConnection();
                var builder = new ConfigurationBuilder().SetBasePath(Directory.GetCurrentDirectory()).AddJsonFile("appsettings.json").Build();
                instancia.ConnectionString = builder.GetSection("ConnectionStrings:samtel").Value;

                instancia.Open();
                string sql = $"EXEC {spNombre}";

                SqlCommand cmd = new SqlCommand
                {
                    CommandText = spNombre,
                    CommandType = CommandType.StoredProcedure,
                    Connection = instancia
                };

                foreach (KeyValuePair<String, String> item in parametros)
                {
                    cmd.Parameters.AddWithValue(item.Key, item.Value);
                    sql += $"@{item.Key}={item.Value}, ";
                }

                SqlDataReader reader = cmd.ExecuteReader();

                if (reader.HasRows)
                {
                    // Se puede mejorar construllendo un dt mas especifico
                    //while (reader.Read())
                    //{
                    //    Console.WriteLine("{0}\t{1}", reader.GetInt32(0),
                    //        reader.GetString(1));
                    //}

                    table.Load(reader);
                }
                else
                {
                    Console.WriteLine("No hay datos en la consulta.");
                }
                reader.Close();
                instancia.Close();
            }
            catch (Exception e)
            {
                Console.WriteLine("Error generado en consulta: ", e.Message);
                //json = "{'tipo_error': " + e.Message + " }";
            }
            Console.WriteLine(JsonConvert.SerializeObject(table));
            return table;
        }
    }
}
