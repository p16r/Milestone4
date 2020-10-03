//
//  ContentView.swift
//  Friendface
//
//  Created by Prathamesh Kowarkar on 28/09/20.
//

import SwiftUI

struct ContentView: View {

    @Environment(\.managedObjectContext) var context
    @State var result: Result<[User], Error> = .success([])
    @FetchRequest(entity: UserEntity.entity(), sortDescriptors: []) var userEntities: FetchedResults<UserEntity>

    private static let url: URL = {
        let string = "https://www.hackingwithswift.com/samples/friendface.json"
        return URL(string: string)!
    } ()

    var body: some View {
        NavigationView {
            ResultView(result: result) { users in
                List(users) { user in
                    NavigationLink(destination: UserView(user: user, users: users)) {
                        Text(user.name)
                    }
                }
            } failureContent: { error in
                VStack {
                    Text(error.localizedDescription)
                    Button("Retry", action: fetchData)
                }
            }
            .navigationBarTitle("Friendface")
        }
        .onAppear(perform: fetchData)
    }

    func fetchData() {
        URLSession.shared.dataTask(with: Self.url) { data, response, error in
            if let error = error { return result = .failure(error) }
            guard let data = data else { return result = .failure(URLError(.unknown)) }
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .iso8601
            decoder.userInfo[.managedObjectContext] = context
            result = Result { try decoder.decode([User].self, from: data) }
            context.perform {
                do {
                    _ = try decoder.decode([UserEntity].self, from: data)
                    try context.save()
                } catch {
                    print(error)
                }
            }
        }
        .resume()
    }

}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
