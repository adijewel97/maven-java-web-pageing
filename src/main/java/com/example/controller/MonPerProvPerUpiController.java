package com.example.controller;

import com.example.service.DbService;
import com.example.service.MonPerProvPerUpiService;
import com.example.utils.LoggerUtil;
import com.google.gson.Gson;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.*;
import java.util.logging.Level;
import java.util.logging.Logger;

@WebServlet(name = "MonPerProvPerUpiController", urlPatterns = {"/monperprovperupi"})
public class MonPerProvPerUpiController extends HttpServlet {
    private MonPerProvPerUpiService service;
    private static final Logger logger = LoggerUtil.getLogger(MonPerProvPerUpiController.class);
    private final Gson gson = new Gson();

    private static final String ACT_JENIS_LAPORAN = "handleGetJenisLaporan";
    private static final String ACT_SUMBER_DATA = "handleGetsumberdata";

    @Override
    public void init() throws ServletException {
        super.init();
        try {
            DbService dbService = new DbService();
            service = new MonPerProvPerUpiService(dbService.getDataSource());
        } catch (Exception e) {
            logger.log(Level.SEVERE, "Gagal inisialisasi koneksi DB di init()", e);
            throw new ServletException("Gagal inisialisasi koneksi DB", e);
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String act = req.getParameter("act");
        logger.info("DEBUG: act = " + act);

        if (ACT_JENIS_LAPORAN.equalsIgnoreCase(act)) {
            handleGetJenisLaporan(req, resp);
            return;
        }

        if (ACT_SUMBER_DATA.equalsIgnoreCase(act)) {
            handleGetsumberdata(req, resp);
            return;
        }

        prosesMonPerProvPerUpi(req, resp);
    }

    private void prosesMonPerProvPerUpi(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        String vkd_sumberdata = req.getParameter("vkd_sumberdata");
        String vtahun = req.getParameter("vtahun");
        int vkode;

        // WAJIB untuk DataTables server-side
        int draw = Integer.parseInt(req.getParameter("draw") != null ? req.getParameter("draw") : "1");

        logger.info("vkd_sumberdata: " + vkd_sumberdata);
        logger.info("vtahun: " + vtahun);

        List<Map<String, Object>> data = Collections.emptyList();
        int totalCount = 0;
        String pesan;

       try {
            List<String> pesanOutput = new ArrayList<>();
            data = service.getDataMPerProvPerUpi(vkd_sumberdata, vtahun, pesanOutput);

            String pesanRaw = pesanOutput.isEmpty() ? "" : pesanOutput.get(0).toLowerCase().trim();
            if (pesanRaw.contains("kesalahan")) {
                vkode = 402;
                pesan = "Error:"+pesanOutput.get(0);
                data = new ArrayList<>();
            } else {
                totalCount = data.size();
                vkode = 200;
                pesan = "Sukses: Tampikan data";
            }
        } catch (Exception e) {
            logger.log(Level.SEVERE, "Error: Gagal mendapatkan data: " + e.getMessage(), e);
            vkode = 402;
            pesan = "Error: Terjadi kesalahan: " + e.getMessage();
        }

        // Format JSON sesuai DataTables server-side
        Map<String, Object> jsonResponse = new HashMap<>();
        jsonResponse.put("draw", draw); // WAJIB
        jsonResponse.put("recordsTotal", totalCount); // WAJIB
        jsonResponse.put("recordsFiltered", totalCount); // WAJIB
        jsonResponse.put("data", data); // WAJIB
        jsonResponse.put("status", "success");
        jsonResponse.put("kode", vkode);
        jsonResponse.put("pesan", pesan);


        resp.setContentType("application/json");
        resp.setCharacterEncoding("UTF-8");

        try (PrintWriter out = resp.getWriter()) {
            out.print(gson.toJson(jsonResponse));
        }
    }

    private void handleGetJenisLaporan(HttpServletRequest request, HttpServletResponse response) throws IOException {
        Map<String, Object> responseData = new HashMap<>();
        List<String> pesanOutput = new ArrayList<>();

        try {
            List<Map<String, Object>> listJenis = service.getcombojenislaporan(pesanOutput);
            responseData.put("status", "success");
            responseData.put("data", listJenis != null ? listJenis : Collections.emptyList());
            responseData.put("pesan", pesanOutput.isEmpty() ? "" : pesanOutput.get(0));
        } catch (Exception e) {
            logger.log(Level.SEVERE, "Kesalahan saat mengambil jenis laporan", e);
            responseData.put("status", "error");
            responseData.put("data", Collections.emptyList());
            responseData.put("pesan", "Terjadi kesalahan: " + e.getMessage());
        }

        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        try (PrintWriter out = response.getWriter()) {
            out.print(gson.toJson(responseData));
        }
    }

    private void handleGetsumberdata(HttpServletRequest request, HttpServletResponse response) throws IOException {
        Map<String, Object> responseData = new HashMap<>();
        List<String> pesanOutput = new ArrayList<>();

        try {
            List<Map<String, Object>> listSumber = service.getcombosumberdata(pesanOutput);
            responseData.put("status", "success");
            responseData.put("data", listSumber != null ? listSumber : Collections.emptyList());
            responseData.put("pesan", pesanOutput.isEmpty() ? "" : pesanOutput.get(0));
        } catch (Exception e) {
            logger.log(Level.SEVERE, "Kesalahan saat mengambil sumber data", e);
            responseData.put("status", "error");
            responseData.put("data", Collections.emptyList());
            responseData.put("pesan", "Terjadi kesalahan: " + e.getMessage());
        }

        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        try (PrintWriter out = response.getWriter()) {
            out.print(gson.toJson(responseData));
        }
    }

    // private int parseTotalCount(Object totalCountObj, int fallback) {
    //     if (totalCountObj instanceof Number) {
    //         return ((Number) totalCountObj).intValue();
    //     } else if (totalCountObj != null) {
    //         try {
    //             return Integer.parseInt(totalCountObj.toString());
    //         } catch (NumberFormatException ignored) {}
    //     }
    //     return fallback;
    // }
}
