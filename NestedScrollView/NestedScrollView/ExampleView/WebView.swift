//
//  WebView.swift
//  NestedScrollView
//
//  Created by youzy01 on 2020/4/20.
//  Copyright © 2020 youzy. All rights reserved.
//

import UIKit
import WebKit


class WebView: UIView, Nesteable {
    var contentHeight: CGFloat = 0
    var contentSizeDidChanged: (() -> Void)?

    var scrollView: UIScrollView? {
        return webView.scrollView
    }

    lazy var webView = WKWebView()
    var obser: NSKeyValueObservation?

    deinit {
        print("WebView_deinit")
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        prepare()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        prepare()
    }

    func load(_ url: String) {
        let request = URLRequest(url: URL(string: url)!)
        webView.load(request)
    }

    override var intrinsicContentSize: CGSize {
        return CGSize(width: ScreenW, height: 200)
    }
}

extension WebView {
    func prepare() {
        webView.scrollView.isScrollEnabled = false
        webView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(webView)
        webView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        webView.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        webView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        webView.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true

        obser = webView.scrollView.observe(\.contentSize, changeHandler: { [unowned self] (view, _) in
            self.contentHeight = view.contentSize.height
            self.contentSizeDidChanged?()
            self.invalidateIntrinsicContentSize()
        })
    }
}
