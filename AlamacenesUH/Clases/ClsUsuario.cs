using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Data;
using System.Linq;
using System.Web;
using System.Runtime.Remoting.Messaging;

namespace AlamacenesUH.Clases
{
    public class ClsUsuario
    {
		private string usuario;

		public string Usuario
		{
			get { return Usuario; }
			set { Usuario = value; }
		}


		private string clave;

		public string Clave
		{
			get { return clave; }
			set { clave = value; }
		}


        public static int ConsultarUsuario( string usuario, string clave)
        {
            int retorno = 0;
         
            SqlConnection Conn = new SqlConnection();

            try
            {

                using (Conn = Clases.DBconn.obtenerConexion())
                {
                    SqlCommand cmd = new SqlCommand("DesEncriptarClave", Conn)
                    {
                        CommandType = CommandType.StoredProcedure
                    };
                    cmd.Parameters.Add(new SqlParameter("@Correo", usuario));
                    cmd.Parameters.Add(new SqlParameter("@CLAVE", clave));
                    retorno = cmd.ExecuteNonQuery();
                    using (SqlDataReader reader = cmd.ExecuteReader())
                    {
                        if (reader.Read())
                        {
                            retorno = reader.GetInt32(0);
                        }

                    }
                }
            }
            catch (System.Data.SqlClient.SqlException ex)
            {
                return 0;
            }
            finally
            {
                Conn.Close();
                Conn.Dispose();
            }

            return retorno;
        }

    }
}