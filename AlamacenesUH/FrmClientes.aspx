<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="FrmClientes.aspx.cs" Inherits="AlamacenesUH.FrmClientes" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <link href="Css/EstiloCatalogo.css" rel="stylesheet" />
    <link href="Css/CssBotones.css" rel="stylesheet" />
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <div>
                <label for="codigo">Codigo:</label>
                <asp:TextBox ID="tcodigo" runat="server" requiered></asp:TextBox>
            </div>
            <div>
                <label for="Nombre">Nombre Cliente:</label>
                <asp:TextBox ID="tnombre" runat="server"></asp:TextBox>
            </div>
            <div>
                <label for="Direccion">Direccion:</label>
                <asp:TextBox ID="tdireccion" runat="server"></asp:TextBox>
            </div>
            <div>
                <label for="Telefono">Telefono:</label>
                <asp:TextBox ID="ttelefono" runat="server"></asp:TextBox>
            </div>


            <asp:Button ID="BAgregar" CssClass=" button button1" runat="server" Text="Agregar" OnClick="BAgregar_Click" />
            <asp:Button ID="BBorrar" CssClass=" button button2" runat="server" Text="Borrar" OnClick="BBorrar_Click" />
            <asp:Button ID="BModificar" CssClass=" button button3" runat="server" Text="Modificar" />
            <asp:Button ID="BConsultar" CssClass=" button button4" runat="server" Text="Consultar" />


        </div>

        <div class="right">
            <h2>Lista de Clientes</h2>
            <table id="clientListTable">
                <thead>
                    <tr>
                        <th>codigo</th>
                        <th>Nombre</th>
                        <th>Direccion</th>
                        <th>Telefono</th>
                    </tr>
                    <asp:Repeater runat="server" ID="repeaterClientes">
                        <ItemTemplate>
                            <tr>
                                <td><%# Eval("ID") %></td>
                                <td><%# Eval("Nombre") %></td>
                                <td><%# Eval("Direccion") %></td>
                                <td><%# Eval("Telefono") %></td>


<%--                                 <td>
                                        
                                        <asp:Button ID="btnEditar" runat="server" Text="Editar" OnClick="btnEditar_Click" CommandArgument='<%# Eval("Codigo") %>' />
                                        <asp:Button ID="btnBorrar" runat="server" Text="Borrar" OnClick="btnBorrar_Click" CommandArgument='<%# Eval("Codigo") %>' />
                                    </td>--%>
                            </tr>
                        </ItemTemplate>
                    </asp:Repeater>
                </thead>
            </table>
        </div>
        </div>
    </div>
        <div class="footer"> Derechos reservador 2023</div>
    </form>
</body>
</html>
