//
//  ContentView.swift
//  iScale
//
//  Created by Murakumo on 2019/10/20.
//  Copyright © 2019 YOKOYAMA. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    let scale: Scale
    
    static var dateFormatter: DateFormatter {
        let dateFormatter = DateFormatter()
        dateFormatter.timeStyle = .short
        dateFormatter.dateStyle = .short
        return dateFormatter
    }
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                VStack {
                    // self scale
                    ScaleView(self.scale)
                    // divider
//                    Divider()
                    // sub scales
                    ForEach(self.scale.subScales) { scale in
                        SubScaleView(scale)
                    }
                }
            }.padding()
        }
    }
    
    init(_ scale: Scale) {
        self.scale = scale
    }
}

struct ScaleView: View {
    let scale: Scale
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(self.scale.title).font(.largeTitle)
            Text(ContentView.dateFormatter.string(from: self.scale.lastMod)).font(.subheadline)
            Text(self.scale.summary).lineLimit(nil).padding()
        }.fixedSize(horizontal: false, vertical: true).padding()
    }
    
    init(_ scale: Scale) {
        self.scale = scale
    }
}

struct SubScaleView: View {
    let scale: Scale
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(self.scale.title).font(.title)
            Text(self.scale.summary).lineLimit(nil).padding()
        }.fixedSize(horizontal: false, vertical: true).padding()
    }
    
    init(_ scale: Scale) {
        self.scale = scale
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        // get sample scale
        let scale = Scale.sampleScale()
        for _ in 1...5 {
            scale.push(Scale.sampleScale())
        }

        return ContentView(scale).previewDevice(PreviewDevice(rawValue: "iPad (6th generation)"))
    }
}
