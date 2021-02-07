//
//  SocialViews.swift
//  CinemaTv
//
//  Created by Danilo Requena on 06/02/21.
//  Copyright © 2021 Danilo Requena. All rights reserved.
//

import SwiftUI

struct SocialViews: View {
    var body: some View {
        HStack {
            Image("twitter")
                .resizable()
                .frame(width: 50, height: 50)
                .padding(.trailing, 26)
            Image("github")
                .resizable()
                .frame(width: 50, height: 50)
            Image("linkedin")
                .resizable()
                .frame(width: 50, height: 50)
                .padding(.leading, 26)
        }
    }
}

struct SocialViews_Previews: PreviewProvider {
    static var previews: some View {
        SocialViews()
    }
}
