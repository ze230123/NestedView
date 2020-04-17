//
//  ViewController.swift
//  NestedScrollView
//
//  Created by youzy01 on 2020/3/27.
//  Copyright © 2020 youzy. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func pushNestedAction() {
        let vc = ExampleViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
}

