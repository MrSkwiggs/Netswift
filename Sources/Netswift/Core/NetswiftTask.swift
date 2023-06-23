//
//  NetswiftTask.swift
//  Netswift
//
//  Created by Dorian Grolaux on 08/12/2019.
//

import Foundation
#if canImport(FoundationNetworking)
import FoundationNetworking
#endif

public protocol NetswiftTask {
    
    /**
     Cancels the task.
     */
    func cancel()
}

extension URLSessionDataTask: NetswiftTask {}
