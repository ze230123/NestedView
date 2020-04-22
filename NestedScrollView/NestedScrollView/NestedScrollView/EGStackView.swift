//
//  NestedView.swift
//  NestedScrollView
//
//  Created by youzy01 on 2020/4/17.
//  Copyright © 2020 youzy. All rights reserved.
//

import UIKit

protocol Nesteable: NSObject {
    var scrollView: UIScrollView? { get }
    var contentSizeDidChanged: (() -> Void)? { get set }
}

/// 多个视图(包含滚动视图)嵌套
///
/// ArrangedSubview 必须实现 intrinsicContentSize
class EGStackView: UIScrollView {
    private lazy var contentView = UIView()

    private var subviewsInLayoutOrder: [UIView & Nesteable] = []

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

    override func layoutSubviews() {
        super.layoutSubviews()

        contentView.frame = bounds
        contentView.bounds = CGRect(origin: contentOffset, size: contentView.bounds.size)
        // 整体内容高度
        var offsetyOfCurrentSubview: CGFloat = 0

        for subview in subviewsInLayoutOrder {
            var subFrame = subview.frame
            // 如果是滚动视图
            if let scrollView = subview.scrollView {
                var subContentOffset = scrollView.contentOffset
                if contentOffset.y < offsetyOfCurrentSubview {
                    subContentOffset.y = 0
                    subFrame.origin.y = offsetyOfCurrentSubview
                } else {
                    subContentOffset.y = contentOffset.y - offsetyOfCurrentSubview
                    subFrame.origin.y = contentOffset.y
                }

                let normalHeight = subview.intrinsicContentSize.height
                let remainingBoundsHeight = fmax(bounds.maxY - subFrame.minY, normalHeight)
                let remainingContentHeight = fmax(scrollView.contentSize.height - subContentOffset.y, normalHeight)

                subFrame.size.height = fmin(remainingBoundsHeight, remainingContentHeight)
                subFrame.size.width = contentView.bounds.width

                subview.frame = subFrame
                scrollView.contentOffset = subContentOffset

                offsetyOfCurrentSubview += (scrollView.contentSize.height + scrollView.contentInset.top + scrollView.contentInset.bottom)
            } else {
                subFrame.origin.y = offsetyOfCurrentSubview
                subFrame.origin.x = 0
                subFrame.size.width = contentView.bounds.width
                subFrame.size.height = subview.intrinsicContentSize.height
                subview.frame = subFrame

                offsetyOfCurrentSubview += subFrame.size.height
            }
        }

        let minimumContentHeight = bounds.size.height - (contentInset.top + contentInset.bottom)
        let initialContentOffset = contentOffset
        contentSize = CGSize(width: bounds.width, height: fmax(offsetyOfCurrentSubview, minimumContentHeight))

        if initialContentOffset != contentOffset {
            setNeedsLayout()
        }
    }
}

extension EGStackView {
    func addArrangedSubview<V>(_ view: V) where V: UIView, V: Nesteable {
        contentView.addSubview(view)
        subviewsInLayoutOrder.append(view)
        view.contentSizeDidChanged = { [weak self] in
            self?.setNeedsLayout()
        }
    }
}

private extension EGStackView {
    func prepare() {
        addSubview(contentView)
    }
}
