//
//  Photo+CoreDataProperties.swift
//  Remember2Remember
//
//  Created by Chris Boshoff on 2022/05/25.
//
//

import Foundation
import CoreData


extension Photo {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Photo> {
        return NSFetchRequest<Photo>(entityName: "Photo")
    }

    @NSManaged public var images: NSData?

}

extension Photo : Identifiable {

}
