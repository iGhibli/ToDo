//
//  Logger.swift
//  ToDo
//
//  Created by iGhibli on 2020/12/7.
//

import Foundation

struct Logger {
    private static func _log<T>(_ title: String, _ msg: T, _ file: NSString,
                               _ fn: String, _ line: Int) {
        #if DEBUG
        print("「🐳SJLogger🐳」\(title) \(file.lastPathComponent) >> \(line) >> \(fn) ：\(msg)")
        #endif
    }
    
    static func error<T>(_ msg: T,
                         _ file: NSString = #file,
                         _ fn: String = #function,
                         _ line: Int = #line) {
        _log("❌", msg, file, fn, line)
    }
    
    static func warnning<T>(_ msg: T,
                         _ file: NSString = #file,
                         _ fn: String = #function,
                         _ line: Int = #line) {
        _log("⚠️", msg, file, fn, line)
    }
    
    static func success<T>(_ msg: T,
                         _ file: NSString = #file,
                         _ fn: String = #function,
                         _ line: Int = #line) {
        _log("✅", msg, file, fn, line)
    }
    
    static func info<T>(_ msg: T,
                         _ file: NSString = #file,
                         _ fn: String = #function,
                         _ line: Int = #line) {
        _log("📨", msg, file, fn, line)
    }
}
