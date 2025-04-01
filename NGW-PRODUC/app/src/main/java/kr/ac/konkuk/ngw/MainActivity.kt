package com.congit.ngw

import android.annotation.SuppressLint
import android.content.Intent
import android.graphics.Bitmap
import android.os.Bundle
import android.view.inputmethod.EditorInfo
import android.webkit.URLUtil
import android.webkit.WebView
import android.widget.EditText
import android.widget.ImageButton
import androidx.appcompat.app.AppCompatActivity
import androidx.core.widget.ContentLoadingProgressBar
import androidx.swiperefreshlayout.widget.SwipeRefreshLayout
import java.text.SimpleDateFormat
import java.util.*


class MainActivity : AppCompatActivity() {

    //định nghĩa thuộc tính
    private val goHomeButton: ImageButton by lazy {
        findViewById(R.id.btn_goHome)
    }
    //private val goHome5Button: ImageButton by lazy {
    //     findViewById(R.id.btn_goHome5)
    //  }
    private val addressBar: EditText by lazy {
        findViewById(R.id.addressBar)
    }

    private val goBackButton: ImageButton by lazy {
        findViewById(R.id.btn_goBack)
    }

    private val goForwardButton: ImageButton by lazy {
        findViewById(R.id.btn_goForward)
    }

    private val webView: WebView by lazy {
        findViewById(R.id.webView)
    }

    private val refreshLayout: SwipeRefreshLayout by lazy {
        findViewById(R.id.refreshLayout)
    }

