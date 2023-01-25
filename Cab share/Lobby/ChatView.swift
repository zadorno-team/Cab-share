//
//  Chat.swift
//  Mail
//
//  Created by Marco Dell'Isola on 18/11/22.
//

import PhotosUI
import SwiftUI

struct ChatView: View {
    @State var selectedItems: [PhotosPickerItem] = []
    @State var data: Data?
    @State var send = false
    @FocusState private var nameIsFocused: Bool
    let emptyScrollToString = "Empty"
    @State private var input: String = ""
    @ObservedObject var mailData: MessageData = MessageData()
// I used this excamotage to have a good animation to the previous view,but could be better use the native back button
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    var body: some View {
        NavigationView {
            VStack {
                HStack {
                }
                .navigationBarItems(leading:
                                        Button {
                    presentationMode.wrappedValue.dismiss()
                } label: {Image(systemName: "chevron.left")
                    .foregroundColor(Color.blue)}
                                    , trailing: Button(action: {}) {
                    Image(systemName: "magnifyingglass")
                        .foregroundColor(Color.blue)
                })
                ScrollView {
                    ScrollViewReader { proxy in
                        VStack {
                            ForEach(mailData.mails) { mail in
                                MessageBubble(message: mail)
                                    .onAppear {
                                        withAnimation(.interpolatingSpring(stiffness: 200, damping: 5)) {}
                                    }
                            }
                            HStack { Spacer() }
                                .id(self.emptyScrollToString)
                        }
                        .onChange(of: send) { _ in
                            withAnimation(.easeOut(duration: 0.5)) {
                                proxy.scrollTo(self.emptyScrollToString, anchor: .bottom)
                            }
                        }
                    }
//                UIScrollView.appearance().keyboardDismissMode = .onDrag
                }.padding(.bottom, 10.0)
                    .scrollDismissesKeyboard(.immediately)
                HStack {
                    TextField("Message", text: $input)
                        .multilineTextAlignment(.leading)
                        .lineLimit(0)
                        .padding([.top, .leading, .bottom], 7.0)
                        .focused($nameIsFocused)
                    Button {
                      // Function to send message(append to the message list)
                        input = ""
                        nameIsFocused = false
                        send.toggle()
                    } label: {
                        if !input.isEmpty {
                            Image(systemName: "arrow.up.circle.fill")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 26, height: 26)
                                .foregroundColor(.blue)
                        }
                    }
                }.padding(.horizontal, 4.0)
                    .overlay(Capsule().stroke(.tertiary, lineWidth: 1).opacity(0.7)).padding([.horizontal, .bottom], 8)
            }
            // TOP TOOLBAR
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text("Chat")
                        .foregroundColor(.blue)
                }
            }
        }.navigationBarHidden(true)
    }
}

extension UINavigationController: UIGestureRecognizerDelegate {
    override open func viewDidLoad() {
        super.viewDidLoad()
        interactivePopGestureRecognizer?.delegate = self
    }
    public func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        return viewControllers.count > 1
    }
}

struct Chat_Previews: PreviewProvider {
    static var previews: some View {
        ChatView().environmentObject(MessageData())
    }
}
