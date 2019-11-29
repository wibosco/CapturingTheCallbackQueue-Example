//
//  CapturingOperation.swift
//  CapturingTheCallbackQueue-Example
//
//  Created by William Boles on 14/04/2017.
//  Copyright © 2017 William Boles. All rights reserved.
//

import Foundation

class CapturingOperation: Operation {
    
    private let completion: ((_ result: Result<Bool, Error>) -> ())?
    private let callbackQueue: OperationQueue?
    
    //MARK: - Init

    init(callbackQueue: OperationQueue? = OperationQueue.current, completion: ((_ result: Result<Bool, Error>) -> ())?) {
        self.completion = completion
        self.callbackQueue = callbackQueue
        
        super.init()
    }
    
    // MARK: - Main
    
    override func main() {
        super.main()
        
        sleep(2) //This is where this operation's actual work would be
        
        let result = Result<Bool, Error>.success(true)
        if let callbackQueue = callbackQueue {
            callbackQueue.addOperation {
                self.completion?(result)
            }
        } else {
            completion?(result)
        }
    }
}
