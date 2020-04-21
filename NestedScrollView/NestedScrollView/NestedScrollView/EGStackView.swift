//
//  NestedView.swift
//  NestedScrollView
//
//  Created by youzy01 on 2020/4/17.
//  Copyright © 2020 youzy. All rights reserved.
//

import UIKit
/// 多个视图(包含滚动视图)嵌套
///
/// ArrangedSubview 必须实现 intrinsicContentSize
class EGStackView: UIScrollView {
    private lazy var contentView = UIView()
    private lazy var stackView: UIStackView = {
        let view = UIStackView()
        view.backgroundColor = .cyan
        view.axis = .vertical
        view.alignment = .fill
        view.distribution = .fill
        view.spacing = 0
        return view
    }()

    deinit {
        print("NestedView_deinit")
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        prepare()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        prepare()
    }
}

extension EGStackView {
    func addArrangedSubview(_ view: UIView) {
        stackView.addArrangedSubview(view)
    }
}

private extension EGStackView {
    func prepare() {
        contentView.frame = bounds
        contentView.backgroundColor = .red
        contentView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(contentView)
        contentView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        contentView.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        contentView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        contentView.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        contentView.widthAnchor.constraint(equalTo: self.widthAnchor).isActive = true

        stackView.frame = bounds
        stackView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(stackView)
        stackView.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        stackView.leftAnchor.constraint(equalTo: contentView.leftAnchor).isActive = true
        stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
        stackView.rightAnchor.constraint(equalTo: contentView.rightAnchor).isActive = true
    }
}
