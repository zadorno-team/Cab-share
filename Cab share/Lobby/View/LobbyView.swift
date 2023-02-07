//
//  LobbyGroupView.swift
//  Cab share
//
//  Created by Marco Dell'Isola on 23/01/23.
//
import SwiftUI
import MapKit

struct LobbyView: View {
    @State var lobbyInformation: LobbyDetails
    var body: some View {
        NavigationView {
            ScrollView {
                VStack {
                    MapView(latitude: $lobbyInformation.latitude, longitude: $lobbyInformation.longitude)
                        .frame(width: 350, height: 200)
                        .cornerRadius(25)
                    HStack {
                        ForEach(lobbyInformation.users, id:\.self) { user in
                            Button {
#warning("TODO: Fill with a variable that open a sheet that shows the user's profile")
                            } label: {
#warning("TODO: Implement something that takes the image of the user that has to be shown here (through the user's id into this array")
                                Image("noimage")
                                    .resizable()
                                    .frame(width: 50, height: 50)
                                    .cornerRadius(25)
                                    .padding(10)
                            }
                        }
                    }
                    HStack {
                        Image(systemName: "mappin.circle.fill")
                            .resizable()
                            .frame(width: 30, height: 30)
                        Text(lobbyInformation.placemark)
                            .foregroundColor(.white)
                            .font(.system(size: 18))
                            .padding(.leading, 10)
                        Spacer()
                    }.padding()
                        .padding(.leading, 10)
                    HStack {
                        Image(systemName: "clock.fill")
                            .resizable()
                            .frame(width: 30, height: 30)
                        Text(lobbyInformation.hour)
                            .foregroundColor(.white)
                            .font(.system(size: 18))
                            .padding(.leading, 10)
                        Spacer()
                    }.padding(.leading, 25)
                        .padding(.bottom)
                    HStack {
                        Image(systemName: "person.fill")
                            .resizable()
                            .frame(width: 30, height: 30)
                        Text(lobbyInformation.numUsers)
                            .foregroundColor(.white)
                            .font(.system(size: 18))
                            .padding(.leading, 10)
                        Spacer()
                    }.padding(.leading, 25)
                        .padding(.bottom)
                    HStack {
                        Image(systemName: "car.fill")
                            .resizable()
                            .frame(width: 30, height: 25)
                        Text(lobbyInformation.namePlate)
                            .foregroundColor(.white)
                            .font(.system(size: 18))
                            .padding(.leading, 10)
                        Spacer()
                    }.padding(.leading, 25)
                        .padding(.bottom)
                    HStack {
                        Image(systemName: "creditcard.fill")
                            .resizable()
                            .frame(width: 30, height: 23)
                        Text(lobbyInformation.price)
                            .foregroundColor(.white)
                            .font(.system(size: 18))
                            .padding(.leading, 10)
                        Spacer()
                    }.padding(.leading, 25)
                    NavigationLink(destination: ChatView(), label: {
                        Text("Chat with the group")
                            .foregroundColor(.white)
                    }).frame(width: 350, height: 50)
                        .background(.blue)
                        .cornerRadius(25)
                        .padding()
                        .padding(.top, 40)
                }.navigationTitle("Lobby")
            }
//            .navigationBarItems(trailing: NavigationLink(destination: , isActive: isQuitted, label: Text("Quit")))
        }.preferredColorScheme(.dark)
    }
}

//struct LobbyGroupView_Previews: PreviewProvider {
//    static var previews: some View {
//        // swiftlint:disable all
//        LobbyView(lobbyInformation: LobbyDetails(date: date, latitude: CLLocationDegrees(51.507359), longitude: CLLocationDegrees(-0.136439), placemark: "London", users: ["","",""], hour: "2.30 PM", numUsers: "4/4", namePlate: "CG234SF", price: "3.99$"))
//    }
//}