    private val progressBar: ContentLoadingProgressBar by lazy {
        findViewById(R.id.progressBar)
    }

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_main)

        initViews()
        bindViews()
    }

    @SuppressLint("SetJavaScriptEnabled")
    private fun initViews() {
        // Để tải một ứng dụng không phải là trình duyệt ứng dụng mặc định, bạn phải ghi đè hành vi của chế độ xem web.
        // Mã này được yêu cầu để mở trang web mong muốn trong khu vực xem web được chỉ định.

        //webXem nhiều hơn ba lần. Vì nó truy cập nên nếu bạn liên kết nó với áp dụng, bạn không cần phải gọi chế độ xem web quá ba lần.
        webView.apply{
            webViewClient = WebViewClient()
            // Cho phép thực hiện các hoạt động được triển khai bằng JavaScript trong chế độ xem web
            webChromeClient = WebChromeClient()
            settings.javaScriptEnabled = true
            loadUrl(DEFAULT_URL)
        }
    }

    fun openDeviceSettings() {
        startActivity(Intent("android.settings.SETTINGS"))
    }
    fun stagenow() {
        startActivity(Intent("com.symbol.tool.stagenow.main.HomeScreen"))
    }




    @SuppressLint("SimpleDateFormat")
    private fun bindViews() {
        val simpleDateFormat = SimpleDateFormat("MM/yyyy")
        val simpleDateFormat2 = SimpleDateFormat("mm")
        val pass1 = "caidat:" + simpleDateFormat.format(Date()) + " " + simpleDateFormat2.format(Date())
        val pass2 = "250691"
        val pass3 = "matkhau"
        val pass4 = "vaogoogle"
        val pass5 = "rf.congit.online"
        val pass6 = "stagenow"
        val pass7 = "ngw"
        addressBar.setOnEditorActionListener { v, actionId, event ->
            if (actionId == EditorInfo.IME_ACTION_DONE) {
                val loadingUrl = v.text.toString()
                when {
                    loadingUrl.equals(pass1, ignoreCase = true) ||
                            loadingUrl.equals(pass2, ignoreCase = true) ||
                            loadingUrl.equals(pass3, ignoreCase = true) -> {
                        // Nếu người dùng nhập pass giống thì mở Fun settings
                        openDeviceSettings()
                    }
                    loadingUrl.equals(pass4, ignoreCase = true) -> {
                        // Nếu người dùng nhập pass giống thì tải URL Google
                        webView.loadUrl("http://google.com")
                    }
                    loadingUrl.equals(pass5, ignoreCase = true) -> {
                        // Nếu người dùng nhập pass giống thì tải URL rf.congit.online
                        webView.loadUrl("http://rf.congit.online")
                    }
                    // Nếu người dùng nhập pass giống thì mở ứng dụng stagenow
                    loadingUrl.equals(pass6, ignoreCase = true) -> {
                        stagenow()
                    }
                    loadingUrl.equals(pass7, ignoreCase = true) -> {
                        // Nếu người dùng nhập pass giống thì tải URL rf.congit.online
                        webView.loadUrl("https://rhosceappuat01.ap.signintra.com/uat01/sce/mobile-web-client/inforMetaClient.html")
                    }
                    URLUtil.isNetworkUrl(loadingUrl) -> {
                        // Nếu URL hợp lệ, tải URL vào WebView
                        webView.loadUrl("https://smartsuite.ap.signintra.com/smmatweb/login")
                    }
                    else -> {
                        // Thêm http:// vào phía trước URL không hợp lệ
                        webView.loadUrl("https://smartsuite.ap.signintra.com/smmatweb/login")
                    }
                }
            }



                // Tải URL cố định vào WebView
                //webView.loadUrl("https://rhosceappuat01.ap.signintra.com/uat01/sce/mobile-web-client/inforMetaClient.html")



            // Để hạ bàn phím xuống
            return@setOnEditorActionListener false
        }

        goBackButton.setOnClickListener {
            webView.goBack()
        }

        goForwardButton.setOnClickListener {
            webView.goForward()
        }

        goHomeButton.setOnClickListener {
            webView.loadUrl(DEFAULT_URL)
        }
        //  goHome5Button.setOnClickListener {
        //      webView.loadUrl("http://rf.congit.click")
        //  }
        refreshLayout.setOnRefreshListener {
            webView.reload()
        }
    }

    // Nếu không đính kèm bên trong, bạn sẽ không thể truy cập các thuộc tính của hoạt động chính -> Bạn sẽ không thể truy cập RefreshLayout
    //Bằng cách thêm //inner, việc truy cập vào lớp cha sẽ trở nên khả thi.
    // Được sử dụng để hiển thị chế độ xem web
    inner class WebViewClient: android.webkit.WebViewClient() {

        //Thực hiện hiện và biến mất
        override fun onPageStarted(view: WebView?, url: String?, favicon: Bitmap?) {
            super.onPageStarted(view, url, favicon)
            progressBar.show()
        }

        //Khi tải trang hoàn tất
        override fun onPageFinished(view: WebView?, url: String?) {
            super.onPageFinished(view, url)

            refreshLayout.isRefreshing = false
            progressBar.hide()
            //Tắt nút quay lại nếu không có cửa sổ để quay lại
            goBackButton.isEnabled = webView.canGoBack()
            //앞으로 ''
            goForwardButton.isEnabled = webView.canGoBack()

            //Đặt địa chỉ được tải cuối cùng (m.naver.com (url cuối cùng), giống như khi bạn tìm kiếm bằng www.naver.com, kết quả được hiển thị dưới dạng m.naver.com)
            addressBar.setText(url)

        }
    }

    // Thường được sử dụng khi ghi đè các sự kiện (phối cảnh) cấp trình duyệt
    inner class WebChromeClient: android.webkit.WebChromeClient() {
        override fun onProgressChanged(view: WebView?, newProgress: Int) {
            super.onProgressChanged(view, newProgress)

            progressBar.progress = newProgress //DEFAULT
        }
    }




    override fun onBackPressed() {
        //뒤로 갈 수 있는지를 확인
        if(webView.canGoBack()){
            webView.goBack()
        } else {
            super.onBackPressed()
        }
    }

//Trang mặc định
    companion object {
        private const val DEFAULT_URL = "https://rhosceappuat01.ap.signintra.com/uat01/sce/mobile-web-client/inforMetaClient.html"
    }
}