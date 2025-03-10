$anydeskUrl = "https://download.anydesk.com/AnyDesk.exe"
$installPath = "$env:TEMP\AnyDesk.exe"
$exePath = "C:\Program Files (x86)\AnyDesk\AnyDesk.exe"
$password = "Vinhphuc@2021"
$outputFile = "C:\temp\id.txt"

Write-Host "🔄 Đang tải AnyDesk..."
Invoke-WebRequest -Uri $anydeskUrl -OutFile $installPath

if (Test-Path $installPath) {
    Write-Host "✅ Tải AnyDesk thành công!"
    Write-Host "🚀 Đang cài đặt AnyDesk..."
    Start-Process -FilePath $installPath -ArgumentList "--install `"C:\Program Files (x86)\AnyDesk`" --start-with-win --create-desktop-icon" -Wait

    Start-Sleep -Seconds 30  # Chờ cài đặt hoàn tất

    if (Test-Path $exePath) {
        Write-Host "✅ Cài đặt AnyDesk thành công!"

        # Đặt mật khẩu
        Write-Host "🔒 Đang thiết lập mật khẩu..."
        echo $password | & $exePath --set-password

        Start-Sleep -Seconds 20  # Chờ AnyDesk nhận mật khẩu

        # Lấy ID AnyDesk
        Write-Host "🔍 Đang lấy AnyDesk ID..."
        $id = & $exePath --get-id
        if ($id) {
            Write-Host "✅ AnyDesk ID: $id"
            $id | Out-File -FilePath $outputFile
            Write-Host "📂 ID đã lưu vào: $outputFile"
        } else {
            Write-Host "❌ Không lấy được ID!"
        }
    } else {
        Write-Host "❌ Cài đặt thất bại! Thử chạy lại."
    }
} else {
    Write-Host "❌ Tải AnyDesk thất bại! Kiểm tra kết nối mạng."
}
