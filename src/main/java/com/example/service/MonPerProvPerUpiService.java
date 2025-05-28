package com.example.service;

import java.sql.*;
import java.util.*;
import java.util.logging.Logger;
import javax.sql.DataSource;
import com.example.utils.LoggerUtil;
import oracle.jdbc.OracleTypes;

public class MonPerProvPerUpiService {
    private DataSource dataSource;
    private static final Logger logger = LoggerUtil.getLogger(MonPerProvPerUpiService.class);

    public MonPerProvPerUpiService(DataSource dataSource) {
        this.dataSource = dataSource;
    }
    
    public List<Map<String, Object>> getDataMPerProvPerUpi(String kd_sumberdata, String tahun, 
                                                 List<String> pesanOutput) {

        logger.info("Memulai panggilan prosedur Oracle M_BPBLPRASURVEY_PROV dengan parameter tahun: " + tahun);
        List<Map<String, Object>> result = new ArrayList<>();

        String sql = "{call BPBL_SURVEY.PKG_MON_LAP_BPBLPRASURVEY.M_BPBLPRASURVEY_PROV( ?, ?, ?, ?)}";

        try (Connection conn = dataSource.getConnection();
            CallableStatement stmt = conn.prepareCall(sql)) {
            
            stmt.setString(1, kd_sumberdata);
            stmt.setString(2, tahun);
            stmt.registerOutParameter(3, OracleTypes.CURSOR); // out_data
            stmt.registerOutParameter(4, Types.VARCHAR);      // pesan

            stmt.execute();
            logger.info("Prosedur Utama berhasil dieksekusi");


            try (ResultSet rs = (ResultSet) stmt.getObject(3)) {
                // Chek filed yg di tkirim dari backend
                // ResultSetMetaData meta = rs.getMetaData();
                // int columnCount = meta.getColumnCount();
                // for (int i = 1; i <= columnCount; i++) {
                //     System.out.println(meta.getColumnName(i));
                // }
                while (rs.next()) {
                    Map<String, Object> row = new HashMap<>();
                    row.put("URUT", rs.getString("URUT"));
                    row.put("KODE", rs.getString("KODE"));
                    row.put("NAMA", rs.getString("NAMA"));
                    row.put("TAHUN", rs.getString("TAHUN"));
                    row.put("SUMBER_DATA", rs.getString("SUMBER_DATA"));
                    row.put("TARGET", rs.getString("TARGET"));
                    row.put("TOTAL_SUMBER", rs.getString("TOTAL_SUMBER"));
                    row.put("NIK_BLM_VALID", rs.getString("NIK_BLM_VALID"));
                    row.put("NIK_VALID", rs.getString("NIK_VALID"));
                    row.put("NIK_VALID_KOREKSI", rs.getString("NIK_VALID_KOREKSI"));
                    row.put("TOTAL_NIK_VALID", rs.getString("TOTAL_NIK_VALID"));
                    row.put("BLM_VERIFIKASI_DJK", rs.getString("BLM_VERIFIKASI_DJK"));
                    row.put("VERIFIKASI_DJK_VALID", rs.getString("VERIFIKASI_DJK_VALID"));
                    row.put("BLM_KIRIM_PRASURVEY", rs.getString("BLM_KIRIM_PRASURVEY"));
                    row.put("KIRIM_PRASURVEY", rs.getString("KIRIM_PRASURVEY"));
                    row.put("BLM_CUTOFF_SURVEY", rs.getString("BLM_CUTOFF_SURVEY"));
                    row.put("CUTOFF_SURVEY", rs.getString("CUTOFF_SURVEY"));
                    row.put("PERSEN_DATAVERIFIKASI", rs.getString("PERSEN_DATAVERIFIKASI"));
                    row.put("PERSEN_TARGET", rs.getString("PERSEN_TARGET"));
                    // Tambahkan kolom lain jika diperlukan
                    result.add(row);
                }
            }

            String pesan = stmt.getString(4);
            pesanOutput.add(pesan);

        } catch (SQLException e) {
            logger.severe("Kesalahan database M_BPBLPRASURVEY_PROV: " + e.getMessage());
            pesanOutput.add("Terjadi kesalahan koneksi ke database: " + e.getMessage());
        }

        return result;
    }


    public List<Map<String, Object>> getcombojenislaporan(List<String> pesanOutput) {

        logger.info("Memanggil package combobox Jenis Laporan");
        List<Map<String, Object>> result = new ArrayList<>();

        String sql = "{call BPBL_SURVEY.PKG_MON_LAP_BPBLPRASURVEY.PILIH_JENIS_LAPORAN(?, ?)}";

        try (Connection conn = dataSource.getConnection();
            CallableStatement stmt = conn.prepareCall(sql)) {

            stmt.registerOutParameter(1, OracleTypes.CURSOR); // out_data
            stmt.registerOutParameter(2, Types.VARCHAR);      // pesan

            stmt.execute();
            logger.info("Prosedur Jenis Laporan berhasil dieksekusi");

            try (ResultSet rs = (ResultSet) stmt.getObject(1)) {
                while (rs.next()) {
                    Map<String, Object> row = new HashMap<>();
                    row.put("kode", rs.getString("kode"));
                    row.put("laporan", rs.getString("laporan"));
                    result.add(row);
                }
            }

            String pesan = stmt.getString(2);
            pesanOutput.add(pesan);

        } catch (SQLException e) {
            logger.severe("Kesalahan database PILIH_JENIS_LAPORAN: " + e.getMessage());
            pesanOutput.add("Terjadi kesalahan koneksi ke database: " + e.getMessage());
        }

        return result;
    }

    public List<Map<String, Object>> getcombosumberdata(List<String> pesanOutput) {

        logger.info("Memanggil package combobox Sumber Data");
        List<Map<String, Object>> result = new ArrayList<>();

        String sql = "{call BPBL_SURVEY.PKG_MON_LAP_BPBLPRASURVEY.PILIH_SUMBER_DATA(?, ?)}";

        try (Connection conn = dataSource.getConnection();
            CallableStatement stmt = conn.prepareCall(sql)) {

            stmt.registerOutParameter(1, OracleTypes.CURSOR); // out_data
            stmt.registerOutParameter(2, Types.VARCHAR);      // pesan

            stmt.execute();
            logger.info("Prosedur Sumber berhasil dieksekusi");

            try (ResultSet rs = (ResultSet) stmt.getObject(1)) {
                while (rs.next()) {
                    Map<String, Object> row = new HashMap<>();
                    row.put("kode", rs.getString("kode"));
                    row.put("sumber_data", rs.getString("sumber_data"));
                    result.add(row);
                }
            }

            String pesan = stmt.getString(2);
            pesanOutput.add(pesan);

        } catch (SQLException e) {
            logger.severe("Kesalahan database PILIH_SUMBER_DATA: " + e.getMessage());
            pesanOutput.add("Terjadi kesalahan koneksi ke database: " + e.getMessage());
        }

        return result;
    }

}
