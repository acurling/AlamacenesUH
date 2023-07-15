using AlamacenesUH.Clases;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace AlamacenesUH
{
    public partial class FrmClientes : System.Web.UI.Page
    {
        List<ClsCliente> clientes = ClsCliente.ObtenerClientes();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                CargarClientes();
            }
            else
            {

            }


        }

        private void CargarClientes()
        {

            repeaterClientes.DataSource = clientes;
            repeaterClientes.DataBind();
        }

        public void alertas(String texto)
        {
            string message = texto;
            System.Text.StringBuilder sb = new System.Text.StringBuilder();
            sb.Append("<script type = 'text/javascript'>");
            sb.Append("window.onload=function(){");
            sb.Append("alert('");
            sb.Append(message);
            sb.Append("')};");
            sb.Append("</script>");
            ClientScript.RegisterClientScriptBlock(this.GetType(), "alert", sb.ToString());

        }

        public void LimpiarCampos()
        {
            tnombre.Text = string.Empty;
            tdireccion.Text = string.Empty;
            ttelefono.Text = string.Empty;
        }
        protected void BAgregar_Click(object sender, EventArgs e)
        {
            int resultado = ClsCliente.AgregarClientes(tnombre.Text, tdireccion.Text, ttelefono.Text);

            if (resultado > 0)
            {
                alertas("USuario ha sido ingresado con exito");
                LimpiarCampos();
                CargarClientes();
            }
            else
            {
                alertas("Error al ingresar Usuario");
            }

           
        }

        protected void BBorrar_Click(object sender, EventArgs e)

        {
            String codigo = tcodigo.Text.Trim();
            int resultado = ClsCliente.BorrarClientes(codigo);

            if (resultado > 0)
            {
                alertas("Usuario ha sido borrado con exito");
                LimpiarCampos();
                CargarClientes();
            }
            else
            {
                alertas("Error al ingresar Usuario");
            }
        }
    }
}