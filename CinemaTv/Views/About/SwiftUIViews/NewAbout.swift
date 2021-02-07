//
//  NewAbout.swift
//  CinemaTv
//
//  Created by Danilo Requena on 06/02/21.
//  Copyright © 2021 Danilo Requena. All rights reserved.
//

import SwiftUI

struct NewAbout: View {
    var body: some View {
        VStack {
            Spacer()
            MyImage()
            
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
                SocialViews()
            }
        }
        .padding(.bottom, 280)
    }
    
}

struct NewAbout_Previews: PreviewProvider {
    static var previews: some View {
        NewAbout()
    }
}
