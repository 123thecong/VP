function Show-Menu {
    Clear-Host
    Write-Host "============================"
    Write-Host "     Menu Tải File irm     "
    Write-Host "============================"
    Write-Host "1. Nhập URL GitHub để tải file"
    Write-Host "2. Thoát"
}

function Download-File {
    param (
        [string]$url
    )
    $outputPath = "$env:TEMP\downloaded_file"
    Write-Host "`nĐang tải file từ: $url ..."
    try {
        irm $url -OutFile $outputPath
        Write-Host "✅ Tải thành công! File đã lưu tại: $outputPath"
        Write-Host "Bạn có muốn chạy file này không? (y/n)"
        $runFile = Read-Host
        if ($runFile -eq "y") {
            Start-Process $outputPath
            Write-Host "🔥 File đang được chạy..."
        }
    } catch {
        Write-Host "❌ Lỗi khi tải file! Kiểm tra lại URL."
    }
}

do {
    Show-Menu
    $choice = Read-Host "Chọn một tùy chọn"
    
    switch ($choice) {
        "1" {
            $url = Read-Host "Nhập URL GitHub raw file của bạn"
            Download-File -url $url
        }
        "2" {
            Write-Host "Thoát chương trình..."
            exit
        }
        default {
            Write-Host "Lựa chọn không hợp lệ, vui lòng thử lại!"
        }
    }
    Start-Sleep 2
} while ($true)
