//
//  HeaderView.swift
//  NestedScrollView
//
//  Created by youzy01 on 2020/4/17.
//  Copyright © 2020 youzy. All rights reserved.
//

import UIKit


class HeaderView: UIView, NibLoadable, Nesteable {
    var contentSizeDidChanged: (() -> Void)?

    var scrollView: UIScrollView?

    private var contentHeight: CGFloat = 300

    deinit {
        print("HeaderView_deinit")
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        initViewFromNib()
        prepare()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        initViewFromNib()
        prepare()
    }

    override var intrinsicContentSize: CGSize {
        return CGSize(width: ScreenW, height: contentHeight)
    }

    func setContentOffset(_ offset: CGPoint) {
    }
}

extension HeaderView {
    func prepare() {
    }

    @IBAction func tapAction() {
        if contentHeight >= 500 {
            contentHeight = 300
        } else {
            contentHeight += 200
        }
        invalidateIntrinsicContentSize()
        contentSizeDidChanged?()
    }
}
