//
//  ExampleViewController.swift
//  NestedScrollView
//
//  Created by youzy01 on 2020/4/17.
//  Copyright © 2020 youzy. All rights reserved.
//

import UIKit

class ExampleViewController: UIViewController {
    lazy var headerView = HeaderView()
    lazy var commitView = CommitView()
    lazy var webView = WebView()
    @IBOutlet weak var nestedView: NestedView!

    deinit {
        print("ExampleViewController_deinit")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        initNavBar()
        webView.load("https://www.jianshu.com/p/feb45e7060e1")
        commitView.addRows(20)
        nestedView.addArrangedSubview(webView)
        nestedView.addArrangedSubview(headerView)
        nestedView.addArrangedSubview(commitView)
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
