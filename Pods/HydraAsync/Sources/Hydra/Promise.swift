/*
* Hydra
* Fullfeatured lightweight Promise & Await Library for Swift
*
* Created by:	Daniele Margutti
* Email:		hello@danielemargutti.com
* Web:			http://www.danielemargutti.com
* Twitter:		@danielemargutti
*
* Copyright © 2017 Daniele Margutti
*
*
* Permission is hereby granted, free of charge, to any person obtaining a copy
* of this software and associated documentation files (the "Software"), to deal
* in the Software without restriction, including without limitation the rights
* to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
* copies of the Software, and to permit persons to whom the Software is
* furnished to do so, subject to the following conditions:
*
* The above copyright notice and this permission notice shall be included in
* all copies or substantial portions of the Software.
*
* THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
* IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
* FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
* AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
* LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
* OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
* THE SOFTWARE.
*
*/

import Foundation

public class Promise<Value> {
	
	public typealias Resolved = (Value) -> ()
	public typealias Rejector = (Error) -> ()
	public typealias Body = ((_ resolve: @escaping (Value) -> (), _ reject: @escaping (Error) -> () ) throws -> ())

	/// State of the Promise. Initially a promise has a `pending` state.
	internal var state: State<Value> = .pending
	
	/// This is the queue used to ensure thread safety on Promise's `state`.
	internal let stateQueue = DispatchQueue(label: "com.mokasw.promise")
	
	/// Body of the promise.
	/// This define the real core of your async function.
	/// Promise's `body` is not executed until you chain an operator to it (ex. `.then` or `.catch`)
	private var body: Body?
	
	/// Context (GCD queue) in which the body of the promise is executed
	/// By default background queue is used.
	private(set) var context: Context = Context.custom(queue: DispatchQueue.global(qos: .background))
	
	/// Observers of the promise; define a callback called in specified context with the result of resolve/reject of the promise
	private var observers: [Observer<Value>] = []
	
	/// Is body of the promise called
	/// It's used to prevent multiple call of the body on operators chaining
	internal var bodyCalled: Bool = false
	
	/// Optional promise identifier
	public var name: String?
	
	/// Thread safe current result of the promise.
	/// It contains a valid value only if promise is resolved, otherwise it's `nil`.
	public var result: Value? {
		return stateQueue.sync {
			return self.state.value
		}
	}
	
	/// Thread safe current error of the promise.
	/// It contains the error of the promise if it's currently in a `rejected` state, otherwise it's `nil`.
	public var error: Error? {
		return stateQueue.sync {
			return self.state.error
		}
	}
	
	/// Thread safe property which return if the promise is currently in a `pending` state.
	/// A pending promise it's a promise which is not resolved yet.
	public var isPending: Bool {
		return stateQueue.sync {
			return self.state.isPending
		}
	}
	
	
	/// Thread safe property which return if `body` of the promise is already called or not.
	private var isBodyExecuted: Bool {
		return stateQueue.sync {
			return self.bodyCalled
		}
	}
	
	
	/// Initialize a new Promise in a resolved state with given value.
	///
	/// - Parameter value: value to set
	public init(resolved value: Value) {
		self.state = .resolved(value)
		self.bodyCalled = true
	}
	
	
	/// Initialize a new Promise in a rejected state with a specified error
	///
	/// - Parameter error: error to set
	public init(rejected error: Error) {
		self.state = .rejected(error)
		self.bodyCalled = true
	}
	
	
	/// Initialize a new Promise which specify a `body` to execute in specified `context`.
	/// A `context` is a Grand Central Dispatch queue which allows you to control the QoS of the execution
	/// and the thread in which it must be executed in.
	///
	/// - Parameters:
	///   - context: context in which the body of the promise is executed. If `nil` global background queue is used instead
	///   - body: body of the promise, define the code executed by the promise itself.
	public init(in context: Context? = nil, _ body: @escaping Body) {
		self.state = .pending
		self.context = context ?? Context.custom(queue: DispatchQueue.global(qos: .background))
		self.body = body
	}
	
	/// Deallocation cleanup
	deinit {
		stateQueue.sync {
			self.observers.removeAll()
		}
	}
	
	/// Run the body of the promise if necessary
	/// In order to be runnable, the state of the promise must be pending and the body itself must not be called another time.
	internal func runBody() {
		self.stateQueue.sync {
			if state.isPending == false || bodyCalled == true {
				return
			}
			bodyCalled = true
			
			// execute the body into given context's gcd queue
			self.context.queue.async {
				do {
					// body can throws and fail. throwing a promise's body is equal to
					// reject it with the same error.
					try self.body?( { value in
						self.set(state: .resolved(value)) // resolved
					}, { err in
						self.set(state: .rejected(err)) // rejected
					})
				} catch let err {
					self.set(state: .rejected(err)) // rejected (using throw)
				}
			}
		}
	}
	
	/// Thread safe Promise's state change function.
	/// Once the state did change all involved registered observer will be called.
	///
	/// - Parameter newState: new state to set
	private func set(state newState: State<Value>) {
		self.stateQueue.sync {
			// a promise state can be changed only if the current state is pending
			// once resolved or rejected state cannot be change further.
			guard self.state.isPending else {
				return
			}
			self.state = newState // change state
			
			self.observers.forEach { observer in
				switch (state, observer) {
				case (.resolved(let value), .onResolve(_,_)):
					observer.call(andResolve: value)
				case (.rejected(let error), .onReject(_,_)):
					observer.call(andReject: error)
				default:
					break
				}
			}
		}
	}
	
	
	/// Allows to register two observers for resolve/reject.
	/// A promise's observer is called when a promise's state did change.
	/// If promise's state did change to `rejected` only observers registered for `rejection` are called; viceversa
	/// if promise's state did change to `resolved` only observers registered for `resolve` are called.
	///
	/// - Parameters:
	///   - context: context in which specified resolve/reject observers is called
	///   - onResolve: observer to add for resolve
	///   - onReject: observer to add for
	internal func add(in context: Context? = nil, onResolve: @escaping Observer<Value>.ResolveObserver, onReject: @escaping Observer<Value>.RejectObserver) {
		let ctx = context ?? .background
		let onResolve = Observer<Value>.onResolve(ctx, onResolve)
		let onReject = Observer<Value>.onReject(ctx, onReject)
		self.add(observers: onResolve, onReject)
	}
	
	
	/// Allows to register promise's observers.
	/// A promise's observer is called when a promise's state did change.
	/// You can create an observer called when promise did resolve (`Observer<Value>.ResolveObserver`) or reject
	/// (`Observer<Value>.RejectObserver`).
	/// Each registered observer can be called in a specified context.
	///
	/// - Parameter observers: observers to register
	internal func add(observers: Observer<Value>...) {
		self.stateQueue.sync {
			self.observers.append(contentsOf: observers)
			switch self.state {
			case .pending:
				break
			case .resolved(let value):
				self.observers.forEach({ observer in
					if case .onResolve(_,_) = observer {
						observer.call(andResolve: value)
					}
				})
			case .rejected(let err):
				self.observers.forEach({ observer in
					if case .onReject(_,_) = observer {
						observer.call(andReject: err)
					}
				})
			}
		}
	}

	
	/// Transform given promise to a void promise
	///
	/// - Returns: promise
	internal func voidPromise() -> Promise<Void> {
		return self.then { _ in
			return ()
		}
	}
	
	/// Reset the state of the promise
	internal func resetState() {
		self.stateQueue.sync {
			self.bodyCalled = false
			self.state = .pending
		}
	}
}
