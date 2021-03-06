﻿<%@ Page Title="Administrar cuenta" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Manage.aspx.cs" Inherits="BazarYasmin.Account.Manage" %>

<%@ Register Src="~/Account/OpenAuthProviders.ascx" TagPrefix="uc" TagName="OpenAuthProviders" %>


  <%@ Import Namespace="mercadopago" %>
<%@ Import Namespace="System.Collections" %>
   
<asp:Content ContentPlaceHolderID="MainContent" runat="server">
 
    <h2><%: Title %>.</h2>

    <div>
        <asp:PlaceHolder runat="server" ID="successMessage" Visible="false" ViewStateMode="Disabled">
            <p class="text-success"><%: SuccessMessage %></p>
        </asp:PlaceHolder>
    </div>

    <div class="row">
        <div class="col-md-12" style="left: -4px; top: 4px">
            <div class="form-horizontal">
                <h4>Cambiar la configuración de la cuenta</h4>
                <hr />
                <dl class="dl-horizontal">
                    <dt>Contraseña:</dt>
                    <dd>
                        <asp:HyperLink NavigateUrl="/Account/ManagePassword" Text="[Change]" Visible="false" ID="ChangePassword" runat="server" />
                        <asp:HyperLink NavigateUrl="/Account/ManagePassword" Text="[Create]" Visible="false" ID="CreatePassword" runat="server" />
                    </dd>
                    <dt>Inicios de sesión externos:</dt>
                    <dd><%: LoginsCount %>
                        <asp:HyperLink NavigateUrl="/Account/ManageLogins" Text="[Manage]" runat="server" />

                    </dd>
                    <%--
                        Los números de teléfono se pueden usar como una segunda fase de comprobación en un sistema de autenticación en dos fases.
                        Vea <a href="http://go.microsoft.com/fwlink/?LinkId=403804">este artículo</a>
                        para obtener detalles sobre cómo configurar esta aplicación de ASP.NET para que sea compatible con la autenticación en dos fases mediante SMS.
                        Quite la marca de comentario de los siguientes bloques después de configurar la autenticación en dos fases
                    --%>
                    
