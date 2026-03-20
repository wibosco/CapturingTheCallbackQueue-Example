//
//  CapturingQueueExample.swift
//  CapturingTheCallbackQueue-Example
//
//  Created by William Boles on 20/03/2026.
//  Copyright © 2026 William Boles. All rights reserved.
//

import Foundation

class CapturingQueueExample {
    func performWork(callbackQueue: DispatchQueue = .main,
                     completion: @escaping (Result<String, Error>) -> Void) {
        DispatchQueue.global().async {
            sleep(2)

            callbackQueue.async {
                completion(.success("Done"))
            }
        }
    }
}
