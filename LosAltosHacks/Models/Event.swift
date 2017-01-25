//
//  Event.swift
//  LosAltosHacks
//
//  Created by Kyle Sandell on 1/7/16.
//  Copyright © 2016 Dan Appel. All rights reserved.
//

import Foundation

struct Event {
    let event: String
    let location: String
    let time: Date
    let tag: Tag

    static var delegates = [CacheableDelegate]()
}

extension Event: Cacheable {
    static var cacheKey: String {
        return "eventsCache"
    }
}

extension Event: JSONConvertible {
    var asJSON: [String:Any] {
        return [
            "event": event as AnyObject,
            "time": time.timeIntervalSince1970 as AnyObject,
            "location": location as AnyObject,
            "tag": tag.rawValue as AnyObject
        ]
    }

    init(json: Any) {
        let json = json as! [String:Any]

        self = Event(
            event: json["event"] as! String,
            location: json["location"] as! String,
            time: Date(timeIntervalSince1970: TimeInterval((json["time"]! as AnyObject).int32Value)),
            tag: Tag(rawValue: (json["tag"] as! String).lowercased())!
        )
    }
}

extension Event: Sortable {
    static func sort(_ items: [Event]) -> [Event] {
         return items.sorted { $0.time.isEarlierThanDate($1.time) }
    }
}

extension Event {
    var isOnSaturday: Bool {
        return self.time.isEarlierThanDate(.sunday)
    }
    
    var isOnSunday: Bool {
        return !self.time.isEarlierThanDate(.sunday)
    }
}

extension Sequence where Iterator.Element == Event {
    var onSaturday: [Event] {
        return self.filter { $0.isOnSaturday }
    }
    
    var onSunday: [Event] {
        return self.filter { $0.isOnSunday }
    }
}
