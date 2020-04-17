//
//  HeaderView.swift
//  NestedScrollView
//
//  Created by youzy01 on 2020/4/17.
//  Copyright © 2020 youzy. All rights reserved.
//

import UIKit

protocol Nesteable: NSObject {
    dynamic var contentHeight: CGFloat { get set }
    var contentHeightDidChanged: (() -> Void)? { get set }
}

class HeaderView: UIView, Nesteable {
    @objc dynamic var contentHeight: CGFloat = 0
    var contentHeightDidChanged: (() -> Void)?

    override init(frame: CGRect) {
        super.init(frame: frame)
        prepare()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        prepare()
    }

    override var intrinsicContentSize: CGSize {
        contentHeight = 300
        return CGSize(width: ScreenW, height: 300)
    }
}

extension HeaderView {
    func prepare() {
        backgroundColor = .red
    }
}