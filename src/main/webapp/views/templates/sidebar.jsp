<a class="nav-link <%= "dashboard".equals(request.getParameter("menu")) || request.getParameter("menu") == null ? "active" : "" %>"
   href="index.jsp?page=/views/dashboard/dashboard.jsp&menu=dashboard">
    <i class="bi bi-speedometer2 me-2"></i> Dashboard
</a>

<a class="nav-link <%= "monitoring".equals(request.getParameter("menu")) ? "active" : "" %>"
   data-bs-toggle="collapse"
   href="#collapseMonitoring"
   role="button"
   aria-expanded="true"
   aria-controls="collapseMonitoring">
    <i class="bi bi-graph-up me-2"></i> Monitoring
</a>

<div class="collapse ps-3 show" id="collapseMonitoring">
    <a class="nav-link <%= "monitoring-prov-upi".equals(request.getParameter("menu")) ? "active" : "" %>"
       href="index.jsp?page=/views/monitoring/v_mon_perprov_upi.jsp&menu=monitoring-prov-upi">
        Mon PerProv dan PerUpi
    </a>
    <a class="nav-link <%= "Daftar-prov-upi".equals(request.getParameter("menu")) ? "active" : "" %>"
       href="index.jsp?page=/views/monitoring/v_dft_perprov_upi.jsp&menu=Daftar-prov-upi">
        Daftar PerProv dan PerUpi
    </a>
    <a class="nav-link <%= "monitoring-perpengusul".equals(request.getParameter("menu")) ? "active" : "" %>"
       href="index.jsp?page=/views/monitoring/v_mon_perpengusul.jsp&menu=monitoring-perpengusul">
        Mon PerPengusul
    </a>
</div>
