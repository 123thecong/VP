

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
