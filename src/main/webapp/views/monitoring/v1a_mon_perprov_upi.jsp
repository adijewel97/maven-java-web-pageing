<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<!-- Modal Large -->
<div class="modal fade" id="dataModal" tabindex="-1" aria-labelledby="dataModalLabel" aria-hidden="true">
  <div class="modal-dialog modal-dialog-scrollable modal-xl">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="dataModalLabel">Detail Data</h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Tutup"></button>
      </div>
      <div class="modal-body" id="modalBody">
        <div class="mb-2">
            <button id="downloadExcelBtnAll" class="btn btn-primary btn-export">Download Excel Semua Halaman</button>
        </div>

        <!-- Isi modal akan diisi via JS -->
          <div class="datatable-container">
                <table id="table_mondaf_provupi" class="datatable-main">
                    <thead>
                        <tr>
                            <th>No</th>
                            <!-- <th>TOTAL_COUNT</th>  -->
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
                            <th>STATUS_UPLOAD</th> 
                            <th>STATUS_DATA</th> 
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
                            <th>USERID_VERIFIKASI</th> 
                            <th>STATUS_VERIFIKASI</th> 
                            <th>TGL_VERIFIKASI</th> 
                            <th>STATUS_CUTOFF</th> 
                            <!-- <th>ROW_NUMBER</th>  -->
                        </tr>
                    </thead>
                </table>
          </div>          
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Tutup</button>
      </div>
    </div>
  </div>
</div>


<div class="pt-4 px-4">
    <h2 class="page-title">Monitoring Pelanggan BPBL Per Provinsi / UPI</h2>

    <div class="container mt-4">
        <div class="form-monitoring">
            <h5 class="section-title">Monitoring Per UPI / Provinsi</h5>

            <form id="form-monitoring">
                <div class="row g-3 mb-3">
                    <div class="col-md-3">
                        <label for="jenis" class="form-label">Jenis</label>
                        <select class="form-select" id="jenis" name="jenis">
                            <!-- Option akan diisi melalui JavaScript -->
                        </select>
                    </div>
                    <div class="col-md-3">
                        <label for="selectTahun" class="form-label">Tahun</label>
                        <select class="form-select" id="selectTahun" name="selectTahun">
                            <option value="2025">2025</option>
                            <option value="2024">2024</option>
                            <option value="2023">2023</option>
                            <option value="2022">2022</option>
                        </select>
                    </div>
                    <div class="col-md-3">
                        <label for="selectsumberdata" class="form-label">Sumber Data</label>
                        <select class="form-select" id="selectsumberdata" name="selectsumberdata">
                            <!-- Option akan diisi melalui JavaScript -->
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
                <button id="downloadExcelBtnPage" class="btn btn-success btn-export">Download Excel Per Halaman</button>
            </div>

            <div class="datatable-container">
                <table id="tablemon_provupi" class="datatable-main table table-bordered table-striped">
                    <thead>
                        <tr>
                            <th>URUT</th> 
                            <th>KODE</th> 
                            <th>NAMA</th> 
                            <th>TAHUN</th> 
                            <th>SUMBER_DATA</th> 
                            <th>TARGET</th> 
                            <th>TOTAL_SUMBER</th> 
                            <th>NIK_BLM_VALID</th> 
                            <th>NIK_VALID</th> 
                            <th>NIK_VALID_KOREKSI</th> 
                            <th>TOTAL_NIK_VALID</th> 
                            <th>BLM_VERIFIKASI_DJK</th> 
                            <th>VERIFIKASI_DJK_VALID</th> 
                            <th>BLM_KIRIM_PRASURVEY</th> 
                            <th>KIRIM_PRASURVEY</th> 
                            <th>BLM_CUTOFF_SURVEY</th> 
                            <th>CUTOFF_SURVEY</th> 
                            <th>PERSEN_DATAVERIFIKASI</th> 
                            <th>PERSEN_TARGET</th> 
                        </tr>
                    </thead>
                    <tbody></tbody>
                </table>
            </div>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/xlsx@0.18.5/dist/xlsx.full.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>

