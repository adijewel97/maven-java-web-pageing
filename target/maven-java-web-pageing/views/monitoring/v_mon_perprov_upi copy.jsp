<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<div class="pt-4 px-4">
    <h2 class="mb-4">Data Pelanggan BPBL Per Provinsi / UPI</h2>

    <div class="container mt-4">
        <div class="border rounded p-4 shadow-sm">
            <h5 class="fw-bold mb-4">Monitoring Temuan Baru Per UPI / Provinsi</h5>

            <form id="form-monitoring">
                <div class="row g-3 mb-3">
                    <div class="col-md-4">
                        <label for="jenis" class="form-label">Jenis</label>
                        <select class="form-select" id="jenis" name="jenis">
                        </select>
                    </div>
                    <div class="col-md-4">
                        <label for="selectdata" class="form-label">Kriteria Data</label>
                        <select id="selectdata" class="form-select">
                            <option value="TOTAL_SUMBER">TOTAL SUMBER</option>
                            <option value="NIK_BLM_VALID">NIK BELUM VALID</option>
                            <option value="NIK_VALID">NIK VALID</option>
                            <option value="NIK_VALID_KOREKSI">NIK VALID KOREKSI</option>
                            <option value="BLM_VERIFIKASI_DJK">BELUM VERIFIKASI DJK</option>
                            <option value="VERIFIKASI_DJK">VERIFIKASI DJK</option>
                        </select>
                    </div>
                    <div class="col-md-4">
                        <label for="selectTahun" class="form-label">Tahun</label>
                        <select class="form-select" id="selectTahun" name="selectTahun">
                            <option value="2025">2025</option>
                            <option value="2024">2024</option>
                            <option value="2023">2023</option>
                        </select>
                    </div>
                </div>                

                <div class="row">
                    <div class="col-md-12 text-start">
                        <button id="btnTampil" type="button" class="btn btn-primary">
                            <i class="bi bi-search"></i> Tampilkan
                        </button>
                    </div>
                </div>
            </form>
        </div>

        <div class="mt-4">
            <div class="mb-2">
                <button id="downloadExcelBtnPage" class="btn btn-success mb-3">Download Excel Per Halaman</button>
                <button id="downloadExcelBtnAll" class="btn btn-primary mb-3">Download Excel Semua Halaman</button>
            </div>

            <div class="data-tables">
                <table id="bpblTable" class="table table-bordered table-hover nowrap  w-100">
                    <thead class="table-dark">
                        <tr>
                            <th>NO</th> 
                            <th>TOTAL_COUNT</th> 
                            <th>DATA</th> 
                            <th>ID_KOLEKTIF</th> 
                            <th>IDURUT_BPBL</th> 
                            <th>TANGGAL_USULAN</th> 
                            <th>KODE_PENGUSUL</th> 
                            <th>NAMA_PELANGGAN</th> 
                            <th>NIK</th> 
                            <th>ALAMAT</th> 
                            <th>KD_PROV</th> 
                            <th>KD_PROV_USULAN</th> 
                            <th>PROVINSI</th> 
                            <th>PROVINSI_USULAN</th> 
                            <th>KD_KAB</th> 
                            <th>KD_KAB_USULAN</th> 
                            <th>KABUPATENKOTA</th> 
                            <th>KABUPATENKOTA_USULAN</th> 
                            <th>KD_KEC</th> 
                            <th>KD_KEC_USULAN</th> 
                            <th>KECAMATAN</th> 
                            <th>KECAMATAN_USULAN</th> 
                            <th>KD_KEL</th> 
                            <th>KD_KEL_USULAN</th> 
                            <th>DESAKELURAHAN</th> 
                            <th>DESAKELURAHAN_USULAN</th> 
                            <th>UNITUPI</th> 
                            <th>NAMA_UNITUPI</th> 
                            <th>UNITAP</th> 
                            <th>NAMA_UNITAP</th> 
                            <th>UNITUP</th> 
                            <th>NAMA_UNITUP</th> 
                            <th>STATUS</th> 
                            <th>USER_ID</th> 
                            <th>TGL_UPLOAD</th> 
                            <th>NAMA_FILE_UPLOAD</th> 
                            <th>PATH_FILE</th> 
                            <th>DOKUMEN_UPLOAD</th> 
                            <th>PATH_DOKUMEN</th> 
                            <th>SURAT_VALDES</th> 
                            <th>PRIORITAS</th> 
                            <th>VERIFIKASI_DJK</th> 
                            <th>SUMBER_DATA</th> 
                            <th>KETERANGAN</th> 
                            <th>TAHUN</th> 
                            <th>TGL_KOREKSI</th> 
                            <th>USERID_KOREKSI</th> 
                            <th>NAMA_FILE_KOREKSI</th> 
                            <th>PATH_FILE_KOREKSI</th> 
                            <th>ROW_NUMBER</th> 
                        </tr>
                    </thead>
                </table>
            </div>
        
        </div>
    </div>
