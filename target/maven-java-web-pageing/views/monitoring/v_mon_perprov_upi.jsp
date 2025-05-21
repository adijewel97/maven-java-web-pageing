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
                            <option value="PROVINSI">PROVINSI</option>
                            <option value="UPI">UPI</option>
                            <option value="PENGUSUL">PENGUSUL</option>
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

            <table id="bpblTable" class="table table-bordered table-hover nowrap" style="width:100%">
                <thead class="table-dark">
                    <tr>
                        <th>No</th>
                        <th>DATA</th>
                        <th>ID_KOLEKTIF</th>
                        <th>NAMA_PELANGGAN</th>
                        <th>UNITUP</th>
                        <th>KD_PROV</th>
                        <th>PROVINSI</th>
                    </tr>
                </thead>
            </table>
        </div>
    </div>
</div>

<!-- SheetJS untuk export Excel -->
<script src="https://cdn.jsdelivr.net/npm/xlsx@0.18.5/dist/xlsx.full.min.js"></script>

<script>
    $(document).ready(function () {
        var table = $('#bpblTable').DataTable({
            responsive: true,
            processing: true,
            serverSide: true,
            ajax: {
                url: '<%= request.getContextPath() %>/bpbl',
                type: 'GET',
                data: function (d) {
                    d.vtahun  = $('#selectTahun').val();
                    d.voption = $('#jenis').val();
                    d.vdata   = $('#selectdata').val();
                },
                dataSrc: 'data',
                error: function (xhr, error, thrown) {
                    console.error('Gagal load data:', error, thrown);
                }
            },
            columns: [
                {
                    data: null,
                    render: function (data, type, row, meta) {
                        return meta.row + 1 + meta.settings._iDisplayStart;
                    }
                },
                {data: 'DATA', defaultContent: '-'},
                {data: 'ID_KOLEKTIF', defaultContent: '-'},
                {data: 'NAMA_PELANGGAN', defaultContent: '-'},
                {data: 'UNITUP', defaultContent: '-'},
                {data: 'KD_PROV', defaultContent: '-'},
                {data: 'PROVINSI', defaultContent: '-'}
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
            table.ajax.reload(null, true); // reload dan reset ke halaman pertama
        });

        $('#downloadExcelBtnPage').on('click', function () {
            table.button('.buttons-excel').trigger();
        });

        $('#downloadExcelBtnAll').on('click', async function () {
            const btn = $(this);

            // Ambil nilai dari input/select, bukan dari variabel EL JSP
            const vtahun  = $('#selectTahun').val();
            const voption = $('#jenis').val();
            const vdata   = $('#selectdata').val();

            if (!vtahun || !voption || !vdata) {
                alert('Silakan pilih Tahun, Jenis, dan Kriteria Data terlebih dahulu!');
                return;
            }

            // Ambil info paging dari datatable
            const info = table.page.info();
            const start = info.start;       // index data mulai (misal 0, 10, 20, ...)
            const length = info.length;     // panjang halaman (berapa data per page)

            btn.prop('disabled', true).text('Memuat...');

            try {
                // Panggil API dengan parameter yang benar dan dinamis
                // const url = "http://localhost:8080/bpbl?all=true&vtahun=2025&voption="PROVINSI"&vdata=TOTAL_SUMBER&start=0&length=10";
                const baseUrl = window.location.origin; // hasilnya misalnya: "http://localhost:8080"
                const url =  baseUrl + "/bpbl?all=true&vtahun="+vtahun+"&voption="+voption+"&vdata="+vdata+"&start="+start+"&length="+length;
                console.log("url : "+url);
                const response = await fetch(url);

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
                    'NO': index + 1,
                    'TOTAL': parseInt(item.TOTAL_COUNT || 0),
                    'TAHUN': vtahun,
                    'KATEGORI': item.DATA,
                    'ID Kolektif': item.ID_KOLEKTIF,
                    'NAMA_PELANGGAN': item.NAMA_PELANGGAN,
                    'UNITUP': item.UNITUP,
                    'KD_PROV': item.KD_PROV,
                    'PROVINSI': item.PROVINSI
                }));

                const ws = XLSX.utils.json_to_sheet(formattedData);
                const wb = XLSX.utils.book_new();
                XLSX.utils.book_append_sheet(wb, ws, "BPBL Semua Data");

                const filename = `BPBL_${voption}_${vdata}_${vtahun}.xlsx`;
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

