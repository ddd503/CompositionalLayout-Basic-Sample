//
//  ViewController.swift
//  CompositionalLayout-Basic-Sample
//
//  Created by kawaharadai on 2020/01/20.
//  Copyright © 2020 kawaharadai. All rights reserved.
//

import UIKit

final class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        PhotoService.requestAuthorizationIfNeeded { (canAccess) in
            guard canAccess else { fatalError("写真へのアクセスが許可されていない") }
        }
    }


}

