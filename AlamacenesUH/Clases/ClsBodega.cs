using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Data;
using System.Linq;
using System.Web;

namespace AlamacenesUH.Clases
{
    public class ClsBodega
    {
        public int Id { get; set; }
        public string Bodega { get; set; }
        public string Producto { get; set; }
        public int Cantidad { get; set; }


        public static List<ClsBodega> bodegas = new List<ClsBodega>();
        public ClsBodega(int id)
        {
            Id = id;
        }

        public ClsBodega()
        {

        }


        public static List<ClsBodega> ReporteBodegas()
        {
            int retorno = 0;
            int tipoOperacion = 1;
            SqlConnection Conn = new SqlConnection();

            try
            {

                using (Conn = Clases.DBconn.obtenerConexion())
                {
                    SqlCommand cmd = new SqlCommand("Bodegas", Conn)
                    {
                        CommandType = CommandType.StoredProcedure
                    };
                    cmd.Parameters.Add(new SqlParameter("@operacion", tipoOperacion));
                    retorno = cmd.ExecuteNonQuery();
                    using (SqlDataReader reader = cmd.ExecuteReader())
                    {
                        while (reader.Read())
                        {
                            ClsBodega bodega = new ClsBodega();
                            bodega.Producto = reader.GetString(0);
                            bodega.Bodega = reader.GetString(1);
                            bodega.Cantidad = reader.GetInt32(2);

                            bodegas.Add(bodega);
                        }

                    }
                }
            }
            catch (System.Data.SqlClient.SqlException ex)
            {
                return bodegas;
            }
            finally
            {
                Conn.Close();
                Conn.Dispose();
            }

            return bodegas;
        }

        public static List<ClsBodega> ReporteBodegasFiltro(int id)
        {
            int retorno = 0;
            int tipoOperacion = 2;
            SqlConnection Conn = new SqlConnection();

            try
            {

                using (Conn = Clases.DBconn.obtenerConexion())
                {
                    SqlCommand cmd = new SqlCommand("Bodegas", Conn)
                    {
                        CommandType = CommandType.StoredProcedure
                    };
                    cmd.Parameters.Add(new SqlParameter("@id", id));
                    cmd.Parameters.Add(new SqlParameter("@operacion", tipoOperacion));
                    retorno = cmd.ExecuteNonQuery();
                    using (SqlDataReader reader = cmd.ExecuteReader())
                    {
                        while (reader.Read())
                        {
                            ClsBodega bodega = new ClsBodega();
                            bodega.Producto = reader.GetString(0);
                            bodega.Bodega = reader.GetString(1);
                            bodega.Cantidad = reader.GetInt32(2);

                            bodegas.Add(bodega);
                        }

                    }
                }
            }
            catch (System.Data.SqlClient.SqlException ex)
            {
                return bodegas;
            }
            finally
            {
                Conn.Close();
                Conn.Dispose();
            }

            return bodegas;
        }



        public static List<ClsBodega> ReporteBodegasFiltronombre(string nombre)
        {
            int retorno = 0;
            int tipoOperacion = 3;
            SqlConnection Conn = new SqlConnection();

            try
            {

                using (Conn = Clases.DBconn.obtenerConexion())
                {
                    SqlCommand cmd = new SqlCommand("Bodegas", Conn)
                    {
                        CommandType = CommandType.StoredProcedure
                    };
                    cmd.Parameters.Add(new SqlParameter("@nombre", nombre));
                    cmd.Parameters.Add(new SqlParameter("@operacion", tipoOperacion));
                    retorno = cmd.ExecuteNonQuery();
                    using (SqlDataReader reader = cmd.ExecuteReader())
                    {
                        while (reader.Read())
                        {
                            ClsBodega bodega = new ClsBodega();
                            bodega.Producto = reader.GetString(0);
                            bodega.Bodega = reader.GetString(1);
                            bodega.Cantidad = reader.GetInt32(2);

                            bodegas.Add(bodega);
                        }

                    }
                }
            }
            catch (System.Data.SqlClient.SqlException ex)
            {
                return bodegas;
            }
            finally
            {
                Conn.Close();
                Conn.Dispose();
            }

            return bodegas;
        }
    }
}