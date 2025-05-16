package com.example.service;

import java.sql.*;
import java.util.*;
import java.util.logging.Logger;
import javax.sql.DataSource;
import com.example.utils.LoggerUtil;
import oracle.jdbc.OracleTypes;

public class BpblService {
    private DataSource dataSource;
    private static final Logger logger = LoggerUtil.getLogger(BpblService.class);

    public BpblService(DataSource dataSource) {
        this.dataSource = dataSource;
    }
    
    public List<Map<String, Object>> getBpblData(int start, int length, String sortBy, String sortDir, String search,
                                                 String sumberData, String tahun, String data, String option, String idOption, 
                                                 List<String> pesanOutput) {

        logger.info("Memulai panggilan prosedur Oracle dengan parameter tahun: " + tahun);
        List<Map<String, Object>> result = new ArrayList<>();

        String sql = "{call BPBL_SURVEY.PKG_MON_LAP_BPBLPRASURVEY.S_BPBLPRASURVEY_PROV_DAFTAR_PGS(?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)}";

        try (Connection conn = dataSource.getConnection();
             CallableStatement stmt = conn.prepareCall(sql)) {
             
            stmt.setInt(1, start);
            stmt.setInt(2, length);
            stmt.setString(3, sortDir); // DESC
            stmt.setString(4, sortBy);  // UNITU
            stmt.setString(5, search);
            stmt.setString(6, sumberData);
            stmt.setString(7, tahun);
            stmt.setString(8, data);
            stmt.setString(9, option);
            stmt.setString(10, idOption);
            stmt.registerOutParameter(11, OracleTypes.CURSOR); // out_data
            stmt.registerOutParameter(12, Types.VARCHAR);      // pesan

            stmt.execute();
            logger.info("Prosedur berhasil dieksekusi");

            try (ResultSet rs = (ResultSet) stmt.getObject(11)) {
                while (rs.next()) {
                    Map<String, Object> row = new HashMap<>();
                    row.put("TOTAL_COUNT", rs.getString("TOTAL_COUNT"));
                    row.put("ID_KOLEKTIF", rs.getString("ID_KOLEKTIF"));
                    row.put("NAMA_PELANGGAN", rs.getString("NAMA_PELANGGAN"));
                    row.put("UNITUP", rs.getString("UNITUP"));
                    row.put("PROVINSI", rs.getString("PROVINSI"));
                    row.put("DATA", rs.getString("DATA"));
                    // Tambahkan kolom lain jika diperlukan
                    result.add(row);
                }
            }

            String pesan = stmt.getString(12);
            pesanOutput.add(pesan);

        } catch (SQLException e) {
            logger.severe("Kesalahan database: " + e.getMessage());
            pesanOutput.add("Terjadi kesalahan koneksi ke database: " + e.getMessage());
        }

        return result;
    }
}
