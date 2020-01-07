//
//  NetswiftTask.swift
//  Netswift
//
//  Created by Dorian Grolaux on 08/12/2019.
//

import Foundation

public protocol NetswiftTask {
    
    /**
     Cancels the task.
     */
    func cancel()
}

extension URLSessionDataTask: NetswiftTask {}
