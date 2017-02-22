//
//  Grocery+CoreDataProperties.swift
//  Grocery List
//
//  Created by Boshi Li on 2017/2/21.
//  Copyright © 2017年 devhubs. All rights reserved.
//

import Foundation
import CoreData


extension Grocery {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Grocery> {
        return NSFetchRequest<Grocery>(entityName: "Grocery");
    }

    @NSManaged public var item: String?

}
