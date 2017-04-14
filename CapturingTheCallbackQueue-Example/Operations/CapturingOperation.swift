//
//  CapturingOperation.swift
//  CapturingTheCallbackQueue-Example
//
//  Created by William Boles on 14/04/2017.
//  Copyright © 2017 William Boles. All rights reserved.
//

import Foundation

class CapturingOperation: Operation {
    
    let completion: ((_ successful: Bool) -> (Void))?
    private let callBackQueue: OperationQueue
    
    //MARK: - Init
    
    init(completion: ((_ successful: Bool) -> Void)?) {
        self.completion = completion
        self.callBackQueue = OperationQueue.current!
        
        super.init()
    }
    
    // MARK: - Main
    
    override func main() {
        super.main()
        
        sleep(2) //This is where this operation's actual work would be
        
        callBackQueue.addOperation {
            guard let completion = self.completion else {
                return
            }
            
            completion(true)
        }
    }
}
