# 1.0.8
- feat: get translator info by uuid/user
- feat: get global/mod translate status
- feat: list model response
- feat: modify the time zone to UTC+0
- style: renamed `cosmic chat` to `universe chat`
- feat: support RPMTranslator APIs
- feat: support comment APIs
- feat: new http client
# 1.0.7+3
- feat: Added `onlyListenMessage` argument for `CosmicChatResource#onMessageSent` and `CosmicChatResource#connect`
- feat: Support to get the status of cosmic chat messages sent.
- docs: `CosmicChatMessage#getMessage`, `CosmicChatMessage#getInfo`
- feat: The time zone for sending cosmic chat messages changed to UTC+0
- docs: `User#avatarUrl`, `Storage#getDownloadUrl`, `StorageResource#getStorage`
# 1.0.7+2
- feat: reply message in cosmic chat (CosmicChatMessage#replyMessage)
- feat: implement CosmicChatMessage#getInfo
- feat: implement CosmicChatMessage#getByUUID
# 1.0.7+1
- feat: support cosmic chat 4.0 send a message and receive messages sent by other users
- docs: RPMTWApiClient#init, RPMTWApiClient#setGlobalToken
- feat: added RPMTWApiClient#cosmicChatBaseUrl for cosmic chat resource
- style: change RPMTWApiClient#baseUrl to RPMTWApiClient#apiBaseUrl
- docs: added docs for getUserByUUID, getUserByEmail, createUser
- docs: update repository meta
# 1.0.7
- Added helloWorld(),getIP() in OtherResource
- Added getMod() in CurseForgeResource
# 1.0.6+10
# Change RPMTWApiClient.lastInstance to RPMTWApiClient.instance
# 1.0.6+9
- ModSearchType renamed to ModSortType
# 1.0.6+8
- Supports filtering of change logs by user UUID and data UUID
# 1.0.6+7
- Fix WikiChangelog.unchangedData json serialization error
# 1.0.6+6
- Fix change log json serialization error
# 1.0.6+5
- Added changelog in RPMTWAPIClient.minecraftResource.editMinecraftMod
# 1.0.6+4
- Fixed image storage uuid error
# 1.0.6+3
- Added Storage.getDownloadUrl
# 1.0.6+2
- Support for editing mods and viewing changes to wiki change logs
# 1.0.6+1
- Added imageUrl
# 1.0.6
- Update the wiki mod data format to the new server format
# 1.0.5+5
- View count added to RPMWiki mod data
- Support for querying RPMWiki change logs 
# 1.0.5+4
- The exception ModelNotFoundException will be thrown when a model is not found.
# 1.0.5+3
- Fix serialized MinecraftMod json
# 1.0.5+2
- Fix the inability to create RPMTW Wiki data
# 1.0.5+1
- Fixing json serialization errors
# 1.0.5
- Fix a bug
# 1.0.4+10
- Add imageUrl getter in RPMWiki Mod data
- Add imageWidget in RPMWiki mod data
# 1.0.4+9
- Support for creating/viewing RPMWiki mod data
# 1.0.4+8
- Fixed not being able to get Minecraft mod information via UUID
# 1.0.4+7
- Support game version parameter change to string type
# 1.0.4+6
- Fix status parsing error when searching for mods
# 1.0.4+5
- Fix json parsing error when searching for mods
# 1.0.4+4
- Support for search mods
# 1.0.4+3
- Fixed some bugs in create mods
- Mod loaders can be added in a variety of ways (List)
# 1.0.4+2
- add mod loader field
# 1.0.4+1
- fix server url
# 1.0.4

- Deploy the server to api.rpmtw.com
# 1.0.3+4
- test
# 1.0.3+3
- minecraft mod id is changed to nullable
# 1.0.3+2

- New API for obtaining Minecraft version manifest

## 1.0.3+1

- Added UnauthorizedException 
- Create a minecraft mod
- Get minecraft m by uuid or mod id

## 1.0.3

- add global auth token
- get user info token option

## 1.0.2

- Support for changing user information
- Support for verifying email validation codes
- New initialization function
- New avatarUrl getter on user information
- User information will be sent back when creating an account
- Changed the network request library from dio to http

## 1.0.1+1

- fix a bug in dartjs

## 1.0.1

- fix big int (dartjs2)
## 1.0.0

- Initial version.