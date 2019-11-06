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
    @State
    var subScales: [Scale] = []
    
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
                    ScaleView(self.scale)
                        .navigationBarTitle(Text(self.scale.title))
                    // sub scales
                    List {
                        ForEach(subScales) { (scale) in
                            NavigationLink(destination: ContentView(scale)) {
                                SubScaleView(scale)
                            }
                            .accentColor(.primary)
                        }
                        .onMove(perform: move)
                    }
                }
            }
        }
        .navigationBarTitle(Text(self.scale.title))
        .navigationViewStyle(StackNavigationViewStyle())
    }
    
    init(_ scale: Scale) {
        self.scale = scale
        self.subScales = scale.subScales
        self._subScales = State(initialValue: scale.subScales)

//        self._scale = State(initialValue: scale)
    }
    
    func move(from source: IndexSet, to destination: Int) {
        subScales.move(fromOffsets: source, toOffset: destination)
    }
}

struct ScaleView: View {
    let scale: Scale
    @State var summary: String
    
    var body: some View {
        VStack(alignment: .leading) {
            VStack(alignment: .leading) {
//                Text(self.scale.title).font(.largeTitle)
                Text(ContentView.dateFormatter.string(from: self.scale.lastMod)).font(.subheadline)
            }.padding()
            Text(self.scale.summary).lineLimit(nil).padding()
//            TextField(summary, text: $summary).lineLimit(nil)
        }.fixedSize(horizontal: false, vertical: true)
    }
    
    init(_ scale: Scale) {
        self.scale = scale
        _summary = State(initialValue: scale.summary)
    }
}

struct SubScaleView: View, Identifiable {
    let id = UUID()
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