</div>

<!-- SheetJS untuk export Excel -->
<script src="https://cdn.jsdelivr.net/npm/xlsx@0.18.5/dist/xlsx.full.min.js"></script>

<script>
    $(document).ready(function () {
        // perahtikan index kolom di controler KD_PROV = 9, DATA = 0
        // String[] columns = {
        //     "DATA", "ID_KOLEKTIF", "IDURUT_BPBL", "TANGGAL_USULAN", "KODE_PENGUSUL",
        //     "NAMA_PELANGGAN", "NIK", "ALAMAT", "UNITUPI", "KD_PROV",
        //     "KD_PROV_USULAN", "PROVINSI"
        // };
        var orderColumnMap = {
            'PROVINSI': 12,  // Kolom PROVINSI index ke-12 (0 based)
            'UPI': 25,       // Kolom UNITUPI index ke-25
            'PENGUSUL': 6    // KODE_PENGUSUL index ke-6
        };

        // Panggil controller saat halaman dimuat
        $.ajax({
            url: '<%= request.getContextPath() %>/bpbl?act=handleGetJenisLaporan', // sesuaikan path dan param
            method: 'POST',
            dataType: 'json',
            success: function (response) {
                var jenisSelect = $('#jenis');
                jenisSelect.empty(); // kosongkan dulu

                var dataList = response.data || [];
                console.log("combo 1");
                console.log(dataList);

                // Tambahkan opsi ke combo box
                $.each(dataList, function (i, item) {
                    // Misalnya item punya field 'id' dan 'nama'
                    jenisSelect.append($('<option>', {
                        value: item.kode,
                        text: item.laporan                    
                    }));
                });
            },
            error: function (xhr, status, error) {
                console.error('Gagal mengambil data combo jenis laporan:', error);
            }
        });

        $.ajax({
            url: '<%= request.getContextPath() %>/bpbl?act=handleGetsumberdata', // sesuaikan path dan param
            method: 'POST',
            dataType: 'json',
            success: function (response) {
                var jenisSelect = $('#selectsumberdata');
                jenisSelect.empty(); // kosongkan dulu

                var dataList = response.data || [];
                console.log("combo 2");
                console.log(dataList);

                // Tambahkan opsi ke combo box
                $.each(dataList, function (i, item) {
                    // Misalnya item punya field 'id' dan 'nama'
                    jenisSelect.append($('<option>', {
                        value: item.kode,
                        text: item.sumber_data                    
                    }));
                });
            },
            error: function (xhr, status, error) {
                console.error('Gagal mengambil data combo jenis laporan:', error);
            }
        });
        
        var table = $('#bpblTable').DataTable({
            responsive: true,
            processing: true,
            serverSide: true,
            ajax: {
                url: '<%= request.getContextPath() %>/bpbl',
                type: 'POST',
                data: function (d) {
                    d.vtahun  = $('#selectTahun').val();
                    d.voption = $('#jenis').val();
                    d.vdata   = $('#selectdata').val();
                },
                // dataSrc: 'data',
                dataSrc: function (json) {
                    console.log('Response JSON:', json); // cek data yang diterima
                    return json.data;
                },
                error: function (xhr, error, thrown) {
                    console.error('Status:', status);
                    console.error('Error thrown:', error);
                    console.error('Response:', xhr.responseText);
                }
                
            },
            columns: [
                {
                    data: null,
                    render: function (data, type, row, meta) {
                        return meta.row + 1 + meta.settings._iDisplayStart;
                    }
                },
                {data: 'TOTAL_COUNT',  defaultContent: '-'},
                {data: 'DATA',  defaultContent: '-'},
                {data: 'ID_KOLEKTIF',  defaultContent: '-'},
                {data: 'IDURUT_BPBL',  defaultContent: '-'},
                {data: 'TANGGAL_USULAN',  defaultContent: '-'},
                {data: 'KODE_PENGUSUL',  defaultContent: '-'},
                {data: 'NAMA_PELANGGAN',  defaultContent: '-'},
                {data: 'NIK',  defaultContent: '-'},
                {data: 'ALAMAT',  defaultContent: '-'},
                {data: 'KD_PROV',  defaultContent: '-'},
                {data: 'KD_PROV_USULAN',  defaultContent: '-'},
                {data: 'PROVINSI',  defaultContent: '-'},
                {data: 'PROVINSI_USULAN',  defaultContent: '-'},
                {data: 'KD_KAB',  defaultContent: '-'},
                {data: 'KD_KAB_USULAN',  defaultContent: '-'},
                {data: 'KABUPATENKOTA',  defaultContent: '-'},
                {data: 'KABUPATENKOTA_USULAN',  defaultContent: '-'},
                {data: 'KD_KEC',  defaultContent: '-'},
                {data: 'KD_KEC_USULAN',  defaultContent: '-'},
                {data: 'KECAMATAN',  defaultContent: '-'},
                {data: 'KECAMATAN_USULAN',  defaultContent: '-'},
                {data: 'KD_KEL',  defaultContent: '-'},
                {data: 'KD_KEL_USULAN',  defaultContent: '-'},
                {data: 'DESAKELURAHAN',  defaultContent: '-'},
                {data: 'DESAKELURAHAN_USULAN',  defaultContent: '-'},
                {data: 'UNITUPI',  defaultContent: '-'},
                {data: 'NAMA_UNITUPI',  defaultContent: '-'},
                {data: 'UNITAP',  defaultContent: '-'},
                {data: 'NAMA_UNITAP',  defaultContent: '-'},
                {data: 'UNITUP',  defaultContent: '-'},
                {data: 'NAMA_UNITUP',  defaultContent: '-'},
                {data: 'STATUS',  defaultContent: '0'},
                {data: 'USER_ID',  defaultContent: '-'},
                {data: 'TGL_UPLOAD',  defaultContent: '-'},
                {data: 'NAMA_FILE_UPLOAD',  defaultContent: '-'},
                {data: 'PATH_FILE',  defaultContent: '-'},
                {data: 'DOKUMEN_UPLOAD',  defaultContent: '-'},
                {data: 'PATH_DOKUMEN',  defaultContent: '-'},
                {data: 'SURAT_VALDES',  defaultContent: '-'},
                {data: 'PRIORITAS',  defaultContent: '-'},
                {data: 'VERIFIKASI_DJK',  defaultContent: '-'},
                {data: 'SUMBER_DATA',  defaultContent: '-'},
                {data: 'KETERANGAN',  defaultContent: '-'},
                {data: 'TAHUN',  defaultContent: '-'},
                {data: 'TGL_KOREKSI',  defaultContent: '-'},
                {data: 'USERID_KOREKSI',  defaultContent: '-'},
                {data: 'NAMA_FILE_KOREKSI',  defaultContent: '-'},
                {data: 'PATH_FILE_KOREKSI',  defaultContent: '-'},
                {data: 'ROW_NUMBER',  defaultContent: '-'}
            ],
            lengthMenu: [[10, 100, 5000], [10, 100, 5000]],
            pageLength: 10,
            dom: 'lfrtip',
            buttons: [
                {
                    extend: 'excel',
                    title: 'Daftar BPBL',
                    className: 'd-none',
                    exportOptions: {
                        columns: ':visible'
                    }
                }
            ]
        });

        $('#btnTampil').click(function () {
            table.ajax.reload(null, true); // true = reset ke halaman pertama
        });

        // reload otomatis saat pilihan combo diganti
        $('#jenis, #selectdata, #selectTahun, #selectsumberdata').on('change', function () {
            table.ajax.reload();
        });

        $('#downloadExcelBtnPage').on('click', function () {
            table.button('.buttons-excel').trigger();
        });

        $('#downloadExcelBtnAll').on('click', async function () {
            const btn = $(this);

            // Ambil nilai input/select
            const vtahun  = $('#selectTahun').val();
            const voption = $('#jenis').val();
            const vdata   = $('#selectdata').val();

            if (!vtahun || !voption || !vdata) {
                alert('Silakan pilih Tahun, Jenis, dan Kriteria Data terlebih dahulu!');
                return;
            }

            // Ambil info paging dari datatable
            const info = table.page.info();
            const start = info.start;
            const length = info.length;

            btn.prop('disabled', true).text('Memuat...');

            try {
                const baseUrl = window.location.origin;
                const url = baseUrl + "/bpbl";

                // Siapkan parameter POST (form-urlencoded)
                const params = new URLSearchParams();
                params.append('all', 'true');
                params.append('vtahun', vtahun);
                params.append('voption', voption);
                params.append('vdata', vdata);
                params.append('start', start);
                params.append('length', length);

                const response = await fetch(url, {
                    method: 'POST',
                    headers: {
                        'Content-Type': 'application/x-www-form-urlencoded',
                    },
                    body: params.toString()
                });

                if (!response.ok) {
                    throw new Error('Gagal mengambil data dari server');
                }

                const json = await response.json();
                const allData = json.data || [];

                if (allData.length === 0) {
                    alert('Data kosong, tidak bisa diekspor!');
                    return;
                }

                // Format data untuk Excel
                const formattedData = allData.map((item, index) => ({
                    'NO': item.ROW_NUMBER, //index + 1,
                    // 'TOTAL_COUNT': item.TOTAL_COUNT,
                    'DATA': item.DATA,
                    'ID_KOLEKTIF': item.ID_KOLEKTIF,
                    'IDURUT_BPBL': item.IDURUT_BPBL,
                    'TANGGAL_USULAN': item.TANGGAL_USULAN,
                    'KODE_PENGUSUL': item.KODE_PENGUSUL,
                    'NAMA_PELANGGAN': item.NAMA_PELANGGAN,
                    'NIK': item.NIK,
                    'ALAMAT': item.ALAMAT,
                    'KD_PROV': item.KD_PROV,
                    'KD_PROV_USULAN': item.KD_PROV_USULAN,
                    'PROVINSI': item.PROVINSI,
                    'PROVINSI_USULAN': item.PROVINSI_USULAN,
                    'KD_KAB': item.KD_KAB,
                    'KD_KAB_USULAN': item.KD_KAB_USULAN,
                    'KABUPATENKOTA': item.KABUPATENKOTA,
                    'KABUPATENKOTA_USULAN': item.KABUPATENKOTA_USULAN,
                    'KD_KEC': item.KD_KEC,
                    'KD_KEC_USULAN': item.KD_KEC_USULAN,
                    'KECAMATAN': item.KECAMATAN,
                    'KECAMATAN_USULAN': item.KECAMATAN_USULAN,
                    'KD_KEL': item.KD_KEL,
                    'KD_KEL_USULAN': item.KD_KEL_USULAN,
                    'DESAKELURAHAN': item.DESAKELURAHAN,
                    'DESAKELURAHAN_USULAN': item.DESAKELURAHAN_USULAN,
                    'UNITUPI': item.UNITUPI,
                    'NAMA_UNITUPI': item.NAMA_UNITUPI,
                    'UNITAP': item.UNITAP,
                    'NAMA_UNITAP': item.NAMA_UNITAP,
                    'UNITUP': item.UNITUP,
                    'NAMA_UNITUP': item.NAMA_UNITUP,
                    'STATUS': item.STATUS,
                    'USER_ID': item.USER_ID,
                    'TGL_UPLOAD': item.TGL_UPLOAD,
                    'NAMA_FILE_UPLOAD': item.NAMA_FILE_UPLOAD,
                    'PATH_FILE': item.PATH_FILE,
                    'DOKUMEN_UPLOAD': item.DOKUMEN_UPLOAD,
                    'PATH_DOKUMEN': item.PATH_DOKUMEN,
                    'SURAT_VALDES': item.SURAT_VALDES,
                    'PRIORITAS': item.PRIORITAS,
                    'VERIFIKASI_DJK': item.VERIFIKASI_DJK,
                    'SUMBER_DATA': item.SUMBER_DATA,
                    'KETERANGAN': item.KETERANGAN,
                    'TAHUN': item.TAHUN,
                    'TGL_KOREKSI': item.TGL_KOREKSI,
                    'USERID_KOREKSI': item.USERID_KOREKSI,
                    'NAMA_FILE_KOREKSI': item.NAMA_FILE_KOREKSI,
                    'PATH_FILE_KOREKSI': item.PATH_FILE_KOREKSI,
                    // 'ROW_NUMBER': item.ROW_NUMBER
                }));

                const ws = XLSX.utils.json_to_sheet(formattedData);
                const wb = XLSX.utils.book_new();
                XLSX.utils.book_append_sheet(wb, ws, "BPBL Semua Data");

                const filename = "BPBL_"+voption+"_"+vdata+"_"+vtahun+".xlsx";
                XLSX.writeFile(wb, filename);

            } catch (error) {
                alert('Terjadi kesalahan saat mengambil data: ' + error.message);
                console.error('Detail error:', error);
            } finally {
                btn.prop('disabled', false).text('Download Excel Semua Halaman');
            }
        });

    });
</script>

