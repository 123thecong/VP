package com.congit.ngw

import android.annotation.SuppressLint
import android.content.Intent
import android.graphics.Bitmap
import android.net.http.SslError
import android.os.Bundle
import android.view.WindowManager
import android.view.inputmethod.EditorInfo
import android.webkit.*
import android.widget.EditText
import android.widget.ImageButton
import androidx.appcompat.app.AppCompatActivity
import androidx.core.widget.ContentLoadingProgressBar
import androidx.swiperefreshlayout.widget.SwipeRefreshLayout
import java.text.SimpleDateFormat
import java.util.*

class MainActivity : AppCompatActivity() {

    private val goHomeButton: ImageButton by lazy { findViewById(R.id.btn_goHome) }
    private val addressBar: EditText by lazy { findViewById(R.id.addressBar) }
    private val goBackButton: ImageButton by lazy { findViewById(R.id.btn_goBack) }
    private val goForwardButton: ImageButton by lazy { findViewById(R.id.btn_goForward) }
    private val webView: WebView by lazy { findViewById(R.id.webView) }
    private val refreshLayout: SwipeRefreshLayout by lazy { findViewById(R.id.refreshLayout) }
    private val progressBar: ContentLoadingProgressBar by lazy { findViewById(R.id.progressBar) }

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_main)
        WebView.setWebContentsDebuggingEnabled(true)
        window.setSoftInputMode(WindowManager.LayoutParams.SOFT_INPUT_STATE_HIDDEN)
        initViews()
        bindViews()
    }

    @SuppressLint("SetJavaScriptEnabled")
    private fun initViews() {
        webView.apply {
            webViewClient = WebViewClient()
            webChromeClient = WebChromeClient()
            settings.apply {
                javaScriptEnabled = true
                domStorageEnabled = true
                databaseEnabled = true
                mixedContentMode = WebSettings.MIXED_CONTENT_ALWAYS_ALLOW
                allowFileAccess = true
                allowContentAccess = true
                setSupportMultipleWindows(true)
                cacheMode = WebSettings.LOAD_DEFAULT
                userAgentString = "Mozilla/5.0 (Linux; Android 10; Mobile) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/90.0.4430.210 Mobile Safari/537.36"
            }
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
        val pass8 = "ngwuat"

        addressBar.setOnEditorActionListener { v, actionId, _ ->
            if (actionId == EditorInfo.IME_ACTION_DONE) {
                val loadingUrl = v.text.toString()
                when {
                    loadingUrl.equals(pass1, ignoreCase = true) ||
                            loadingUrl.equals(pass2, ignoreCase = true) ||
                            loadingUrl.equals(pass3, ignoreCase = true) -> openDeviceSettings()

                    loadingUrl.equals(pass4, ignoreCase = true) -> webView.loadUrl("http://google.com")
                    loadingUrl.equals(pass5, ignoreCase = true) -> webView.loadUrl("http://rf.congit.cloud")
                    loadingUrl.equals(pass6, ignoreCase = true) -> stagenow()
                    loadingUrl.equals(pass7, ignoreCase = true) -> webView.loadUrl("https://ngwsceprod.ap.signintra.com/prdo2/sce/mobile-web-client/inforMetaClient.html")
                    loadingUrl.equals(pass8, ignoreCase = true) -> webView.loadUrl("https://rhosceappuat01.ap.signintra.com/uat01/sce/mobile-web-client/inforMetaClient.html")
                    URLUtil.isNetworkUrl(loadingUrl) -> webView.loadUrl(loadingUrl)
                    else -> webView.loadUrl(DEFAULT_URL)
                }
            }
            false
        }

        goBackButton.setOnClickListener { if (webView.canGoBack()) webView.goBack() }
        goForwardButton.setOnClickListener { if (webView.canGoForward()) webView.goForward() }
        goHomeButton.setOnClickListener { webView.loadUrl(DEFAULT_URL) }
        refreshLayout.setOnRefreshListener { webView.reload() }
    }

    inner class WebViewClient : android.webkit.WebViewClient() {
        override fun shouldOverrideUrlLoading(view: WebView?, request: WebResourceRequest?): Boolean {
            view?.loadUrl(request?.url.toString())
            return true
        }

        override fun onReceivedSslError(view: WebView?, handler: SslErrorHandler?, error: SslError?) {
            handler?.proceed()  // Bỏ qua lỗi SSL
        }

        override fun onPageStarted(view: WebView?, url: String?, favicon: Bitmap?) {
            super.onPageStarted(view, url, favicon)
            progressBar.show()
        }

        override fun onPageFinished(view: WebView?, url: String?) {
            super.onPageFinished(view, url)
            refreshLayout.isRefreshing = false
            progressBar.hide()
            goBackButton.isEnabled = webView.canGoBack()
            goForwardButton.isEnabled = webView.canGoForward()
            addressBar.setText(url)
        }
    }

    inner class WebChromeClient : android.webkit.WebChromeClient() {
        override fun onProgressChanged(view: WebView?, newProgress: Int) {
            super.onProgressChanged(view, newProgress)
            progressBar.progress = newProgress
        }
    }

    override fun onBackPressed() {
        if (webView.canGoBack()) {
            webView.goBack()
        } else {
            super.onBackPressed()
        }
    }

    companion object {
        private const val DEFAULT_URL = "https://ngwsceprod.ap.signintra.com/prdo2/sce/mobile-web-client/inforMetaClient.html"
    }
}
