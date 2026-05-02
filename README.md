# Python Manager (PowerShell) — Install/Uninstall Python & Libraries (Windows)

Công cụ PowerShell cho Windows giúp bạn **cài Python**, **gỡ Python sạch**, và **cài thư viện theo nhóm** (hoặc cài tất cả) từ menu console.

> Ngôn ngữ: **Tiếng Việt / English**  
> Giao diện: **ASCII Banner + thông tin OS/User + giờ Việt Nam (HH:mm)**
> Người phát triển: **Nguyễn Mạnh Hùng**
> Facebook: **[Nguyễn Mạnh Hùng](https://www.facebook.com/NMHRUBY)**

---

## Tính năng

- ✅ **Cài đặt Python**: liệt kê nhiều phiên bản để chọn + ghi chú tương thích Windows Build
- ✅ **Gỡ cài đặt Python**: quét uninstall registry + dọn PATH (giảm xung đột)
- ✅ **Cài thư viện theo nhóm**: Data/ML, Deep Learning, Jupyter, Web, DB, NLP, v.v.
- ✅ **Cài tất cả thư viện**: tự nâng pip trước khi cài
- ✅ **Tuỳ chọn ngôn ngữ**: VI/EN trong menu

---

## Yêu cầu

- Windows 10/11 (khuyến nghị)
- PowerShell 5.1+ (có sẵn) hoặc PowerShell 7+
- Internet (tải Python + packages)
- Quyền Admin: **khuyến nghị** (đặc biệt cho cài/gỡ và PATH hệ thống)

---

## Cách chạy nhanh (khuyến nghị) — `irm | iex`

### 1) Chạy trực tiếp (One-liner)

```powershell
irm https://raw.githubusercontent.com/<USER>/<REPO>/master/nmhruby.ps1 | iex