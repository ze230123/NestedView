//
//  ExampleViewController.swift
//  NestedScrollView
//
//  Created by youzy01 on 2020/4/17.
//  Copyright © 2020 youzy. All rights reserved.
//

import UIKit
import MJRefresh

class ExampleViewController: UIViewController {
    lazy var headerView = HeaderView()
    lazy var commitView = CommitView()
    lazy var webView = WebView()
    lazy var topView = HeaderView()
    @IBOutlet weak var nestedView: EGStackView!

    deinit {
        print("ExampleViewController_deinit")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        initNavBar()

        commitView.addRows(100)

        nestedView.addArrangedSubview(topView)
        nestedView.addArrangedSubview(webView)
        nestedView.addArrangedSubview(headerView)
        nestedView.addArrangedSubview(commitView)

        webView.load("https://github.com/renzifeng/ZFPlayer")

        nestedView.mj_footer = MJRefreshBackNormalFooter(refreshingTarget: self, refreshingAction: #selector(loadMore))
    }

    func initNavBar() {
        let add = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addAction))
        navigationItem.rightBarButtonItem = add
    }
}

extension ExampleViewController {
    @objc func addAction() {
        commitView.addRows(3)
    }
}

extension ExampleViewController {
    @objc func loadMore() {
        print("loadMore")
        request()
    }

    func request() {
        DispatchQueue.global().asyncAfter(deadline: .now() + 3) {
            DispatchQueue.main.async {
                self.commitView.addRows(5)
                self.nestedView.mj_footer?.endRefreshing()
            }
        }
    }
}
