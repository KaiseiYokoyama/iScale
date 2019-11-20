//
//  Scale.swift
//  iScale
//
//  Created by Murakumo on 2019/10/20.
//  Copyright © 2019 YOKOYAMA. All rights reserved.
//

import Foundation
import SwiftUI

// 文書スケール
class Scale: Identifiable {
    let uuid = UUID()
    
    /// readonly
    public private(set) var parent: Scale?
    
    public var title: String{
        didSet {
            updateLastMod()
        }
    }
    public var summary: String{
        didSet {
            updateLastMod()
        }
    }
    public var subScales: Array<Scale> {
        willSet(newSubScales) {
            for scale in newSubScales {
                scale.parent = self
            }
        }
        didSet {
            updateLastMod()
        }
    }
    public var tags: Set<String> {
        didSet {
            updateLastMod()
        }
    }
    /// 作成日
    public let created: Date
    /// 更新日
    public var lastMod: Date
    /// 非有効化
    public var disabled: Bool = false
    
    init() {
        self.title = "No Title"
        self.parent = nil
        self.summary = "No Summary"
        
        self.subScales = [];
        self.tags = [];

        let date = Date()
        self.created = date
        self.lastMod = date
    }
    
    init(_ parent: Scale,_ title: String,_ summary:String,_ subScales: [Scale]) {
        self.parent = parent
        self.title = title
        self.summary = summary
        self.subScales = subScales
        self.tags = [];

        let date = Date()
        self.created = date
        self.lastMod = date
    }
    
    convenience public init(_ parent: Scale) {
        self.init(parent,"","",[])
    }
}

extension Scale : Equatable{
    static func ==(left: Scale, right: Scale) -> Bool {
        return left === right
    }
}

// Behavior of tree structure
extension Scale {
    /// push subscale
    public func push(_ scale: Scale) {
        // rewrite scale.parent
        scale.parent = self;
        // push
        self.subScales.append(scale)
    }
    
    /// remove itself from parent
    /// returns itself (success) or nil (failed)
    public func remove() -> Scale? {
        if let parent = self.parent {
            if let  index = parent.subScales.firstIndex(of: self) {
                return parent.subScales.remove(at: index)
            }
        }
        
        return nil
    }
}

// Behavior of data
extension Scale {
    // todo setTitle, setSummary    
    public func descriptionTexts() -> Array<Text> {
        var texts :[Text] = [];
        for scale in self.subScales {
            // title
            let title = Text(scale.title).font(.title)
            texts.append(title)
            // summary
            let summary = Text(scale.summary).font(.body)
            texts.append(summary)
        }
        
        return texts;
    }
    
    private func updateLastMod() {
        self.lastMod = Date()
    }
}

extension Scale {
    public static func sampleScale() -> Scale {
        let scale = Scale()
        
        scale.title = "ポラーノの広場"
        scale.summary = "あのイーハトーヴォのすきとおった風、夏でも底に冷たさをもつ青いそら、うつくしい森で飾られたモリーオ市、郊外のぎらぎらひかる草の波。\n　またそのなかでいっしょになったたくさんのひとたち、ファゼーロとロザーロ、羊飼のミーロや、顔の赤いこどもたち、地主のテーモ、山猫博士のボーガント・デストゥパーゴなど、いまこの暗い巨きな石の建物のなかで考えていると、みんなむかし風のなつかしい青い幻燈のように思われます。では、わたくしはいつかの小さなみだしをつけながら、しずかにあの年のイーハトーヴォの五月から十月までを書きつけましょう。"
        scale.tags = ["draft", "debug"]
        
        return scale
    }
}