<script>
    $(document).ready(function () {

        // Ambil data jenis laporan
        $.ajax({
            url: '<%= request.getContextPath() %>/monperprovperupi?act=handleGetJenisLaporan',
            method: 'POST',
            dataType: 'json',
            success: function (response) {
                const jenisSelect = $('#jenis');
                jenisSelect.empty();

                const dataList = response.data || [];
                console.log("Combo Jenis Laporan:", dataList);

                // const optionsHtml = dataList.map(item =>
                //     `<option value="${item.kode}">${item.laporan}</option>`
                // ).join('');
                // jenisSelect.html(optionsHtml);
                 $.each(dataList, function (i, item) {
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

        // Ambil data sumber data
        $.ajax({
            url: '<%= request.getContextPath() %>/monperprovperupi?act=handleGetsumberdata',
            method: 'POST',
            dataType: 'json',
            success: function (response) {
                const sumberDataSelect = $('#selectsumberdata');
                sumberDataSelect.empty();

                const dataList = response.data || [];
                console.log("Combo Sumber Data:", dataList);

                 $.each(dataList, function (i, item) {
                    sumberDataSelect.append($('<option>', {
                        value: item.kode,
                        text: item.sumber_data                    
                    }));
                });
            },
            error: function (xhr, status, error) {
                console.error('Gagal mengambil data combo sumber data:', error);
                alert('Gagal mengambil data combo sumber data:', error);
            }
        });

        // Inisialisasi DataTable
        const table = $('#tablemon_provupi').DataTable({
            processing: true,
            serverSide: true,
            scrollX: true,
            paging: false, // MATIKAN PAGING
            stripeClasses: [], // Nonaktifkan efek baris selang-seling
            ajax: {
                url: '<%= request.getContextPath() %>/monperprovperupi',
                type: 'POST',
                timeout: 10000, // 20 detik
                data: function (d) {
                    d.vkd_sumberdata = $('#selectsumberdata').val();
                    d.vtahun         = $('#selectTahun').val();
                },
                dataSrc: function (json) {
                    console.log('Response JSON:', json);
                    return json.data;
                },
                error: function (xhr, error, thrown) {
                    console.error('Status:', xhr.status);
                    console.error('Error thrown:', error);
                    console.error('Response:', xhr.responseText);

                    if (error === 'timeout') {
                        alert('Permintaan data melebihi waktu tunggu 10 detik. Silakan periksa koneksi atau coba lagi nanti.');
                    } else {
                        alert('Terjadi kesalahan saat memuat data: ' + error);
                    }
                }
            },
            columns: [
                {data: 'URUT', visible: false}, // ini untuk logika styling
                {data: 'KODE',  defaultContent: ''},
                {data: 'NAMA',  defaultContent: ''},
                {data: 'TAHUN',  defaultContent: ''},
                {data: 'SUMBER_DATA',  defaultContent: '-'},
                {data: 'TARGET',  defaultContent: '-'},
                {data: 'TOTAL_SUMBER',  defaultContent: '-'},
                {data: 'NIK_BLM_VALID',  defaultContent: '-'},
                {data: 'NIK_VALID',  defaultContent: '-'},
                {data: 'NIK_VALID_KOREKSI',  defaultContent: '-'},
                {data: 'TOTAL_NIK_VALID',  defaultContent: '-'},
                {data: 'BLM_VERIFIKASI_DJK',  defaultContent: '-'},
                {data: 'VERIFIKASI_DJK_VALID',  defaultContent: '-'},
                {data: 'BLM_KIRIM_PRASURVEY',  defaultContent: '-'},
                {data: 'KIRIM_PRASURVEY',  defaultContent: '-'},
                {data: 'BLM_CUTOFF_SURVEY',  defaultContent: '-'},
                {data: 'CUTOFF_SURVEY',  defaultContent: '-'},
                {data: 'PERSEN_DATAVERIFIKASI',  defaultContent: '-'},
                {data: 'PERSEN_TARGET',  defaultContent: '-'}
            ],
            createdRow: function (row, data, dataIndex) {
                if (data.URUT == 2) {
                    $('td', row).css({ 'font-weight': 'bold' });  
                } 

                $('td', row).each(function (colIndex) {
                    const columnName = table.column(colIndex+1).dataSrc();
                    const cellValue  = data[columnName];
                    const vidkd_sumberdata  = $('#selectsumberdata').val();
                    const vidjenis          = $('#jenis').val();
                        
                    // Tambahkan event klik seperti sebelumnya
                    const allowedColumns = ['KODE', 'NAMA', 'TAHUN', 'TARGET', 'SUMBER_DATA','PERSEN_DATAVERIFIKASI','PERSEN_TARGET'];
                    if (!allowedColumns.includes(columnName) && (!isNaN(cellValue) && Number(cellValue) > 0)) {
                        $(this).css({
                            'cursor': 'pointer',
                            'text-decoration': 'underline',
                            'color': 'blue'
                        }).on('click', function () {
                            $('#dataModalLabel').text('Detail: ' + columnName);

                        if (data.URUT == 1) {
                            xvtahun      = data.TAHUN,
                            xvidoption   = data.KODE;
                            xvidkolektif = data.kolektif;
                        } 
                        else  if (data.URUT == 2) {
                            xvtahun      = $('#selectTahun').val(),
                            xvidoption   = '';
                            xvidkolektif = '';
                        }

                        detailFilterParams = {
                            vidurut: data.URUT,
                            vkd_sumberdata: data.SUMBER_DATA == 'DAPIL/PEMDA' ? '' : $('#selectsumberdata').val(),
                            vtahun: xvtahun,
                            vdata: columnName,
                            voption: $('#jenis').val(),
                            vidoption: xvidoption,
                            vidkolektif: xvidkolektif
                        };
                        console.log(detailFilterParams);

                        $('#dataModal').modal('show');
                        });
                    }
                });
            },
            dom: 'lfrtip',
            buttons: [
                {
                    extend: 'excel',
                    title: function () {
                        const jenis = $('#jenis').val() || 'JENIS';
                        const tahun = $('#selectTahun').val() || 'TAHUN';
                        return 'REKAP_BPBL_' + jenis + '_' + tahun;
                        },
                    className: 'd-none',
                    exportOptions: {
                        // columns: ':visible'
                        columns: [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18] // skip kolom ke-0 (URUT)
                    }
                }
            ]
        });

        // Tombol Tampil
        $('#btnTampil').click(function () {
            table.ajax.reload(null, true);
        });

        // Reload table saat filter berubah
        $('#jenis, #selectdata, #selectTahun, #selectsumberdata').on('change', function () {
            table.ajax.reload();
        });

        // Ekspor halaman aktif ke Excel
        $('#downloadExcelBtnPage').on('click', function () {
            table.button('.buttons-excel').trigger();
        });

        // ---------------------------------------------------------------------------------------------
        // show Data Detail/Daftar PerProv/PerUpi Modal Large 
        // ---------------------------------------------------------------------------------------------
        $('#dataModal').on('shown.bs.modal', function () {
            if ($.fn.DataTable.isDataTable('#table_mondaf_provupi')) {
                $('#table_mondaf_provupi').DataTable().clear().destroy();
                // $('#table_mondaf_provupi').empty();
            }

            console.log('parameter :'+detailFilterParams);

            $('#table_mondaf_provupi').DataTable({
                processing: true,
                serverSide: true,
                scrollX: true,
                paging: true,
                ajax: {
                    url: '<%= request.getContextPath() %>/bpbl',
                    type: 'POST',
                    data: function (d) {
                        return Object.assign(d, detailFilterParams); // gabungkan dengan parameter datatable
                    },
                    dataSrc: function (json) {
                        console.log('Response JSON:', json);
                        return json.data;
                    }
                },
                columns: [
                            {
                                data: null,
                                render: function (data, type, row, meta) {
                                    return meta.row + 1 + meta.settings._iDisplayStart;
                                }
                            },
                            ...[
                                // "TOTAL_COUNT", 
                                "DATA", 
                                "ID_KOLEKTIF", 
                                "IDURUT_BPBL", 
                                "TANGGAL_USULAN", 
                                "KODE_PENGUSUL", 
                                "NAMA_PELANGGAN", 
                                "NIK", 
                                "ALAMAT", 
                                "KD_PROV", 
                                "KD_PROV_USULAN", 
                                "PROVINSI", 
                                "PROVINSI_USULAN", 
                                "KD_KAB", 
                                "KD_KAB_USULAN", 
                                "KABUPATENKOTA", 
                                "KABUPATENKOTA_USULAN", 
                                "KD_KEC", 
                                "KD_KEC_USULAN", 
                                "KECAMATAN", 
                                "KECAMATAN_USULAN", 
                                "KD_KEL", 
                                "KD_KEL_USULAN", 
                                "DESAKELURAHAN", 
                                "DESAKELURAHAN_USULAN", 
                                "UNITUPI", 
                                "NAMA_UNITUPI", 
                                "UNITAP", 
                                "NAMA_UNITAP", 
                                "UNITUP", 
                                "NAMA_UNITUP", 
                                "STATUS_UPLOAD", 
                                "STATUS_DATA", 
                                "USER_ID", 
                                "TGL_UPLOAD", 
                                "NAMA_FILE_UPLOAD", 
                                "PATH_FILE", 
                                "DOKUMEN_UPLOAD", 
                                "PATH_DOKUMEN", 
                                "SURAT_VALDES", 
                                "PRIORITAS", 
                                "VERIFIKASI_DJK", 
                                "SUMBER_DATA", 
                                "KETERANGAN", 
                                "TAHUN", 
                                "TGL_KOREKSI", 
                                "USERID_KOREKSI", 
                                "NAMA_FILE_KOREKSI", 
                                "PATH_FILE_KOREKSI", 
                                "USERID_VERIFIKASI", 
                                "STATUS_VERIFIKASI", 
                                "TGL_VERIFIKASI", 
                                "STATUS_CUTOFF", 
                                // "ROW_NUMBER", 
                            ].map(field => ({
                                data: field,
                                defaultContent: '-',
                                render: function (data, type, row) {
                                    return typeof data === 'string' ? data.toUpperCase() : data;
                                }
                            }))
                        ],
                lengthMenu: [[10, 100], [10, 100]],
                pageLength: 10,
                dom: 'lfrtip'
            });
        });
        
        // ---------------------------------------------------------------------------------------------
        // export exel all record all page
        // ---------------------------------------------------------------------------------------------
        $('#downloadExcelBtnAll').on('click', async function () {
            const btn = $(this);

            const vtahun    = detailFilterParams.vtahun;
            const vdata     = detailFilterParams.vdata;
            const voption   = detailFilterParams.voption;
            const vidoption = detailFilterParams.vidoption;

            if (!vtahun || !vdata || !voption ) {
                alert('Silakan pilih Tahun, Jenis, dan Kriteria Data terlebih dahulu!');
                return;
            }

            const info = table.page.info();
            const start = info.start;
            const length = info.length;

            btn.prop('disabled', true).text('Memuat...');

            try {
                const baseUrl = window.location.origin;
                const url = baseUrl + "<%= request.getContextPath() %>/bpbl";

                const params = new URLSearchParams();
                params.append('start', start);
                params.append('length', length);
                params.append('all', 'true');
                params.append('vtahun', vtahun);
                params.append('vdata', vdata);
                params.append('voption', voption);
                params.append('vidoption', vidoption);

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

                const headers = {
                    'NO': '',
                    // 'TOTAL_COUNT': '',
                    'DATA': '',
                    'ID_KOLEKTIF': '',
                    'IDURUT_BPBL': '',
                    'TANGGAL_USULAN': '',
                    'KODE_PENGUSUL': '',
                    'NAMA_PELANGGAN': '',
                    'NIK': '',
                    'ALAMAT': '',
                    'KD_PROV': '',
                    'KD_PROV_USULAN': '',
                    'PROVINSI': '',
                    'PROVINSI_USULAN': '',
                    'KD_KAB': '',
                    'KD_KAB_USULAN': '',
                    'KABUPATENKOTA': '',
                    'KABUPATENKOTA_USULAN': '',
                    'KD_KEC': '',
                    'KD_KEC_USULAN': '',
                    'KECAMATAN': '',
                    'KECAMATAN_USULAN': '',
                    'KD_KEL': '',
                    'KD_KEL_USULAN': '',
                    'DESAKELURAHAN': '',
                    'DESAKELURAHAN_USULAN': '',
                    'UNITUPI': '',
                    'NAMA_UNITUPI': '',
                    'UNITAP': '',
                    'NAMA_UNITAP': '',
                    'UNITUP': '',
                    'NAMA_UNITUP': '',
                    'STATUS_UPLOAD': '',
                    'STATUS_DATA': '',
                    'USER_ID': '',
                    'TGL_UPLOAD': '',
                    'NAMA_FILE_UPLOAD': '',
                    'PATH_FILE': '',
                    'DOKUMEN_UPLOAD': '',
                    'PATH_DOKUMEN': '',
                    'SURAT_VALDES': '',
                    'PRIORITAS': '',
                    'VERIFIKASI_DJK': '',
                    'SUMBER_DATA': '',
                    'KETERANGAN': '',
                    'TAHUN': '',
                    'TGL_KOREKSI': '',
                    'USERID_KOREKSI': '',
                    'NAMA_FILE_KOREKSI': '',
                    'PATH_FILE_KOREKSI': '',
                    'USERID_VERIFIKASI': '',
                    'STATUS_VERIFIKASI': '',
                    'TGL_VERIFIKASI': '',
                    'STATUS_CUTOFF': '',
                    // 'ROW_NUMBER': ''
                };

                const formattedData = allData.length > 0
                    ? allData.map((item) => {
                        const row = {};
                        Object.keys(headers).forEach((key) => {
                            const value = item[key];
                            row[key] = (typeof value === 'string') ? value.toUpperCase() : value;
                        });
                        row['NO'] = item.ROW_NUMBER; // Tetap gunakan nomor urut asli
                        return row;
                    })
                    : [];

                const ws = XLSX.utils.json_to_sheet(formattedData, { header: Object.keys(headers) });
                const wb = XLSX.utils.book_new();
                XLSX.utils.book_append_sheet(wb, ws, "BPBL Semua Data");

                const filename = "BPBL_" + voption + "_" + vdata + "_" + vtahun + ".xlsx";
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
