

#Tu xoa cac user cu neu co -------------------------------------------------------------------------------------------------------------
$loaitru ="Administrator"
$loaitru1 = "Default"
$loaitru2 = "Public"
$loaitru3 = "Defaultuser0"
get-childitem C:\Users\ -exclude $loaitru,$loaitru1,$loaitru2,$loaitru3 | ForEach-Object ($_) {takeown /f $_.fullname  /A /R /D Y }
get-childitem C:\Users\ -exclude $loaitru,$loaitru1,$loaitru2,$loaitru3 | ForEach-Object ($_) {remove-item $_.fullname -recurse -force}
#---------------------------------------------------------------------------------------------------------------------------------------
#
#
#CHAY ULTRAVIE VA KHOI DONG LAI NHIEU LAN DE CAP NHAT
<#CHAY AnyDesk VA KHOI DONG LAI NHIEU LAN DE CAP NHAT
Write-Output "EXIT AnyDesk" >> C:\temp\TestLog.txt
Get-Process -Name "AnyDesk" | Stop-Process -Force
Start-Sleep -Seconds 20
Write-Output "EXIT ULTRAVIEW" >> C:\temp\TestLog.txt
Get-Process -Name "UltraViewer_Desktop" | Stop-Process -Force
Start-Sleep -Seconds 20
Write-Output "RUN ULTRAVIEW" >> C:\temp\TestLog.txt
Start-Process 'C:\Program Files (x86)\UltraViewer\UltraViewer_Desktop.exe'
Start-Sleep -Seconds 20
Write-Output "EXIT ULTRAVIEW" >> C:\temp\TestLog.txt
Get-Process -Name "UltraViewer_Desktop" | Stop-Process -Force
Start-Sleep -Seconds 20
Write-Output "RUN ULTRAVIEW" >> C:\temp\TestLog.txt
Start-Process 'C:\Program Files (x86)\UltraViewer\UltraViewer_Desktop.exe'
Write-Output "WAILT 60S" >> C:\temp\TestLog.txt
Start-Sleep -Seconds 60
#
#
#
#
#
#chup anh man hinh----------------------------------------------------------------------------------------------------------------------
Write-Output "Chup Anh man Hinh" >> C:\temp\TestLog.txt
Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing
$Screen = [System.Windows.Forms.SystemInformation]::VirtualScreen
$Width  = 1920
$Height = 1080
$Left   = $Screen.Left
$Top    = $Screen.Top
$bitmap  = New-Object System.Drawing.Bitmap $Width, $Height
$graphic = [System.Drawing.Graphics]::FromImage($bitmap)
$graphic.CopyFromScreen($Left, $Top, 0, 0, $bitmap.Size)
Write-Output "May tinh cua ban da duoc cai dat xong, chung toi dang gui thong bao cho IT"
$bitmap.Save("c:\temp\Screenshot.bmp")
Write-Output "Da Chup Anh man HInh" >> C:\temp\TestLog.txt
#>
#
#
#
#
#
#
#
#phan code lay thong tin PC-----------------------------------------------------------------------------------------------------------------
$tenpc = Get-WMIObject Win32_ComputerSystem| Select-Object -ExpandProperty Name
#$ip = get-content %temp%\ip.txt
$id = get-content c:\temp\id.txt
$ngay = Get-Date
$ip2 = (Get-WmiObject -Class Win32_NetworkAdapterConfiguration | where {$_.DHCPEnabled -ne $null -and $_.DefaultIPGateway -ne $null}).IPAddress | Select-Object -First 1
$namepc = Get-WMIObject Win32_ComputerSystem| Select-Object -ExpandProperty Name
#
#
#
#Phan code gui email qua smtp gmail---------------------------------------------------------------------------------------------------------
$From = "dbschenker.scan@gmail.com"
$To = "the-cong.tran@dbschenker.com"
$Subject = "Máy tính mới $tenpc đã được cài đặt lúc: $ngay"
#
#
#
# Define the SMTP server details
$SMTPServer = "smtp.gmail.com"
$SMTPPort = 587
$SMTPUsername = "dbschenker.scan@gmail.com"
$SMTPPassword = "kbwsiciuomqphhhe"
#
#-------------------------------------------------------------------------------------------------------------------------------------------
#
#Phan code gui email voi dinh dang HTML
$EmailBody = @"
<h2><span style="color: #ff0000;"><strong>Máy tính mới đã được cài đặt</strong></span></h2>
<h3><span style="color: #ff0000;"><strong>$id</strong></span></h3>
<h3><span style="color: #ff0000;"><strong>Ip: $ip2</strong></span></h3>
<p><span style="text-decoration: underline;"><span style="color: #ff0000; text-decoration: underline;">Cần chú ý:</span></span></p>
<p><span style="color: #0000ff;"><strong>- Gỡ bỏ TightVNC nếu có</strong></span></p>
<p><span style="color: #0000ff;"><strong>- Đặt ultraview khởi động mặc định, pass mặc định</strong></span></p>
<p><span style="color: #0000ff;"><strong>- Xóa bỏ các user cũ nếu có</strong></span></p>
<p><strong>Thanks & Best regards,</strong></p>
<p><strong>****************************</strong></p>
<p><strong>Tran The Cong (Mr.)<br /></strong></p>
<p>&nbsp;</p>
"@
$attachment = "c:\temp\Screenshot.bmp"
#--------------------------------------------------------------------------------------------------------------------------------------------
#
#
#
#
# Create a new email object
$Email = New-Object System.Net.Mail.MailMessage
$Email.From = $From
$Email.To.Add($To)
$Email.Subject = $Subject
$Email.Body = $EmailBody #"$Body1"+"$Body2"+"$Body3"+"$Body4"
# Uncomment below to send HTML formatted email
$Email.IsBodyHTML = $true
$Email.attachments.add($attachment)
# Create an SMTP client object and send the email
$SMTPClient = New-Object System.Net.Mail.SmtpClient($SMTPServer, $SMTPPort)
$SMTPClient.EnableSsl = $true
# 
$SMTPClient.Credentials = New-Object System.Net.NetworkCredential($SMTPUsername, $SMTPPassword)
$SMTPClient.Send($Email)
# 
# Output a message indicating that the email was sent successfully
Write-Host "Da gui email thanh cong den $($Email.To.ToString())"
Write-Output "Da gui thong bao, may se khoi dong lai sau 5p" >> C:\temp\TestLog.txt
#------------------------------------------------------------------------------------------------------------------------------------------

#
#
#
#
#
#
<#
Powershell -File C:\temp\app.ps1
#
#
#
#
#
#
#
Start-Sleep -Seconds 300
#
Unregister-ScheduledTask -TaskName "CHUP ANH MAN HINH" -Confirm:$false
Start-Sleep -Seconds 1
Write-Output "Da go bo Schedule" >> C:\temp\TestLog.txt
#>
Write-Output "Da gui thong bao, may se khoi dong lai sau 5p"
# Chay Sysprep de hoan tat cai dat---------------------------------------------------------------------------------------------------------
$acommand = "C:\Windows\System32\Cscript.exe C:\temp\DelayedSysprep.vbs"
Invoke-Expression $acommand
Write-Output "Da chay sysprep" >> C:\temp\TestLog.txt
#------------------------------------------------------------------------------------------------------------------------------------------

