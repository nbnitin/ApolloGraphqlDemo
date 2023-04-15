// @generated
// This file was automatically generated and should not be edited.

@_exported import ApolloAPI

public class GetCharsQuery: GraphQLQuery {
  public static let operationName: String = "GetChars"
  public static let document: ApolloAPI.DocumentType = .notPersisted(
    definition: .init(
      #"""
      query GetChars {
        characters(page: 2, filter: {name: "rick"}) {
          __typename
          info {
            __typename
            count
          }
          results {
            __typename
            name
          }
        }
        location(id: 1) {
          __typename
          id
        }
        episodesByIds(ids: [1, 2]) {
          __typename
          id
        }
      }
      """#
    ))

  public init() {}

  public struct Data: StarWarsAPI.SelectionSet {
    public let __data: DataDict
    public init(_dataDict: DataDict) { __data = _dataDict }

    public static var __parentType: ApolloAPI.ParentType { StarWarsAPI.Objects.Query }
    public static var __selections: [ApolloAPI.Selection] { [
      .field("characters", Characters?.self, arguments: [
        "page": 2,
        "filter": ["name": "rick"]
      ]),
      .field("location", Location?.self, arguments: ["id": 1]),
      .field("episodesByIds", [EpisodesById?]?.self, arguments: ["ids": [1, 2]]),
    ] }

    /// Get the list of all characters
    public var characters: Characters? { __data["characters"] }
    /// Get a specific locations by ID
    public var location: Location? { __data["location"] }
    /// Get a list of episodes selected by ids
    public var episodesByIds: [EpisodesById?]? { __data["episodesByIds"] }

    /// Characters
    ///
    /// Parent Type: `Characters`
    public struct Characters: StarWarsAPI.SelectionSet {
      public let __data: DataDict
      public init(_dataDict: DataDict) { __data = _dataDict }

      public static var __parentType: ApolloAPI.ParentType { StarWarsAPI.Objects.Characters }
      public static var __selections: [ApolloAPI.Selection] { [
        .field("__typename", String.self),
        .field("info", Info?.self),
        .field("results", [Result?]?.self),
      ] }

      public var info: Info? { __data["info"] }
      public var results: [Result?]? { __data["results"] }

      /// Characters.Info
      ///
      /// Parent Type: `Info`
      public struct Info: StarWarsAPI.SelectionSet {
        public let __data: DataDict
        public init(_dataDict: DataDict) { __data = _dataDict }

        public static var __parentType: ApolloAPI.ParentType { StarWarsAPI.Objects.Info }
        public static var __selections: [ApolloAPI.Selection] { [
          .field("__typename", String.self),
          .field("count", Int?.self),
        ] }

        /// The length of the response.
        public var count: Int? { __data["count"] }
      }

      /// Characters.Result
      ///
      /// Parent Type: `Character`
      public struct Result: StarWarsAPI.SelectionSet {
        public let __data: DataDict
        public init(_dataDict: DataDict) { __data = _dataDict }

        public static var __parentType: ApolloAPI.ParentType { StarWarsAPI.Objects.Character }
        public static var __selections: [ApolloAPI.Selection] { [
          .field("__typename", String.self),
          .field("name", String?.self),
        ] }

        /// The name of the character.
        public var name: String? { __data["name"] }
      }
    }

    /// Location
    ///
    /// Parent Type: `Location`
    public struct Location: StarWarsAPI.SelectionSet {
      public let __data: DataDict
      public init(_dataDict: DataDict) { __data = _dataDict }

      public static var __parentType: ApolloAPI.ParentType { StarWarsAPI.Objects.Location }
      public static var __selections: [ApolloAPI.Selection] { [
        .field("__typename", String.self),
        .field("id", StarWarsAPI.ID?.self),
      ] }

      /// The id of the location.
      public var id: StarWarsAPI.ID? { __data["id"] }
    }

    /// EpisodesById
    ///
    /// Parent Type: `Episode`
    public struct EpisodesById: StarWarsAPI.SelectionSet {
      public let __data: DataDict
      public init(_dataDict: DataDict) { __data = _dataDict }

      public static var __parentType: ApolloAPI.ParentType { StarWarsAPI.Objects.Episode }
      public static var __selections: [ApolloAPI.Selection] { [
        .field("__typename", String.self),
        .field("id", StarWarsAPI.ID?.self),
      ] }

      /// The id of the episode.
      public var id: StarWarsAPI.ID? { __data["id"] }
    }
  }
}
