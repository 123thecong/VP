function Show-Menu {
    Clear-Host
    Write-Host "============================="
    Write-Host "      MENU CHỌN CHƯƠNG TRÌNH      "
    Write-Host "============================="
    Write-Host "1. Mở Notepad"
    Write-Host "2. Mở Calculator"
    Write-Host "3. Mở Task Manager"
    Write-Host "4. Mở AnyDesk"
    Write-Host "5. Thoát"
}

function Run-Program {
    param (
        [string]$program
    )
    try {
        Start-Process $program
        Write-Host "✅ Đã mở $program thành công!"
    } catch {
        Write-Host "❌ Lỗi khi mở $program! Kiểm tra lại."
    }
}

do {
    Show-Menu
    $choice = Read-Host "Chọn một tùy chọn"

    switch ($choice) {
        "1" { Run-Program -program "notepad" }
        "2" { Run-Program -program "calc" }
        "3" { Run-Program -program "taskmgr" }
        "4" { Run-Program -program "C:\Program Files (x86)\AnyDesk\AnyDesk.exe" }
        "5" { Write-Host "Thoát chương trình..."; exit }
        default { Write-Host "❌ Lựa chọn không hợp lệ, vui lòng thử lại!" }
    }

    Start-Sleep 2
} while ($true)
