//
//  ContentView.swift
//  iScale
//
//  Created by Murakumo on 2019/10/20.
//  Copyright © 2019 YOKOYAMA. All rights reserved.
//

import SwiftUI

struct ContentView: View {
//    @State
    let scale: Scale
    
    static var dateFormatter: DateFormatter {
        let dateFormatter = DateFormatter()
        dateFormatter.timeStyle = .short
        dateFormatter.dateStyle = .short
        return dateFormatter
    }
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading) {
                    VStack {
                        // self scale
                        ScaleView(self.scale)
                        // divider
//                      Divider()
                        // sub scales
//                        List(self.scale.subScales) { scale in
                        ForEach(self.scale.subScales) { scale in
                            NavigationLink(destination: ContentView(scale)) {
                                SubScaleView(scale)
                            }
                            .accentColor(/*@START_MENU_TOKEN@*/.black/*@END_MENU_TOKEN@*/)
                        }
                    }
                }.padding()
            }
            .navigationBarTitle(Text(self.scale.title), displayMode: .inline)
            .navigationBarHidden(true)
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
    
    init(_ scale: Scale) {
        self.scale = scale
//        self._scale = State(initialValue: scale)
    }
}

struct ScaleView: View {
    let scale: Scale
    @State var summary: String
    
    var body: some View {
        VStack(alignment: .leading) {
            VStack(alignment: .leading) {
                Text(self.scale.title).font(.largeTitle)
                Text(ContentView.dateFormatter.string(from: self.scale.lastMod)).font(.subheadline)
            }.padding()
            Text(self.scale.summary).lineLimit(nil).padding()
        }.fixedSize(horizontal: false, vertical: true)
    }
    
    init(_ scale: Scale) {
        self.scale = scale
        _summary = State(initialValue: scale.summary)
    }
}

struct SubScaleView: View {
    let scale: Scale
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(self.scale.title).font(.title).padding()
            Text(self.scale.summary).lineLimit(nil).padding()
        }.fixedSize(horizontal: false, vertical: true)
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
