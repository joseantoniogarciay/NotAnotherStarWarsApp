//
//  Kommander.swift
//  Kommander
//
//  Created by Alejandro Ruperez Hernando on 26/1/17.
//  Copyright © 2017 Intelygenz. All rights reserved.
//

import Foundation

open class Kommander {

    /// Deliverer
    private final let deliverer: Dispatcher
    /// Executor
    private final let executor: Dispatcher

    /// Kommander instance with CurrentDispatcher deliverer and default Dispatcher executor
    public convenience init() {
        self.init(deliverer: nil, executor: nil)
    }

    /// Kommander instance with CurrentDispatcher deliverer and your executor
    public convenience init(executor: Dispatcher) {
        self.init(deliverer: nil, executor: executor)
    }

    /// Kommander instance with your deliverer and default Dispatcher executor
    public convenience init(deliverer: Dispatcher) {
        self.init(deliverer: deliverer, executor: nil)
    }

    /// Kommander instance with your deliverer and your executor
    public init(deliverer: Dispatcher?, executor: Dispatcher?) {
        self.deliverer = deliverer ?? CurrentDispatcher()
        self.executor = executor ?? Dispatcher()
    }

    /// Kommander instance with CurrentDispatcher deliverer and custom OperationQueue executor
    public convenience init(name: String?, qos: QualityOfService?, maxConcurrentOperationCount: Int) {
        self.init(deliverer: nil, name: name, qos: qos, maxConcurrentOperationCount: maxConcurrentOperationCount)
    }

    /// Kommander instance with CurrentDispatcher deliverer and custom DispatchQueue executor
    public convenience init(name: String?, qos: DispatchQoS?, attributes: DispatchQueue.Attributes?, autoreleaseFrequency: DispatchQueue.AutoreleaseFrequency?, target: DispatchQueue?) {
        self.init(deliverer: nil, name: name, qos: qos, attributes: attributes, autoreleaseFrequency: autoreleaseFrequency, target: target)
    }

    /// Kommander instance with your deliverer and custom OperationQueue executor
    public init(deliverer: Dispatcher?, name: String?, qos: QualityOfService?, maxConcurrentOperationCount: Int) {
        self.deliverer = deliverer ?? CurrentDispatcher()
        executor = Dispatcher(name: name, qos: qos, maxConcurrentOperationCount: maxConcurrentOperationCount)
    }

    /// Kommander instance with your deliverer and custom DispatchQueue executor
    public init(deliverer: Dispatcher?, name: String?, qos: DispatchQoS?, attributes: DispatchQueue.Attributes?, autoreleaseFrequency: DispatchQueue.AutoreleaseFrequency?, target: DispatchQueue?) {
        self.deliverer = deliverer ?? CurrentDispatcher()
        executor = Dispatcher(label: name, qos: qos, attributes: attributes, autoreleaseFrequency: autoreleaseFrequency, target: target)
    }

    /// Build Kommand<T> instance with an actionBlock returning generic and throwing errors
    open func makeKommand<T>(_ actionBlock: @escaping () throws -> T) -> Kommand<T> {
        return Kommand<T>(deliverer: deliverer, executor: executor, actionBlock: actionBlock)
    }

    /// Build [Kommand<T>] instances collection with actionBlocks returning generic and throwing errors
    open func makeKommands<T>(_ actionBlocks: [() throws -> T]) -> [Kommand<T>] {
        var kommands = [Kommand<T>]()
        for actionBlock in actionBlocks {
            kommands.append(Kommand<T>(deliverer: deliverer, executor: executor, actionBlock: actionBlock))
        }
        return kommands
    }

    /// Execute [Kommand<T>] instances collection concurrently or sequentially
    open func execute<T>(_ kommands: [Kommand<T>], concurrent: Bool = true, waitUntilFinished: Bool = false) {
        let blocks = kommands.map { kommand -> () -> Void in
            return {
                do {
                    let result = try kommand.actionBlock()
                    _ = self.deliverer.execute {
                        kommand.successBlock?(result)
                    }
                } catch {
                    _ = self.deliverer.execute {
                        kommand.errorBlock?(error)
                    }
                }
            }
        }
        let actions = executor.execute(blocks, concurrent: concurrent, waitUntilFinished: waitUntilFinished)
        for (index, kommand) in kommands.enumerated() {
            kommand.action = actions[index]
        }
    }

    /// Cancel [Kommand<T>] instances collection
    open func cancel<T>(_ kommands: [Kommand<T>]) {
        for kommand in kommands {
            kommand.cancel()
        }
    }

}
