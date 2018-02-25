//
//  item.swift
//  todomap
//
//  Created by 森川彩音 on 2018/01/14.
//  Copyright © 2018年 森川彩音. All rights reserved.
//

import RealmSwift

class Item: Object{
    dynamic var name: String? = nil
    var ido: Double? = nil
    var keido:Double? = nil
}
