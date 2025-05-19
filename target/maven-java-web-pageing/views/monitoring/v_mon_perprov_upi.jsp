<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<div class="pt-4 px-4">
    <h2 class="mb-4">Data Pelanggan BPBL PerProvinsi/PerUPI</h2>

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

<script>
    $(document).ready(function () {
        $('#bpblTable').DataTable({
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
            searching: false,
            lengthMenu: [[10, 100, 5000], [10, 100, 5000]],
            pageLength: 10,

            // ✅ Tambahkan struktur dom agar tombol di atas length menu
            dom: 'B<"top"l>frtip',

            buttons: [
                {
                    extend: 'excelHtml5',
                    text: 'Export Excel',
                    titleAttr: 'Export ke Excel',
                    exportOptions: {
                        columns: ':visible'
                    }
                }
            ],

            language: {
                lengthMenu: "Tampilkan _MENU_ entri per halaman",
                emptyTable: "Tidak ada data tersedia",
                zeroRecords: "Data tidak ditemukan",
                info: "Menampilkan _START_ sampai _END_ dari _TOTAL_ entri",
                infoEmpty: "Menampilkan 0 sampai 0 dari 0 entri",
                infoFiltered: "(difilter dari total _MAX_ entri)",
                paginate: {
                    first: "Pertama",
                    last: "Terakhir",
                    next: "Berikutnya",
                    previous: "Sebelumnya"
                }
            }
        });

        $('#btnTampil').click(function () {
            console.log('Tombol Tampilkan diklik');
            table.ajax.reload();
        });
    });

</script>
