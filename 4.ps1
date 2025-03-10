$menu = @"
=============================
      MENU CHỌN CHƯƠNG TRÌNH      
=============================
1. Mở Notepad
2. Mở Calculator
3. Mở Task Manager
4. Mở AnyDesk
5. Thoát
=============================
"@

function Run-Program {
    param ([string]$program)
    try {
        Start-Process $program -ErrorAction Stop
        Write-Host "`n✅ Đã mở $program thành công!"
    } catch {
        Write-Host "`n❌ Lỗi khi mở $program! Kiểm tra lại."
    }
}

while ($true) {
    Clear-Host
    Write-Host $menu
    $choice = Read-Host "`nChọn một tùy chọn"

    switch ($choice) {
        "1" { Run-Program "notepad" }
        "2" { Run-Program "calc" }
        "3" { Run-Program "taskmgr" }
        "4" { Run-Program "C:\Program Files (x86)\AnyDesk\AnyDesk.exe" }
        "5" { Write-Host "`nThoát chương trình..."; exit }
        default { Write-Host "`n❌ Lựa chọn không hợp lệ, vui lòng thử lại!" }
    }

    Start-Sleep 2
}
