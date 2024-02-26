CREATE TABLE kimia_farma.tabel_analisa AS -- Membuat tabel baru dengan nama tabel_analisa di dalam skema kimia_farma
SELECT -- Memilih kolom-kolom yang akan dimasukkan ke dalam tabel
      kft.transaction_id,
      kft.date,
      kkc.branch_id,
      kkc.branch_name,
      kkc.kota,
      kkc.provinsi,
      kkc.rating AS rating_cabang,
      kft.customer_name,
      kp.product_id,
      kp.product_name,
      kp.price AS actual_price,
      kft.discount_percentage,
      CASE --  Menggunakan syntax CASE untuk menentukan persentase laba kotor berdasarkan harga produk
          WHEN kp.price <= 50000 THEN 0.10
          WHEN kp.price BETWEEN 50000 AND 100000 THEN 0.15
          WHEN kp.price BETWEEN 100000 AND 300000 THEN 0.20
          WHEN kp.price BETWEEN 300000 AND 500000 THEN 0.25
          ELSE 0.30
      END AS persentase_gross_laba,
      (kp.price * (1 - kft.discount_percentage / 100)) AS nett_sales, -- Perhitungan untuk menentukan penjualan bersih (nett_sales)
      (kp.price * (1 - kft.discount_percentage / 100) * -- Perhitungan untuk menentukan keuntungan bersih (nett_profit)
      CASE
          WHEN kp.price <= 50000 THEN 0.10
          WHEN kp.price BETWEEN 50000 AND 100000 THEN 0.15
          WHEN kp.price BETWEEN 100000 AND 300000 THEN 0.20
          WHEN kp.price BETWEEN 300000 AND 500000 THEN 0.25
          ELSE 0.30
      END) AS nett_profit,
      kft.rating AS rating_transaksi
FROM -- Perintah untuk menentukan tabel-tabel yang akan di-join
  kimia_farma.kf_final_transaction AS kft
INNER JOIN -- Perintah untuk menggabungkan (join) beberapa tabel berdasarkan kriteria tertentu
  kimia_farma.kf_kantor_cabang AS kkc ON kft.branch_id = kkc.branch_id
INNER JOIN
  kimia_farma.kf_product AS kp ON kft.product_id = kp.product_id;



