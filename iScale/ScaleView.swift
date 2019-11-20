//
//  ScaleView.swift
//  iScale
//
//  Created by Murakumo on 2019/11/18.
//  Copyright © 2019 YOKOYAMA. All rights reserved.
//

import SwiftUI

struct ScaleView: View {
    let scale: Scale
    @State var summary: String
    
    var body: some View {
        // (alignment: .leading)
        VStack(alignment: .leading) {
            HStack {
                ForEach(scale.tags.sorted(), id: \.self) { tag in
                    Text("#\(tag)")
                        .foregroundColor(Color.blue)
                }
            }
            .padding()
            Text(self.scale.summary)
                .lineLimit(nil)
                .padding()
        }
        .fixedSize(horizontal: false, vertical: true)
    }
    
    init(_ scale: Scale) {
        self.scale = scale
        _summary = State(initialValue: scale.summary)
    }
}


struct ScaleView_Previews: PreviewProvider {
    static var previews: some View {
        ScaleView(Scale.sampleScale())
            .previewDevice(PreviewDevice(rawValue: "iPad (6th generation)"))
    }
}
