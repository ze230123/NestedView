//
//  CommitView.swift
//  NestedScrollView
//
//  Created by youzy01 on 2020/4/17.
//  Copyright © 2020 youzy. All rights reserved.
//

import UIKit

class CommitView: UIView, NibLoadable, Nesteable {
    @IBOutlet weak var tableView: UITableView!

    var dataSource: Int = 0

    var contentSizeDidChanged: (() -> Void)?

    var scrollView: UIScrollView? {
        return tableView
    }

    deinit {
        print("CommitView_deinit")
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
        var height = CGFloat(dataSource * 50)
        if height == 0 {
            height = 200
        }
        return CGSize(width: ScreenW, height: height)
    }

    func addRows(_ rows: Int) {
        dataSource += rows
        tableView.reloadData()
        invalidateIntrinsicContentSize()
    }

    func setContentOffset(_ offset: CGPoint) {
        tableView.setContentOffset(offset, animated: false)
    }

    var observe: NSKeyValueObservation?
}

extension CommitView {
    func prepare() {
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "CommitViewCell")
        observe = tableView.observe(\.contentSize) { [unowned self] (view, _) in
            self.contentSizeDidChanged?()
        }
    }
}

extension CommitView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CommitViewCell", for: indexPath)
        cell.textLabel?.text = "这是评论 -----> \(indexPath.row)"
        print("cellForRowAt -> \(indexPath.row)")
        return cell
    }
}
