/*
 * Generated by the Jasper component of Apache Tomcat
 * Version: Apache Tomcat/7.0.47
 * Generated at: 2025-05-23 03:38:28 UTC
 * Note: The last modified time of this file was set to
 *       the last modified time of the source file after
 *       generation to assist with modification tracking.
 */
package org.apache.jsp.views.monitoring;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.jsp.*;

public final class v_005fmon_005fperpengusul_jsp extends org.apache.jasper.runtime.HttpJspBase
    implements org.apache.jasper.runtime.JspSourceDependent {

  private static final javax.servlet.jsp.JspFactory _jspxFactory =
          javax.servlet.jsp.JspFactory.getDefaultFactory();

  private static java.util.Map<java.lang.String,java.lang.Long> _jspx_dependants;

  private javax.el.ExpressionFactory _el_expressionfactory;
  private org.apache.tomcat.InstanceManager _jsp_instancemanager;

  public java.util.Map<java.lang.String,java.lang.Long> getDependants() {
    return _jspx_dependants;
  }

  public void _jspInit() {
    _el_expressionfactory = _jspxFactory.getJspApplicationContext(getServletConfig().getServletContext()).getExpressionFactory();
    _jsp_instancemanager = org.apache.jasper.runtime.InstanceManagerFactory.getInstanceManager(getServletConfig());
  }

  public void _jspDestroy() {
  }

  public void _jspService(final javax.servlet.http.HttpServletRequest request, final javax.servlet.http.HttpServletResponse response)
        throws java.io.IOException, javax.servlet.ServletException {

    final javax.servlet.jsp.PageContext pageContext;
    javax.servlet.http.HttpSession session = null;
    final javax.servlet.ServletContext application;
    final javax.servlet.ServletConfig config;
    javax.servlet.jsp.JspWriter out = null;
    final java.lang.Object page = this;
    javax.servlet.jsp.JspWriter _jspx_out = null;
    javax.servlet.jsp.PageContext _jspx_page_context = null;


    try {
      response.setContentType("text/html;charset=UTF-8");
      pageContext = _jspxFactory.getPageContext(this, request, response,
      			null, true, 8192, true);
      _jspx_page_context = pageContext;
      application = pageContext.getServletContext();
      config = pageContext.getServletConfig();
      session = pageContext.getSession();
      out = pageContext.getOut();
      _jspx_out = out;

      out.write("\r\n");
      out.write("\r\n");
      out.write("<div class=\"pt-4 px-4\">\r\n");
      out.write("    <h2 class=\"mb-4\">Data Pelanggan BPBL PerPengusul</h2>\r\n");
      out.write("\r\n");
      out.write("    <div class=\"mb-3 row align-items-center\">\r\n");
      out.write("        <label for=\"selectTahun\" class=\"col-sm-2 col-form-label\">Pilih Tahun:</label>\r\n");
      out.write("        <div class=\"col-sm-3\">\r\n");
      out.write("            <select id=\"selectTahun\" class=\"form-select\">\r\n");
      out.write("                <option value=\"2022\">2022</option>\r\n");
      out.write("                <option value=\"2024\">2024</option>\r\n");
      out.write("                <option value=\"2025\" selected>2025</option>\r\n");
      out.write("            </select>\r\n");
      out.write("        </div>\r\n");
      out.write("\r\n");
      out.write("        <label for=\"selectOption\" class=\"col-sm-2 col-form-label\">Pilih Option:</label>\r\n");
      out.write("        <div class=\"col-sm-3\">\r\n");
      out.write("            <select id=\"selectOption\" class=\"form-select\">\r\n");
      out.write("                <option value=\"PROVINSI\" selected>PROVINSI</option>\r\n");
      out.write("                <option value=\"UPI\">UPI</option>\r\n");
      out.write("            </select>\r\n");
      out.write("        </div>\r\n");
      out.write("\r\n");
      out.write("        <div class=\"col-sm-2\">\r\n");
      out.write("            <button id=\"btnTampil\" class=\"btn btn-primary\">Tampilkan</button>\r\n");
      out.write("        </div>\r\n");
      out.write("    </div>\r\n");
      out.write("\r\n");
      out.write("    <table id=\"bpblTable\" class=\"display table table-bordered table-hover nowrap\" style=\"width:100%\">\r\n");
      out.write("        <thead class=\"table-dark\">\r\n");
      out.write("        <tr>\r\n");
      out.write("            <th>No</th>\r\n");
      out.write("            <th>DATA</th>\r\n");
      out.write("            <th>ID_KOLEKTIF</th>\r\n");
      out.write("            <th>NAMA_PELANGGAN</th>\r\n");
      out.write("            <th>UNITUP</th>\r\n");
      out.write("            <th>PROVINSI</th>\r\n");
      out.write("        </tr>\r\n");
      out.write("        </thead>\r\n");
      out.write("    </table>\r\n");
      out.write("</div>\r\n");
      out.write("\r\n");
      out.write("<script>\r\n");
      out.write("    $(document).ready(function () {\r\n");
      out.write("        const table = $('#bpblTable').DataTable({\r\n");
      out.write("            responsive: true,\r\n");
      out.write("            processing: true,\r\n");
      out.write("            serverSide: true,\r\n");
      out.write("            ajax: {\r\n");
      out.write("                url: '");
      out.print( request.getContextPath() );
      out.write("/bpbl',\r\n");
      out.write("                type: 'GET',\r\n");
      out.write("                data: function (d) {\r\n");
      out.write("                    d.vtahun = $('#selectTahun').val();\r\n");
      out.write("                    d.voption = $('#selectOption').val();\r\n");
      out.write("                },\r\n");
      out.write("                dataSrc: 'data',\r\n");
      out.write("                error: function (xhr, error, thrown) {\r\n");
      out.write("                    console.error('Gagal load data:', error, thrown);\r\n");
      out.write("                }\r\n");
      out.write("            },\r\n");
      out.write("            columns: [\r\n");
      out.write("                {\r\n");
      out.write("                    data: null,\r\n");
      out.write("                    render: function (data, type, row, meta) {\r\n");
      out.write("                        return meta.row + 1 + meta.settings._iDisplayStart;\r\n");
      out.write("                    }\r\n");
      out.write("                },\r\n");
      out.write("                {data: 'DATA', defaultContent: '-'},\r\n");
      out.write("                {data: 'ID_KOLEKTIF', defaultContent: '-'},\r\n");
      out.write("                {data: 'NAMA_PELANGGAN', defaultContent: '-'},\r\n");
      out.write("                {data: 'UNITUP', defaultContent: '-'},\r\n");
      out.write("                {data: 'PROVINSI', defaultContent: '-'}\r\n");
      out.write("            ],\r\n");
      out.write("            searching: false,\r\n");
      out.write("            language: {\r\n");
      out.write("                emptyTable: \"Tidak ada data tersedia\",\r\n");
      out.write("                zeroRecords: \"Data tidak ditemukan\"\r\n");
      out.write("            }\r\n");
      out.write("        });\r\n");
      out.write("\r\n");
      out.write("        $('#btnTampil').click(function () {\r\n");
      out.write("            table.ajax.reload();\r\n");
      out.write("        });\r\n");
      out.write("    });\r\n");
      out.write("</script>\r\n");
    } catch (java.lang.Throwable t) {
      if (!(t instanceof javax.servlet.jsp.SkipPageException)){
        out = _jspx_out;
        if (out != null && out.getBufferSize() != 0)
          try { out.clearBuffer(); } catch (java.io.IOException e) {}
        if (_jspx_page_context != null) _jspx_page_context.handlePageException(t);
        else throw new ServletException(t);
      }
    } finally {
      _jspxFactory.releasePageContext(_jspx_page_context);
    }
  }
}
