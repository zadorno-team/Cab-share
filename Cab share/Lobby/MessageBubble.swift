//
//  MessageBubble.swift
//  Mail
//
//  Created by Marco Dell'Isola on 17/11/22.
//

import SwiftUI

struct MessageBubble: View {
    var message: Message
    var body: some View {
        VStack(alignment: message.received ? .trailing : .leading) {
            HStack {
                Text(message.timestamp, style: .date)+Text(" ")+Text(message.timestamp, style: .time)
            }.foregroundColor(.gray)
                .frame(maxWidth: .infinity)
                .multilineTextAlignment(.center)
            VStack(alignment: message.received ? .trailing : .leading) {
                Text(message.text)
                    .multilineTextAlignment(.leading)
                    .padding()
                    .foregroundColor(.white)
            }
            .background(message.received ? Color.blue : Color(#colorLiteral(red: 0.2346601486, green: 0.2346601486, blue: 0.2346601486, alpha: 1)))
            .cornerRadius(30)
            .frame(maxWidth: 320, alignment: message.received ? .trailing : .leading)
        }.frame(maxWidth: .infinity)
            .padding(10)
            .preferredColorScheme(.dark)
    }
}

struct MessageBubble_Previews: PreviewProvider {
    static var previews: some View {
        MessageBubble(message: MessageData().mails[0]).environmentObject(MessageData())
    }
}