<%--                    <dt>Número de teléfono:</dt>
                    <% if (HasPhoneNumber)
                       { %>
                    <dd>
                        <asp:HyperLink NavigateUrl="/Account/AddPhoneNumber" runat="server" Text="[Add]" />
                    </dd>
                    <% }
                       else
                       { %>
                    <dd>
                        <asp:Label Text="" ID="PhoneNumber" runat="server" />
                        <asp:HyperLink NavigateUrl="/Account/AddPhoneNumber" runat="server" Text="[Change]" /> &nbsp;|&nbsp;
                        <asp:LinkButton Text="[Remove]" OnClick="RemovePhone_Click" runat="server" />
                    </dd>
                    <% } %>
                    --%>

                    <%--<dt>Autenticación de dos factores:</dt>
                    <dd>
                        <p>
                            No hay ningún proveedor de autenticación en dos fases configurado. Vea <a href="http://go.microsoft.com/fwlink/?LinkId=403804">este artículo</a>
                             para obtener detalles sobre cómo configurar esta aplicación de ASP.NET para que sea compatible con la autenticación en dos fases.
                        </p>
                    </dd>--%>
                </dl>
                <br />
                        <% if (TwoFactorEnabled)
                          { %> 
                        <%--
                        Habilitado
                        <asp:LinkButton Text="[Disable]" runat="server" CommandArgument="false" OnClick="TwoFactorDisable_Click" />
                        --%>
                        <% }
                          else
                          { %> 
                        <%--
                        Deshabilitado
                        <asp:LinkButton Text="[Enable]" CommandArgument="true" OnClick="TwoFactorEnable_Click" runat="server" />
                        --%>
                        <% } %>
            </div>
        </div>
        <div class="col-md-12">
            <div class="form-horizontal">
                <h4>Administrar mis pedidos</h4>
                <hr />
                <style>
                        .GridHeader
                        {
                            text-align:center ;   
                        }
                    </style>
                        <div class="col-lg-12" style="overflow: scroll;">

                            <asp:GridView ID ="GridView1" runat="server" AllowPaging="True" AllowSorting="True" AutoGenerateColumns="False" BackColor="White" BorderColor="Black" BorderStyle="None" BorderWidth="1px" CellPadding="3"  Width="1000px" EmptyDataText="No se encuentran Pedidos"  DataKeyNames="codpedido" DataSourceID="SqlDataSource1" HorizontalAlign="Center" ShowFooter="True" >
                                <AlternatingRowStyle HorizontalAlign="Center" Height="35px" BackColor="#F7F7F7" />
                                <Columns>
                                    <asp:TemplateField HeaderText="Codigo" InsertVisible="False" SortExpression="codpedido">
                                        
                                        <ItemTemplate>
                                            <asp:Label ID="Label6" runat="server" Text='<%# Bind("codpedido") %>'></asp:Label>
                                        </ItemTemplate>
                                        <HeaderStyle CssClass="GridHeader" />
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Fecha" SortExpression="fechpedido">
                                        
                                        <ItemTemplate>
                                            <asp:Label ID="Label5" runat="server" Text='<%# Bind("fechpedido") %>'></asp:Label>
                                        </ItemTemplate>
                                        <HeaderStyle CssClass="GridHeader" />
                                    </asp:TemplateField>
                                    
                                    
                                    <asp:TemplateField HeaderText="Total" SortExpression="totalpedido">
                                        
                                        <ItemTemplate>
                                            <asp:Label ID="Label2" runat="server" Text='<%# Bind("totalpedido") %>'></asp:Label> CLP
                                        </ItemTemplate>
                                        <HeaderStyle CssClass="GridHeader" />
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Nombre User" SortExpression="UserName">
                                        
                                        <ItemTemplate>
                                            <asp:Label ID="Label1" runat="server" Text='<%# Bind("UserName") %>'></asp:Label>
                                        </ItemTemplate>
                                        <HeaderStyle CssClass="GridHeader" />
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Entrega" SortExpression="entrega">
                                        
                                        <ItemTemplate>
                                            <asp:Label ID="Label3" runat="server" Text='<%# Bind("entregad") %>'></asp:Label>
                                        </ItemTemplate>
                                        <HeaderStyle CssClass="GridHeader" />
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Estado">
                                        <ItemTemplate>
                                            <asp:Label ID="Labelestado" runat="server"  Text='<%# Bind("descripcion") %>'></asp:Label>
