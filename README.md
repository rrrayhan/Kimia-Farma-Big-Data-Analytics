# **Virtual Internship Experience: Big Data Analytics - Kimia Farma**
Tool : Google BigQuery - [Lihat script](https://github.com/faizns/VIX-Big-Data-Analytics-Kimia-Farma/blob/a4da84f3d2fb45693599c279747cabf271cfd866/vix_kimia_farma_script.sql) <br>
Visualization : Looker Data Studio - [Lihat dashboard](https://lookerstudio.google.com/reporting/28904f09-875c-4713-9c29-4baa9d4ab653) <br>
Dataset : [Kimia Farma](https://www.rakamin.com/virtual-internship-experience/task/kimiafarma-big-data-analytics-virtual-internship-program/20405) 
<br>

---

## 📂 **Introduction**
Big Data Analytics Kimia Farma merupakan virtual internship experience yang difasilitasi oleh [Rakamin Academy](https://www.rakamin.com/virtual-internship-experience/kimiafarma-big-data-analytics-virtual-internship-program). Pada project ini saya berperan sebagai Data Analyst Intern yang diminta untuk menganalisis dan membuat laporan penjualan perusahaan menggunakan data-data yang telah disediakan. Dari project ini, saya juga banyak belajar tentang data data warehouse, datalake, dan datamart. <br>
<br>

**Objectives**
- Importing Dataset to BigQuery
- Membuat design datamart (tabel analisa)
- Membuat visualisasi/dashboard Performance Analytics Kimia Farma 2020-2023
<br>

**Dataset** <br>
Dataset yang disediakan terdiri dari tabel-tabel berikut:
-  kf_final_transaction.csv 
-  kf_inventory.csv  
-  kf_kantor_cabang.csv
-  kf_product.csv
<br>

---


## 📂 **Design Datamart**
### Tabel Aggregat
Tabel agregat adalah tabel yang dibuat dengan mengumpulkan dan menghitung data dari tabel basis. Tabel aggregat ini berisi informasi yang lebih ringkas dan digunakan untuk menganalisis data lebih cepat dan efisien. Hasil tabel ini akan digunakan untuk sumber pembuatan dashboard laporan penjualan.
<details>
  <summary> Klik untuk melihat Query </summary>
    <br>
    
```sql
CREATE TABLE kimia_farma.tabel_analisa AS
SELECT
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
      CASE
          WHEN kp.price <= 50000 THEN 0.10
          WHEN kp.price BETWEEN 50000 AND 100000 THEN 0.15
          WHEN kp.price BETWEEN 100000 AND 300000 THEN 0.20
          WHEN kp.price BETWEEN 300000 AND 500000 THEN 0.25
          ELSE 0.30
      END AS persentase_gross_laba,
      (kp.price * (1 - kft.discount_percentage / 100)) AS nett_sales,
      (kp.price * (1 - kft.discount_percentage / 100) * 
      CASE
          WHEN kp.price <= 50000 THEN 0.10
          WHEN kp.price BETWEEN 50000 AND 100000 THEN 0.15
          WHEN kp.price BETWEEN 100000 AND 300000 THEN 0.20
          WHEN kp.price BETWEEN 300000 AND 500000 THEN 0.25
          ELSE 0.30
      END) AS nett_profit,
      kft.rating AS rating_transaksi
FROM 
  kimia_farma.kf_final_transaction AS kft
INNER JOIN
  kimia_farma.kf_kantor_cabang AS kkc ON kft.branch_id = kkc.branch_id
INNER JOIN
  kimia_farma.kf_product AS kp ON kft.product_id = kp.product_id;

ALTER TABLE base_table ADD PRIMARY KEY(id_invoice);
```
    
<br>
</details>
<br>

<p align="center">
    <kbd> <img width="1000" alt="sample table base" src="https://user-images.githubusercontent.com/115857221/222876639-20e1e208-1c5b-4279-8e18-ec937c56f526.png"> </kbd> <br>
    Gambar 1 — Sampel Hasil Pembuatan Tabel Base 
</p>
<br>

---

## 📂 **Data Visualization**

[Lihat pada halaman Looker Data Studio](https://lookerstudio.google.com/reporting/28904f09-875c-4713-9c29-4baa9d4ab653).

<p align="center">
    <kbd> <img width="1000" alt="Kimia_Farma_page-0001" src="https://user-images.githubusercontent.com/115857221/222877035-53371a89-081d-4ec5-9e72-65b0176a96fd.jpg"> </kbd> <br>
    Gambar 3 — Sales Report Dashboard PT. Kimia Farma
</p>
<br>
