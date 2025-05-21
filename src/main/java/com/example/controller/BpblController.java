package com.example.controller;

import com.example.service.BpblService;
import com.example.service.DbService;
import com.example.utils.LoggerUtil;
import com.google.gson.Gson;

import javax.servlet.ServletException;
import javax.servlet.http.*;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.*;
import java.util.logging.Level;
import java.util.logging.Logger;

public class BpblController extends HttpServlet {
    private BpblService service;
    private static final Logger logger = LoggerUtil.getLogger(BpblController.class);
    private final Gson gson = new Gson();

    @Override
    public void init() throws ServletException {
        super.init();
        try {
            DbService dbService = new DbService();
            service = new BpblService(dbService.getDataSource());
        } catch (Exception e) {
            logger.log(Level.SEVERE, "Gagal inisialisasi koneksi DB di init()", e);
            throw new ServletException("Gagal inisialisasi koneksi DB", e);
        }
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        // Ambil parameter dari request
        String drawParam = req.getParameter("draw");
        String startParam = req.getParameter("start");
        String lengthParam = req.getParameter("length");
        String searchValue = Optional.ofNullable(req.getParameter("search[value]")).orElse("");
        String orderColumnIndex = req.getParameter("order[0][column]");
        String orderDir = Optional.ofNullable(req.getParameter("order[0][dir]")).orElse("asc");

        String vtahun = Optional.ofNullable(req.getParameter("vtahun")).filter(s -> !s.isEmpty()).orElse("2025");
        String voption = Optional.ofNullable(req.getParameter("voption")).filter(s -> !s.isEmpty()).orElse("PROVINSI");
        String vdata = req.getParameter("vdata");
        boolean all = "true".equalsIgnoreCase(req.getParameter("all"));

        int draw = parseIntOrDefault(drawParam, 1);
        int start = parseIntOrDefault(startParam, 0);
        int length = parseIntOrDefault(lengthParam, 10);
        int page = (start / length) + 1;

        // Jika "all" diminta, ubah paging agar ambil semua data dari page 1
        if (all) {
            page = 1;
            length = Integer.MAX_VALUE; //10000; //  GUNAKAN BATAS AMAN, JANGAN Integer.MAX_VALUE
        }

        logger.info("Halaman yang dipilih: " + page + ", start: " + start + ", length: " + length + ", all: " + all);

        // Penentuan kolom pengurutan default
        String[] columns = {
            "DATA", "ID_KOLEKTIF", "IDURUT_BPBL", "TANGGAL_USULAN", "KODE_PENGUSUL",
            "NAMA_PELANGGAN", "NIK", "ALAMAT", "UNITUPI", "KD_PROV",
            "KD_PROV_USULAN", "PROVINSI"
        };

        String orderBy = switch (voption.toUpperCase()) {
            case "PROVINSI" -> "KD_PROV";
            case "UPI" -> "UNITUPI";
            case "PENGUSUL" -> "KD_PROV";
            default -> "UNITUP";
        };

        if (orderColumnIndex != null) {
            try {
                int colIndex = Integer.parseInt(orderColumnIndex);
                if (colIndex >= 0 && colIndex < columns.length) {
                    orderBy = columns[colIndex];
                }
            } catch (NumberFormatException ignored) {}
        }

        orderDir = orderDir.equalsIgnoreCase("desc") ? "DESC" : "ASC";

        List<Map<String, Object>> data = Collections.emptyList();
        int totalCount = 0;

        try {
            List<String> pesanOutput = new ArrayList<>();
            data = service.getBpblData(
                page, length,
                orderDir, orderBy,
                searchValue,
                "SEMUA",
                vtahun,
                vdata,
                voption,
                "SEMUA",
                pesanOutput
            );

            if (!data.isEmpty()) {
                Object totalCountObj = data.get(0).get("TOTAL_COUNT");
                totalCount = parseTotalCount(totalCountObj, data.size());
            }
        } catch (Exception e) {
            logger.log(Level.SEVERE, "Gagal mendapatkan data", e);
        }

        Map<String, Object> jsonResponse = new HashMap<>();
        jsonResponse.put("draw", draw);
        jsonResponse.put("recordsTotal", totalCount);
        jsonResponse.put("recordsFiltered", totalCount);
        jsonResponse.put("data", data);

        resp.setContentType("application/json");
        try (PrintWriter out = resp.getWriter()) {
            out.print(gson.toJson(jsonResponse));
        }
    }

    private int parseIntOrDefault(String value, int defaultValue) {
        try {
            return value != null ? Integer.parseInt(value) : defaultValue;
        } catch (NumberFormatException e) {
            return defaultValue;
        }
    }

    private int parseTotalCount(Object totalCountObj, int fallback) {
        if (totalCountObj instanceof Number) {
            return ((Number) totalCountObj).intValue();
        } else if (totalCountObj != null) {
            try {
                return Integer.parseInt(totalCountObj.toString());
            } catch (NumberFormatException ignored) {}
        }
        return fallback;
    }
}
