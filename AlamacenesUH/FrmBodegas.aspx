<%@ Page Title="" Language="C#" MasterPageFile="~/Menumaster.master" AutoEventWireup="true" CodeBehind="FrmBodegas.aspx.cs" Inherits="AlamacenesUH.FrmBodegas" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
<h2> Consulta de Bodegas</h2>

        <div class="right">
        <p>Ingrese las bodega</p>
       <asp:DropDownList ID="Dbodegas" runat="server" DataSourceID="SqlDataSource1" DataTextField="nombre" DataValueField="id" Height="46px" Width="177px" AutoPostBack="True" OnSelectedIndexChanged="Dbodegas_SelectedIndexChanged"></asp:DropDownList>
       &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            <asp:TextBox ID="tnombre" runat="server"></asp:TextBox>
       <asp:Button ID="Button1" runat="server" Text="Refrescar" OnClick="Button1_Click" Visible="true" />
         
       <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:CadenadeConexion %>" SelectCommand="SELECT * FROM [BODEGA]"></asp:SqlDataSource>

            <h2>Lista de Bodegas</h2>
            <table id="clientListTable">
                <thead>
                    <tr>
                        <th>Producto</th>
                        <th>Bodega</th>
                        <th>Cantidad</th>
                    </tr>
                    <asp:Repeater runat="server" ID="repeaterBodegas">
                        <ItemTemplate>
                            <tr>
                                <td><%# Eval("Producto") %></td>
                                <td><%# Eval("Bodega") %></td>
                                <td><%# Eval("Cantidad") %></td>
                        
                            </tr>
                        </ItemTemplate>
                    </asp:Repeater>
                </thead>
            </table>
        </div>
        </div>
    </div>

</asp:Content>
