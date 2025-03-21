//
//  Order.swift
//  CupcakeCorner
//
//  Created by Taijaun Pitt on 18/03/2025.
//

import Foundation

@Observable
class Order: Codable {
    
    enum CodingKeys: String, CodingKey {
        case _type = "type"
        case _quantity = "quantity"
        case _specialRequestEnabled = "specialrequestEnabled"
        case _extraFrosting = "extraFrosting"
        case _addSprinkles = "addSprinkles"
        case _name = "name"
        case _city = "city"
        case _zip = "zip"
    }
    
    
    static let types = ["Vanilla", "Strawberry", "Chocolate", "Rainbow"]
    
    var type = 0
    var quantity = 3
    
    var specialRequestEnabled = false{
        // ensure toggles are off when toggled off
        didSet {
            if specialRequestEnabled == false {
                extraFrosting = false
                addSprinkles = false
            }
        }
    }
    
    var extraFrosting = false
    var addSprinkles = false
    
    var name = ""
    var streetAddress = ""
    var city = ""
    var zip = ""
    
    var hasValidAddress: Bool {
        if name.isEmpty || streetAddress.isEmpty || city.isEmpty || zip.isEmpty {
            return false
        }
        
        if name.isOnlyWhiteSpace || streetAddress.isOnlyWhiteSpace || city.isOnlyWhiteSpace || zip.isOnlyWhiteSpace {
            return false
        }
        
        
        
        return true
    }
    
    var cost: Decimal {
        // £2 per cake
        var cost = Decimal(quantity) * 2
        
        // compelx cakes cost more
        cost += Decimal(type) / 2
        
        // £1/cake for extra frosting
        if extraFrosting {
            cost += Decimal(quantity)
        }
        
        // £0.50/cake for sprinkles
        if addSprinkles {
            cost += Decimal(quantity)
        }
        
        return cost
    }
}
