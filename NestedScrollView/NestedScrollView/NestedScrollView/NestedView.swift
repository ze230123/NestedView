//
//  NestedView.swift
//  NestedScrollView
//
//  Created by youzy01 on 2020/4/17.
//  Copyright © 2020 youzy. All rights reserved.
//

import UIKit

public class NestedView: UIScrollView {
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

    private var observas: [NSKeyValueObservation] = []
    private var views: [Nesteable] = []

    override init(frame: CGRect) {
        super.init(frame: frame)
        prepare()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        prepare()
    }
}

extension NestedView {
    func addArrangedSubview<V: UIView>(_ view: V) where V: Nesteable {
        stackView.addArrangedSubview(view)
        views.append(view)
        addObserve(view)
    }

    func addObserve<V: UIView>(_ view: V) where V: Nesteable {
        view.contentHeightDidChanged = { [unowned self] in
            self.updateContentSize()
        }
    }

    func updateContentSize() {
        let height = views.map { $0.contentHeight }.reduce(0, +)
        contentSize.height = height
    }
}

private extension NestedView {
    func prepare() {
        contentView.backgroundColor = .lightGray
        contentView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(contentView)
        contentView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        contentView.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        contentView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        contentView.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        contentView.widthAnchor.constraint(equalTo: self.widthAnchor).isActive = true

        stackView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(stackView)
        stackView.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        stackView.leftAnchor.constraint(equalTo: contentView.leftAnchor).isActive = true
        stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
        stackView.rightAnchor.constraint(equalTo: contentView.rightAnchor).isActive = true
    }
}
