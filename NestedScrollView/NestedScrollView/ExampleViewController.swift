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

    @IBOutlet weak var nestedView: NestedView!

    override func viewDidLoad() {
        super.viewDidLoad()
        initNavBar()
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
