# ApolloGraphqlDemo

1.	create new project Xcode

2.	add apollo client from apollo website using SPM(Swift Package Manager) (https://www.apollographql.com/docs/ios/get-started) (SPM link https://github.com/apollographql/apollo-ios.git)

3.	Select Apollo only when prompt to add package appear

4.	For Apollo iOS to generate models for your GraphQL operations, you need a local copy of your GraphQL server's schema. We can directly use these generated model in our project, we don’t need to create model by our own

5.	Create .graphql for operation, and .graphqls for schema

6.	create client and you are ready to hit


**How to generate code i.e.., swift file from schema and graphql file to use in swift**
1.	run command npm install -D apollo (to add as a dependency)
	but I recommend to add apollo as a global using npm install -g apollo

2. Download node js to support npm commands https://nodejs.org/en/download

3. Download tar file or clone the git or download the source code zip file from latest apollo iOS cli https://github.com/apollographql/apollo-ios/releases

4. Unzip this file and using terminal go to this folder and run make build-cli

5. This will compile the Codegen CLI which you will find at .build/release/apollo-ios-cli. You can run the CLI from this directory, move it to another location, or add it to your shell $path or your project or you can copy executable file into your directory (press command + shift + . to see the hidden folder)

6. Create codegen configuration file
./apollo-ios-cli init --schema-name StarWarsAPI --module-type swiftPackageManager

7. Run ./apollo-ios-cli generate to generate swift files

8. Now add these all generate scehma and swift files for query into your project using following steps


	1.	open project and click on top of your project and select project and Package Dependencies click + button -> in next window click on add local -> and navigate to generated schema and add it to your project
	<img width="1500" alt="Screenshot 2023-04-15 at 4 02 22 PM" src="https://user-images.githubusercontent.com/5785670/232208698-992103fa-fc99-423d-b302-afb19e12aca2.png">

	2.	Under targets -> General > Frameworks, Libraries, and Embedded Content click on + next window you must see seperate section of Workspace > Schema Name Api -> click on that and add it your project, if it doesn't display restart xcode once and try again.
<img width="1240" alt="Screenshot 2023-04-15 at 4 02 55 PM" src="https://user-images.githubusercontent.com/5785670/232208733-1354e524-caf4-47b5-ba5d-1f4d62918209.png">


Sample GraphqlApi https://rickandmortyapi.com/graphql
query {
  characters(page: 2, filter: { name: "rick" }) {
    info {
      count
    }
    results {
      name
    }
  }
  location(id: 1) {
    id
  }
  episodesByIds(ids: [1, 2]) {
    id
  }
}
https://rickandmortyapi.com/documentation/

**GraphQL Client or playground**
https://altairgraphql.dev/