<%--                                            <asp:DropDownList ID="DropDownList1"   runat="server" DataSourceID="SqlDataSource2"   DataTextField="descripcion"   DataValueField="cod_par" Enabled="False" ></asp:DropDownList>--%>
                                        </ItemTemplate>
                                        <EditItemTemplate>

                                            
                                        </EditItemTemplate>
                                         <HeaderStyle CssClass="GridHeader" />
                                    </asp:TemplateField>
                                    <asp:TemplateField ShowHeader="False">
                                        <EditItemTemplate>
                                            </EditItemTemplate>
                                        <ItemTemplate>
                                            <asp:Button runat="server" CssClass="btn btn-primary" Text="Detalle"  data-toggle="modal" data-target="#myModal"/>

                                        </ItemTemplate>
                                    </asp:TemplateField>
                                </Columns>
                                <FooterStyle BackColor="#B5C7DE" Height="35px" ForeColor="#4A3C8C" />
                                <HeaderStyle   BackColor="#4A3C8C" Height="40px" Font-Bold="True" ForeColor="#F7F7F7" />
                                <PagerStyle    BackColor="#E7E7FF" ForeColor="#4A3C8C" HorizontalAlign="Center" />
                                <RowStyle  HorizontalAlign="Center" Height="35px" BackColor="#E7E7FF" ForeColor="#4A3C8C" />
                                <SelectedRowStyle   BackColor="#738A9C" Font-Bold="True" Height="35px" ForeColor="#F7F7F7" />
                                <SortedAscendingCellStyle BackColor="#F4F4FD" />
                                <SortedAscendingHeaderStyle   BackColor="#5A4C9D" />
                                <SortedDescendingCellStyle BackColor="#D8D8F0" />
                                <SortedDescendingHeaderStyle   BackColor="#3E3277" />
                    </asp:GridView>
                    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:DefaultConnection %>" SelectCommand="SELECT pedidos.codpedido, CONVERT (varchar, pedidos.fechpedido, 103) AS fechpedido, pedidos.subtotal, pedidos.iva, pedidos.totalpedido, AspNetUsers.UserName, pedidos.estado, tabla_par.descripcion,pedidos.entrega, par1.descripcion as entregad FROM pedidos INNER JOIN AspNetUsers ON AspNetUsers.Id = pedidos.codcliente INNER JOIN tabla_par ON tabla_par.cod_tab = 1 AND tabla_par.cod_par = pedidos.estado INNER JOIN tabla_par as par1 ON par1.cod_tab = 2 AND par1.cod_par = pedidos.entrega "></asp:SqlDataSource>

                            </div>

            </div>
        </div>
    </div>
      <!-- Modal -->
  <div class="modal fade" id="myModal" role="dialog">
    <div class="modal-dialog">
    
      <!-- Modal content-->
      <div class="modal-content">
        <div class="modal-header">
          <button type="button" class="close" data-dismiss="modal">&times;</button>
          <h4 class="modal-title">Detalle pedido</h4>
        </div>
        <div class="modal-body" >
            <div class="col-lg-12" style="overflow: scroll;">

            <asp:GridView ID="GridView2" runat="server" Width="400" HorizontalAlign="Center" AutoGenerateColumns="False" DataSourceID="SqlDataSource2">
                     <AlternatingRowStyle HorizontalAlign="Center" Height="35px" BackColor="#F7F7F7" />

                <Columns>
                    <asp:BoundField DataField="descproducto" HeaderText="Producto" SortExpression="descproducto">
                                                                 <HeaderStyle CssClass="GridHeader" />

                    </asp:BoundField>
                    <asp:BoundField DataField="cantproducto" HeaderText="Cantidad" SortExpression="cantproducto">
                        <HeaderStyle CssClass="GridHeader" />

                    </asp:BoundField>
                    <asp:BoundField DataField="precio" HeaderText="Precio" SortExpression="precio">
                       <HeaderStyle CssClass="GridHeader" />

                    </asp:BoundField>
                    <asp:BoundField DataField="subtotal" HeaderText="Subtotal" SortExpression="subtotal">
                        <HeaderStyle CssClass="GridHeader" />

                    </asp:BoundField>
                </Columns>
                                 <FooterStyle BackColor="#B5C7DE" Height="35px" ForeColor="#4A3C8C" />
                                <HeaderStyle   BackColor="#4A3C8C" Height="40px" Font-Bold="True" ForeColor="#F7F7F7" />
                                <PagerStyle    BackColor="#E7E7FF" ForeColor="#4A3C8C" HorizontalAlign="Center" />
                                <RowStyle  HorizontalAlign="Center" Height="35px" BackColor="#E7E7FF" ForeColor="#4A3C8C" />
                                <SelectedRowStyle   BackColor="#738A9C" Font-Bold="True" Height="35px" ForeColor="#F7F7F7" />
                                <SortedAscendingCellStyle BackColor="#F4F4FD" />
                                <SortedAscendingHeaderStyle   BackColor="#5A4C9D" />
                                <SortedDescendingCellStyle BackColor="#D8D8F0" />
                                <SortedDescendingHeaderStyle   BackColor="#3E3277" />
            </asp:GridView>
                <br />
                <asp:GridView ID="GridView3" runat="server" Width="400" HorizontalAlign="Center" AutoGenerateColumns="False" DataSourceID="SqlDataSource3">
                     <AlternatingRowStyle HorizontalAlign="Center" Height="35px" BackColor="#F7F7F7" />

                    <Columns>
                        <asp:BoundField DataField="subtotal" HeaderText="Subtotal" SortExpression="subtotal">
                        <HeaderStyle CssClass="GridHeader" />

                        </asp:BoundField>
                        <asp:BoundField DataField="iva" HeaderText="IVA" SortExpression="iva">
                       <HeaderStyle CssClass="GridHeader" />

                        </asp:BoundField>

                        <asp:BoundField DataField="totalpedido" HeaderText="Total pedido" SortExpression="totalpedido">
                       <HeaderStyle CssClass="GridHeader" />

                        </asp:BoundField>

                    </Columns>
                                <FooterStyle BackColor="#B5C7DE" Height="35px" ForeColor="#4A3C8C" />
                                <HeaderStyle   BackColor="#4A3C8C" Height="40px" Font-Bold="True" ForeColor="#F7F7F7" />
                                <PagerStyle    BackColor="#E7E7FF" ForeColor="#4A3C8C" HorizontalAlign="Center" />
                                <RowStyle  HorizontalAlign="Center" Height="35px" BackColor="#E7E7FF" ForeColor="#4A3C8C" />
                                <SelectedRowStyle   BackColor="#738A9C" Font-Bold="True" Height="35px" ForeColor="#F7F7F7" />
                                <SortedAscendingCellStyle BackColor="#F4F4FD" />
                                <SortedAscendingHeaderStyle   BackColor="#5A4C9D" />
                                <SortedDescendingCellStyle BackColor="#D8D8F0" />
                                <SortedDescendingHeaderStyle   BackColor="#3E3277" />
                </asp:GridView>
                <asp:SqlDataSource runat="server" ID="SqlDataSource3" ConnectionString='<%$ ConnectionStrings:DefaultConnection %>' SelectCommand="SELECT [totalpedido], [iva], [subtotal] FROM [pedidos] WHERE ([codpedido] = @codpedido)">
                    <SelectParameters>
                        <asp:Parameter DefaultValue="1" Name="codpedido" Type="Int32"></asp:Parameter>
                    </SelectParameters>
                </asp:SqlDataSource>
            </div>
              <%
       
       
       MP mp = new MP("4736332457228950", "0LWuHjraDil2tQrQN5uwMFaS1vuZMlWt");

       String preferenceData = "{\"items\":"+
           "[{"+
               "\"title\":\"Pedido-1\","+
               "\"quantity\":1,"+
               "\"currency_id\":\"CLP\","+
               "\"unit_price\":20800"+
           "}]"+
       "}";

       Hashtable preference = mp.createPreference(preferenceData);
