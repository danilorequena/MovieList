//
//  NewAbout.swift
//  CinemaTv
//
//  Created by Danilo Requena on 06/02/21.
//  Copyright © 2021 Danilo Requena. All rights reserved.
//

import SwiftUI

struct NewAbout: View {
    @State private var isActive = false
    var body: some View {
        NavigationView {
            VStack {
                MyImage()
                Spacer(minLength: 45)
                Divider()
                VStack {
                    VStack(alignment: .leading) {
                        Text("About")
                            .multilineTextAlignment(.center)
                            .font(.title)
                            .foregroundColor(.pink)
                            .padding(.bottom)
                        
                        Text("Olá eu me chamo Danilo, esse app é para pessoas que querem buscar por informações sobre o filme ou Série que está no ar, ou mais votadas, ou mesmo descobrir novos filmes e  séries que ainda não conhecia. \nEspero que gostem e estou sempre aberto a sugestões através dos contatos que estão aqui ")
                            .font(.subheadline)
                    }
                    .padding(.horizontal)
                    Spacer()
                }
                VStack() {
                    Text("Social")
                        .font(.headline)
                    HStack {
                        SocialViews()
                        NavigationLink(
                            destination: ListMoviesSwiftUI(),
                            isActive: self.$isActive,
                            label: {
                                Image("swiftui")
                                    .resizable()
                                    .frame(width: 50, height: 50)
                                    .padding(.leading, 26)
                            })
                    }
                }
            }
            .padding(.bottom, 200)
        }
    }
    
}

struct NewAbout_Previews: PreviewProvider {
    static var previews: some View {
        NewAbout()
    }
}
