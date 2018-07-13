//
//  AsyncOperation.swift
//  nsoperation-class
//
//  Created by Роман Мисников on 06.07.2018.
//  Copyright © 2018 Роман Мисников. All rights reserved.
//

import Foundation

class AsyncOperation: Operation {
    
    override var name: String? { get { return "Async Operation" } set {} }
    
    // create own status property which we can edit
    enum State: String {
        case ready, executing, finished
        fileprivate var keyPath: String {
            return "is" + rawValue.capitalized
        }
    }
    
    var state = State.ready {
        willSet {
            willChangeValue(forKey: state.keyPath) // send KVO notification
            willChangeValue(forKey: newValue.keyPath) // send KVO notification
        } didSet {
            didChangeValue(forKey: state.keyPath)
            didChangeValue(forKey: oldValue.keyPath)
            //print("❗️Operation status updated: from [\(oldValue)] to [\(state)]")
        }
    }
    
    // make operation async
    override var isAsynchronous: Bool { return true }
    override var isReady: Bool { return super.isReady && state == .ready }
    override var isExecuting: Bool { return state == .executing }
    override var isFinished: Bool { return state == .finished }
    
    override func start() {
        if isCancelled { state = .finished }
        else { main(); state = .executing }
    }
    
    override func cancel() {
        // send error notification with operation name
        guard let name = name else { return }
        error(operationName: name)
        super.cancel()
        state = .finished
    }
    
    func error(operationName: String) {
        let dict: [String: String] = ["operationName": operationName]
        let messWithObject = Notification(name:.init("OperationError"), object: nil, userInfo: dict)
        NotificationCenter.default.post(messWithObject)
    }

}
