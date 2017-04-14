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
    
    let queue: OperationQueue = OperationQueue()
    
    // MARK: - ViewLifecycle
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        let operationA = CapturingOperation { (successful: Bool) in
            self.updateLabel.text = "This label has been updated from the following queue: \(OperationQueue.current!)"
        }
        
        queue.addOperation(operationA)
    }

}

