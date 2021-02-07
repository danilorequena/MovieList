//
//  SocialViews.swift
//  CinemaTv
//
//  Created by Danilo Requena on 06/02/21.
//  Copyright © 2021 Danilo Requena. All rights reserved.
//

import SwiftUI

struct SocialViews: View {
    @Environment(\.openURL) var openURL
    var body: some View {
        HStack {
            Button(action: {
                print("twitter")
                openURL(URL(string: "https://twitter.com/nilodobi")!)
            }) {
                Image("twitter")
                    .resizable()
                    .frame(width: 50, height: 50)
                    .padding(.trailing, 26)
            }
            
            Button(action: {
                print("github")
                openURL(URL(string: "https://github.com/danilorequena")!)
            }) {
            Image("github")
                .resizable()
                .frame(width: 50, height: 50)
            }
            Button(action: {
                print("linkedin")
                openURL(URL(string: "https://www.linkedin.com/in/danilorequena/")!)
            }) {
            Image("linkedin")
                .resizable()
                .frame(width: 50, height: 50)
                .padding(.leading, 26)
            }
        }
    }
}

struct SocialViews_Previews: PreviewProvider {
    static var previews: some View {
        SocialViews()
    }
}
