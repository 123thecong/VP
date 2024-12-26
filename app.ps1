     Function Timer()
 {

    $Label.Text = "Your system will reboot in $Script:CountDown seconds"
         --$Script:CountDown
         if ($Script:CountDown -lt 0)
         {
            ClearAndClose
         }
 }
  Function ClearAndClose()
 {
    $Timer.Stop(); 
    $Form.Close(); 
    $Form.Dispose();
    $Timer.Dispose();
    $Script:CountDown=1
 }
###################### CREATING PS GUI TOOL #############################################
 
    #### Form settings #################################################################
    [void] [System.Reflection.Assembly]::LoadWithPartialName("System.Drawing") 
    [void] [System.Reflection.Assembly]::LoadWithPartialName("System.Windows.Forms")  
 
    $Form = New-Object System.Windows.Forms.Form
    $Form.FormBorderStyle = [System.Windows.Forms.FormBorderStyle]::FixedSingle
    $Form.Text = "the-cong.tran@dbschenker.com"   
    $Form.Size = New-Object System.Drawing.Size(400,300)  
    $Form.StartPosition = "CenterScreen" #loads the window in the center of the screen
    $Form.BackgroundImageLayout = "Zoom"
    $Form.MinimizeBox = $False
    $Form.MaximizeBox = $False
    $Form.WindowState = "Normal"
    $Form.SizeGripStyle = "Hide"
    $Icon = [system.drawing.icon]::ExtractAssociatedIcon($PSHOME + "\powershell.exe")
    $Form.Icon = $Icon
 

 $Label = New-Object System.Windows.Forms.Label
 $Label.AutoSize = $true
 $Label.Location = New-Object System.Drawing.Size(35,10)
 $Form.Controls.Add($Label)


    <#### Title - Powershell GUI Tool ###################################################
    $Label = New-Object System.Windows.Forms.Label
    $LabelFont = New-Object System.Drawing.Font("Calibri",18,[System.Drawing.FontStyle]::Bold)
    $Label.Font = $LabelFont
    $Label.Text = "Ứng dụng cài Win DBS - Non DBS"
    $Label.AutoSize = $True
    $Label.Location = New-Object System.Drawing.Size(35,10) 
    $Form.Controls.Add($Label)
#>
 
###################### BUTTONS ##########################################################
 
    #### Khung nho ########################################################
    $groupBox = New-Object System.Windows.Forms.GroupBox
    $groupBox.Location = New-Object System.Drawing.Size(10,45) 
    $groupBox.size = New-Object System.Drawing.Size(370,210)
    $groupBox.text = "Chức năng:"
    $Form.Controls.Add($groupBox) 
 
    #### WinDBS Button #################################################################
    $windbs = New-Object System.Windows.Forms.Button
    $windbs.Location = New-Object System.Drawing.Size(15,30)
    $windbs.Size = New-Object System.Drawing.Size(150,60)
    $windbs.Text = "Cài Win DBS"

    $windbs.Cursor = [System.Windows.Forms.Cursors]::Hand
    $groupBox.Controls.Add($windbs)
 
    #### WinNonDBS Button ###################################################################
    $winnondbs = New-Object System.Windows.Forms.Button
    $winnondbs.Location = New-Object System.Drawing.Size(215,30)
    $winnondbs.Size = New-Object System.Drawing.Size(150,60)
    $winnondbs.Text = "Cài Win Non-DBS"

    $winnondbs.Cursor = [System.Windows.Forms.Cursors]::Hand
    $groupBox.Controls.Add($winnondbs)
 
    #### Delete User button #################################################################
    $DeleteUserOld = New-Object System.Windows.Forms.Button
    $DeleteUserOld.Location = New-Object System.Drawing.Size(15,100)
    $DeleteUserOld.Size = New-Object System.Drawing.Size(150,60)
    $DeleteUserOld.Text = "Xóa User Cũ"
  
    $DeleteUserOld.Cursor = [System.Windows.Forms.Cursors]::Hand
    $groupBox.Controls.Add($DeleteUserOld)
 
###################### Exit BUTTONS ######################################################
    $exit = New-Object System.Windows.Forms.Button
    $exit.Location = New-Object System.Drawing.Size(215,100)
    $exit.Size = New-Object System.Drawing.Size(150,60)
    $exit.Text = "Thoát"
    $exit.Add_Click({$form.Close();})
    $exit.Cursor = [System.Windows.Forms.Cursors]::Hand
    $groupBox.Controls.Add($exit)
 
 
##########################################################################################
##########################################################################################
     $windbs.Add_Click({  
            Copy-Item "C:\windows\system32\autounattend-dbs.xml" -Destination "C:\temp\autounattend.xml" -force
#---------------------------------------------------------------------------------------------------------------------------------------- 
                $wshell = New-Object -ComObject Wscript.Shell
                $wshell.Popup("Operation Completed",0,"Done",0x0+0x40+4096)
				Write-Output "Thành công" >> C:\temp\TestLog.txt
     
})
##########################################################################################
    $winnondbs.Add_Click({
            Copy-Item "C:\windows\system32\autounattend-nondbs.xml" -Destination "C:\temp\autounattend.xml" -force
#----------------------------------------------------------------------------------------------------------------------------------------
               $wshell = New-Object -ComObject Wscript.Shell
               $wshell.Popup("Operation Completed",0,"Done",0x0+0x40+4096)             
               Write-Output "Thành công" >> C:\temp\TestLog.txt
})
$Timer = New-Object System.Windows.Forms.Timer
$Timer.Interval = 1000
##########################################################################################
$DeleteUserOld.Add_Click({Delete-Except})

Function Delete-Except
{

Get-ChildItem -Path C:\users -Exclude "Administrator","TheCong-QTM","Public","Default","Defaultuser0" | Remove-Item -Recurse -Force
               $wshell = New-Object -ComObject Wscript.Shell
               $wshell.Popup("Operation Completed",0,"Done",0x0+0x40+4096)
			   Write-Output "Thành công" >> C:\temp\TestLog.txt
                  explorer "C:\Users"
}
###########################################################################################
 $Script:CountDown = 300
  $Timer.Add_Tick({Timer})
   $Timer.Start()
###########################################################################################
$topmost = New-Object 'System.Windows.Forms.Form' -Property @{TopMost=$true}
$form.ShowDialog($topmost)
###########################################################################################

############################################################################################

