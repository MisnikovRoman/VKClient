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
    
    // save occured error
    private var error: Error? = nil

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
        // get error
        guard let error = error else { return }
        // send notification
        notifyError(operationName: name, error: error)
        super.cancel()
        state = .finished
    }
    
    func cancel(with error: Error) {
        // save error
        self.error = error
        // call cancell function
        cancel()
    }
    
    func notifyError(operationName: String, error: Error) {
        let dict: [String: String] = ["operationName": operationName,
                                      "errorDescripton": error.localizedDescription]
        let messWithObject = Notification(name:.init("OperationError"), object: nil, userInfo: dict)
        NotificationCenter.default.post(messWithObject)
    }

}