%>
            <div style="align-content:center;text-align:center" ><a href="<% Response.Write(((Hashtable) preference["response"])["init_point"]); %>"><img  width="180" height="60" src="../img/BOTON-DE-MERCADO-PAGO-300x90.jpg" /></a></div>
<%--            <img src="../img/boton-paypal.png"  width="180" height="60" />--%>
            <%--<form name="_xclick" runat="server" action="https://www.paypal.com/es/cgi-bin/webscr" method="post">
<input type="hidden" name="cmd" value="_xclick">
<input type="hidden" name="business" value="robertogajardo.r@gmail.com">
<input type="hidden" name="currency_code" value="USD">
<input type="hidden" name="item_name" value="PedidoBY">
<input type="hidden" name="amount" value="9 ">
<input type="image" src="http://www.paypal.com/es_ES/i/btn/x-click-but01.gif" border="0" name="submit" alt="Realice pagos con PayPal: es rápido, gratis y seguro">
</form>--%>
  
            <asp:SqlDataSource runat="server" ID="SqlDataSource2" ConnectionString='<%$ ConnectionStrings:DefaultConnection %>' SelectCommand="SELECT productos.descproducto, detallepedidos.cantproducto, detallepedidos.precio, detallepedidos.subtotal FROM detallepedidos INNER JOIN productos ON detallepedidos.codproducto = productos.codigoproducto WHERE (detallepedidos.codpedido = 1)"></asp:SqlDataSource>
        </div>
        <div class="modal-footer">
          <button type="button" style="float:left" class="btn btn-default " data-dismiss="modal">Cerrar</button>
              <%--<button type="submit" class="btn btn-success" style="float:right">Guardar</button>--%>
            <asp:Button ID="Button1" class="btn btn-success" style="float:right" Text="Guardar" runat="server"  />

        </div>
      </div>
      
    </div>
  </div>
</asp:Content>
