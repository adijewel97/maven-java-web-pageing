<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Data Pelanggan BPBL</title>

    <!-- Bootstrap 5 CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.datatables.net/1.13.5/css/jquery.dataTables.min.css">
    <link rel="stylesheet" href="https://cdn.datatables.net/responsive/2.5.0/css/responsive.dataTables.min.css">
</head>
<body>
<div class="container mt-5">
    <h2 class="mb-4">Data Pelanggan BPBL</h2>

    <div class="mb-3 row align-items-center">
        <label for="selectTahun" class="col-sm-2 col-form-label">Pilih Tahun:</label>
        <div class="col-sm-3">
            <select id="selectTahun" class="form-select">
                <option value="2022">2022</option>
                <option value="2024">2024</option>
                <option value="2025" selected>2025</option>
            </select>
        </div>

        <label for="selectOption" class="col-sm-2 col-form-label">Pilih Option:</label>
        <div class="col-sm-3">
            <select id="selectOption" class="form-select">
                <option value="PROVINSI" selected>PROVINSI</option>
                <option value="UPI">UPI</option>
            </select>
        </div>

        <div class="col-sm-2">
            <button id="btnTampil" class="btn btn-primary">Tampilkan</button>
        </div>
    </div>

    <table id="bpblTable" class="display table table-bordered table-hover nowrap" style="width:100%">
        <thead class="table-dark">
        <tr>
            <th>No</th>
            <th>DATA</th>
            <th>ID_KOLEKTIF</th>
            <th>NAMA_PELANGGAN</th>
            <th>UNITUP</th>
            <th>PROVINSI</th>
        </tr>
        </thead>
    </table>
</div>

<!-- JS -->
<script src="https://code.jquery.com/jquery-3.7.0.min.js"></script>
<script src="https://cdn.datatables.net/1.13.5/js/jquery.dataTables.min.js"></script>
<script src="https://cdn.datatables.net/responsive/2.5.0/js/dataTables.responsive.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

<script>
    $(document).ready(function () {
        let table = $('#bpblTable').DataTable({
            responsive: true,
            processing: true,
            serverSide: true,
            ajax: {
                url: '<%= request.getContextPath() %>/bpbl',
                type: 'GET',
                data: function (d) {
                    d.vtahun = $('#selectTahun').val();
                    d.voption = $('#selectOption').val();
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
                {data: 'PROVINSI', defaultContent: '-'}
            ],
            language: {
                emptyTable: "Tidak ada data tersedia",
                zeroRecords: "Data tidak ditemukan"
            },
            // Jangan load data otomatis saat inisialisasi
            deferLoading: 0,
            searching: false
        });

        // Klik tombol Tampilkan untuk reload data
        $('#btnTampil').click(function () {
            table.ajax.reload();
        });
    });
</script>
</body>
</html>
