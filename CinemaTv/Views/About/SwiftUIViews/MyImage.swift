//
//  MyImage.swift
//  CinemaTv
//
//  Created by Danilo Requena on 06/02/21.
//  Copyright © 2021 Danilo Requena. All rights reserved.
//

import SwiftUI

struct MyImage: View {
    var body: some View {
        Image("about")
            .resizable()
            .frame(width: 80, height: 100, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
            .clipShape(Circle())
            .overlay(Circle().stroke(Color.white, lineWidth: 4))
            .shadow(radius: 7)
    }
}

struct MyImage_Previews: PreviewProvider {
    static var previews: some View {
        MyImage()
    }
}
