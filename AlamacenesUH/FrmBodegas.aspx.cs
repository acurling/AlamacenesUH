using AlamacenesUH.Clases;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace AlamacenesUH
{
    public partial class FrmBodegas : System.Web.UI.Page
    {

         static List<ClsBodega> bodegas = new List <ClsBodega>();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                ConsultaTodo();
            }
            
        }

        private void LimpiarTabla()
        {
           bodegas.Clear();
            repeaterBodegas.DataSource = null;
            repeaterBodegas.DataBind();

        }

        private void ConsultaTodo()
        {
            LimpiarTabla();
            bodegas = ClsBodega.ReporteBodegas();
            repeaterBodegas.DataSource = bodegas;
            repeaterBodegas.DataBind();
        }

        private void ConsultaFiltronombre()
        {
            LimpiarTabla();
            bodegas = ClsBodega.ReporteBodegasFiltronombre(tnombre.Text);
            repeaterBodegas.DataSource = bodegas;
            repeaterBodegas.DataBind();
        }
        public void ConsultaConFiltro()
        {
            LimpiarTabla();

            bodegas = ClsBodega.ReporteBodegasFiltro(int.Parse(Dbodegas.SelectedValue));
            repeaterBodegas.DataSource = bodegas;
            repeaterBodegas.DataBind();
        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            ConsultaFiltronombre();
        }

        protected void tlimpiar_Click(object sender, EventArgs e)
        {
           
        }

        protected void Dbodegas_SelectedIndexChanged(object sender, EventArgs e)
        {
            ConsultaConFiltro();
        }
    }
}