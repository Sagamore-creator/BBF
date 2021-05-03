//
//  Episode+CoreDataProperties.swift
//  
//
//  Created by Lech Lipnicki on 2021-05-03.
//
//

import Foundation
import CoreData


extension Episode {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Episode> {
        return NSFetchRequest<Episode>(entityName: "Episode")
    }

    @NSManaged public var episodeId: Int16
    @NSManaged public var title: String?
    @NSManaged public var season: String?
    @NSManaged public var airDate: String?
    @NSManaged public var episode: String?
    @NSManaged public var series: String?

}
