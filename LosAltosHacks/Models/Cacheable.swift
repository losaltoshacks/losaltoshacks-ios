//
//  Cacheable.swift
//  LosAltosHacks
//
//  Created by Dan Appel on 1/19/16.
//  Copyright © 2016 Dan Appel. All rights reserved.
//

import Foundation

protocol Cacheable: JSONConvertible {
    static var cacheKey: String {get}
    static func cached() -> [Self]?
    static func store(cache: [Self])
    static func clear()
    static var delegates: [CacheableDelegate] {get}
}

protocol CacheableDelegate {
    func didUpdateCache()
}

extension Cacheable {
    
    static var delegates: [CacheableDelegate] { return [] }
    
    static func cached() -> [Self]? {
        
        // get json string from cache
        guard let cacheJsonString = NSUserDefaults.standardUserDefaults().stringForKey(cacheKey) else { return nil }
        
        // turn json string into nsdata
        guard let jsonData = cacheJsonString.dataUsingEncoding(NSUTF8StringEncoding) else { return nil }
        
        // turn json data into a json object
        guard let jsonObj = try? NSJSONSerialization.JSONObjectWithData(jsonData, options: .AllowFragments) else { return nil }
        
        // turn json object into array of json strings
        guard let jsonArr = jsonObj as? [String] else { return nil }
        
        // parse each json string into a "Self"
        // using the do/catch as an early return
        do {
            let items: [Self] = try jsonArr.map {
                let data = $0.dataUsingEncoding(NSUTF8StringEncoding)!
                let json = try NSJSONSerialization.JSONObjectWithData(data, options: .AllowFragments)
                return Self.parse(json)
            }
            return items
        } catch {
            return nil
        }
    }
    
    static func store(cache: [Self]) {
        
        // turn each into a json string
        let json = cache.map { $0.toJSON() }
        
        // should just be an array of strings, so force the try
        let jsonObj = try! NSJSONSerialization.dataWithJSONObject(json, options: .PrettyPrinted)
        let jsonString = String(data: jsonObj, encoding: NSUTF8StringEncoding)
        
        NSUserDefaults.standardUserDefaults().setObject(jsonString, forKey: cacheKey)
        NSUserDefaults.standardUserDefaults().synchronize()
        
        delegates.forEach { $0.didUpdateCache() }
    }
    
    static func clear() {
        NSUserDefaults.standardUserDefaults().setObject(nil, forKey: cacheKey)
        NSUserDefaults.standardUserDefaults().synchronize()
    }
}

extension Cacheable where Self: Sortable {
    static func cached(sort sort: Bool) -> [Self]? {
        guard let cached = cached() else { return nil }
        guard sort else { return cached }
        return Self.sort(cached)
    }
}
