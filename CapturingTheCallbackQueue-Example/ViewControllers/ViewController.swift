//
//  ViewController.swift
//  CapturingTheCallbackQueue-Example
//
//  Created by William Boles on 14/04/2017.
//  Copyright © 2017 William Boles. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var updateLabel: UILabel!
    
    // MARK: - ViewLifecycle
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        let worker = CapturingQueueExample()
        
        worker.performWork { result in
            switch result {
            case .success(let value):
                self.updateLabel.text = value
                self.updateLabel.textColor = .green
            case .failure(let errror):
                self.updateLabel.text = errror.localizedDescription
                self.updateLabel.textColor = .red
            }
        }
    }
}
