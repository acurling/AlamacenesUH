using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Data;
using System.Linq;
using System.Web;
using System.Runtime.CompilerServices;

namespace AlamacenesUH.Clases
{
    public class ClsCliente
    {
        public int id { get; set; }
        public string nombre { get; set; }
        public string direccion { get; set; }
        public string telefono { get; set; }
        private static int tipoOperacion =0;

       public static List<ClsCliente> clientes = new List<ClsCliente>();    
        public ClsCliente(int id, string nombre, string direccion, string telefono)
        {
            this.id = id;
            this.nombre = nombre;
            this.direccion = direccion;
            this.telefono = telefono;
        }
        public ClsCliente()
        {

        }

        public static int AgregarClientes( string nombre, string direccion, string telefono)
        {
            int retorno = 0;
            tipoOperacion = 1;
            SqlConnection Conn = new SqlConnection();
            try
            {
                using (Conn = Clases.DBconn.obtenerConexion())
                {
                    SqlCommand cmd = new SqlCommand("Sp_GestionarCliente", Conn)
                    {
                        CommandType = CommandType.StoredProcedure
                    };
                    cmd.Parameters.Add(new SqlParameter("@Operacion", tipoOperacion));
                    cmd.Parameters.Add(new SqlParameter("@ID", 0));
                    cmd.Parameters.Add(new SqlParameter("@Nombre", nombre));
                    cmd.Parameters.Add(new SqlParameter("@Direccion", direccion));
                    cmd.Parameters.Add(new SqlParameter("@Telefono", telefono));

                    retorno = cmd.ExecuteNonQuery();
                }
            }
            catch (System.Data.SqlClient.SqlException ex)
            {
                retorno = -1;
            }
            finally
            {
                Conn.Close();
            }

            return retorno;
        }


        public static int BorrarClientes(string codigo)
        {
            int retorno = 0;
            tipoOperacion = 2;
            SqlConnection Conn = new SqlConnection();
            try
            {
                using (Conn = Clases.DBconn.obtenerConexion())
                {
                    SqlCommand cmd = new SqlCommand("Sp_GestionarCliente", Conn)
                    {
                        CommandType = CommandType.StoredProcedure
                    };
                    cmd.Parameters.Add(new SqlParameter("@Operacion", tipoOperacion));
                    cmd.Parameters.Add(new SqlParameter("@ID", codigo));


                    retorno = cmd.ExecuteNonQuery();
                }
            }
            catch (System.Data.SqlClient.SqlException ex)
            {
                retorno = -1;
            }
            finally
            {
                Conn.Close();
            }

            return retorno;
        }


        public static List<ClsCliente> ObtenerClientes()
        {
            int retorno = 0;
            tipoOperacion = 4;
            SqlConnection Conn = new SqlConnection();

            try
            {

                using (Conn =Clases.DBconn.obtenerConexion())
                {
                    SqlCommand cmd = new SqlCommand("Sp_GestionarCliente ", Conn)
                    {
                        CommandType = CommandType.StoredProcedure
                    };
                    cmd.Parameters.Add(new SqlParameter("@Operacion", tipoOperacion));
                    retorno = cmd.ExecuteNonQuery();
                    using (SqlDataReader reader = cmd.ExecuteReader())
                    {
                        while (reader.Read())
                        {
                            ClsCliente cliente = new ClsCliente();
                            cliente.id = reader.GetInt32(0);
                            cliente.nombre = reader.GetString(1);
                            cliente.direccion = reader.GetString(2);
                            cliente.telefono = reader.GetString(3);
                            clientes.Add(cliente);
                        }

                    }
                }
            }
            catch (System.Data.SqlClient.SqlException ex)
            {
                return clientes;
            }
            finally
            {
                Conn.Close();
                Conn.Dispose();
            }

            return clientes;
        }


    }
}