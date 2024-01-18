package com.congit.simplewebbrowser

import android.graphics.Bitmap
import android.media.Image
import androidx.appcompat.app.AppCompatActivity
import android.os.Bundle
import android.view.inputmethod.EditorInfo
import android.webkit.URLUtil
import android.webkit.WebView
import android.webkit.WebViewClient
import android.widget.EditText
import android.widget.ImageButton
import androidx.core.widget.ContentLoadingProgressBar
import androidx.swiperefreshlayout.widget.SwipeRefreshLayout

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

    //연결
    private fun bindViews() {
        addressBar.setOnEditorActionListener { v, actionId, event ->
            if(actionId == EditorInfo.IME_ACTION_DONE) {
                // Để nó tự động được thêm vào ngay cả khi bạn không nhập https.
                val loadingUrl = v.text.toString()
                if(URLUtil.isNetworkUrl(loadingUrl)){
                    // Nếu đúng thì có http hoặc https ở phía trước.
                    webView.loadUrl(loadingUrl)
                } else {
                    // Thêm http:// vào phía trước
                    webView.loadUrl("http://$loadingUrl")
                }

                webView.loadUrl("https://smartsuite.ap.signintra.com/matrix_re/change_workcode")
                //webView.loadUrl(v.text.toString())
            }

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



    //분기에 따라 웹뷰의 뒤로가기를 할지, 앱자체를 뒤로가기할지 결정
    override fun onBackPressed() {
        //뒤로 갈 수 있는지를 확인
        if(webView.canGoBack()){
            webView.goBack()
        } else {
            super.onBackPressed()
        }
    }

    //하드코딩하지 않고 이렇게 상수로 빼놓으면 수정사항이 생길때 상수만 바꿔주면 됨
    companion object {
        private const val DEFAULT_URL = "https://smartsuite.ap.signintra.com/matrix_re/change_workcode"
    }
}